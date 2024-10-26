import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/functions/snackbar_function.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/copy_task_cubit/copy_task_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/task_settings_cubit/task_settings_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/todo_cubit.dart';
import 'package:files_manager/cubits/update_task_cubit/update_task_cubit.dart';
import 'package:files_manager/cubits/user_complete_task_cubit/user_complete_task_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/task_model.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';

import '../../core/animation/dialogs/dialogs.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({
    super.key,
    required this.taskModel,
    required this.boardCubit,
    required this.todoCubit,
  });
  final TaskModel taskModel;
  final BoardCubit boardCubit;
  final TodoCubit todoCubit;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final taskSettingsCubit = context.read<TaskSettingsCubit>();
    final updateTaskCubit = context.read<UpdateTaskCubit>();
    final userCompleteTaskCubit = context.read<UserCompleteTaskCubit>();
    final copyTaskCubit = context.read<CopyTaskCubit>();
    final String myId = CashNetwork.getCashData(key: 'id');
    return BlocConsumer<TaskSettingsCubit, TaskSettingsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width / 20,
                vertical: mediaQuery.height / 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      S.of(context).users,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    taskModel.users.isEmpty
                        ? const SizedBox()
                        : IconButton(
                            onPressed: () async {
                              taskSettingsCubit.showAllMembers();
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              // size: mediaQuery.width / 14,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.height / 190,
                ),
                taskModel.users.isNotEmpty
                    ? Column(
                        children: List.generate(
                          taskModel.users.length,
                          (index) {
                            return ListTile(
                              leading: memberWidget(
                                memberName: taskModel.users[index].name,
                                mediaQuery: mediaQuery,
                                index: index,
                                taskModel: taskModel,
                              ),
                              title: Text(
                                taskModel.users[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: BlocConsumer<UserCompleteTaskCubit,
                                  UserCompleteTaskState>(
                                listener: (context, state) {
                                  if (state is UserCompleteTaskSuccessState) {
                                    Navigator.pop(context);
                                  } else if (state
                                      is UserCompleteTaskLoadingState) {
                                    loadingDialog(
                                        context: context,
                                        mediaQuery: mediaQuery,
                                        title: '');
                                  } else if (state
                                      is UserCompleteTaskFailedState) {
                                    errorDialog(
                                        context: context,
                                        text: state.errorMessage);
                                  } else if (state
                                      is UserCompleteTaskExpiredState) {
                                    showExpiredDialog(
                                      context: context,
                                      onConfirmBtnTap: () async {
                                        await CashNetwork.clearCash();
                                        await Hive.box('main').clear();
                                        Phoenix.rebirth(context);
                                      },
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return Checkbox(
                                    activeColor: Colors.white,
                                    checkColor: AppColors.dark,
                                    value: taskModel.users[index].completed,
                                    onChanged: (value) async {
                                      //TODO Add Condidtion
                                      if (myId !=
                                          taskModel.users[index].id
                                              .toString()) {
                                        return showLightSnackBar(
                                            context,
                                            S
                                                .of(context)
                                                .you_cannot_change_the_status_of_that_task);
                                      } else {
                                        userCompleteTaskCubit
                                            .userUserCompleteTask(
                                          context: context,
                                          userTaskModel: taskModel.users[index],
                                          value: value!,
                                          taskId: taskSettingsCubit.taskModel.id
                                              .toString(),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          taskSettingsCubit.showAllMembers();
                        },
                        child: Wrap(
                            children: List.generate(
                          taskModel.users.length + 1,
                          (index) {
                            return index == 0
                                ? Icon(
                                    Icons.add_circle,
                                    size: mediaQuery.width / 9,
                                  )
                                : memberWidget(
                                    index: index,
                                    taskModel: taskModel,
                                    memberName: taskModel.users[index - 1].name,
                                    mediaQuery: mediaQuery,
                                  );
                          },
                        )),
                      ),
                taskSettingsCubit.showMembers
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: mediaQuery.height / 100,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaQuery.width / 20),
                            child: Text(
                              S.of(context).select_users,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: List.generate(
                              boardCubit.currentBoard.members.length,
                              (index) {
                                return ListTile(
                                  onTap: () async {
                                    if (boardCubit.currentBoard.members[index]
                                            .status ==
                                        'loading') {
                                      return;
                                    }
                                    if (taskModel.users.indexWhere((element) =>
                                            element.id ==
                                            boardCubit.currentBoard
                                                .members[index].id) !=
                                        -1) {
                                      await taskSettingsCubit
                                          .removeMemberFromTask(
                                              boardCubit
                                                  .currentBoard.members[index],
                                              context);
                                    } else {
                                      await taskSettingsCubit.addMemberToTask(
                                          boardCubit
                                              .currentBoard.members[index],
                                          context);
                                    }
                                  },
                                  leading: memberWidget(
                                      index: index,
                                      taskModel: taskModel,
                                      memberName: boardCubit
                                          .currentBoard.members[index].image,
                                      mediaQuery: mediaQuery),
                                  title: Text(
                                    '${boardCubit.currentBoard.members[index].firstName} ${boardCubit.currentBoard.members[index].lastName}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: boardCubit.currentBoard
                                              .members[index].status ==
                                          'loading'
                                      ? Icon(
                                          Icons.access_time_filled_sharp,
                                          size: mediaQuery.width / 20,
                                        )
                                      : taskModel.users.indexWhere((element) =>
                                                  element.id ==
                                                  boardCubit.currentBoard
                                                      .members[index].id) !=
                                              -1
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            )
                                          : const SizedBox(),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                SizedBox(
                  height: mediaQuery.height / 40,
                ),
                Text(
                  S.of(context).deadline,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () async {
                    await taskSettingsCubit.showTimeDate(true);
                  },
                  child: SizedBox(
                    width: mediaQuery.width,
                    child: taskSettingsCubit.showTimeDatePicker
                        ? Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  taskSettingsCubit.selectDate(context);
                                },
                                child: SizedBox(
                                  width: mediaQuery.width / 2.9,
                                  child: CustomFormTextField(
                                    borderRadius: 0,
                                    borderColor: Colors.white,
                                    fillColor: Colors.white10,
                                    enabled: false,
                                    nameLabel: DateFormat('dd MMM yyyy')
                                        .format(taskSettingsCubit.selectedDate),
                                    hintText: '',
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  taskSettingsCubit.selectTime(context);
                                },
                                child: SizedBox(
                                  width: mediaQuery.width / 3.5,
                                  child: CustomFormTextField(
                                    borderRadius: 0,
                                    borderColor: Colors.white10,
                                    fillColor: Colors.white10,
                                    enabled: false,
                                    nameLabel: taskSettingsCubit.selectedTime
                                        .format(context),
                                    hintText: '',
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await taskSettingsCubit.saveTimeDate(context);
                                },
                                icon: const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await taskSettingsCubit
                                      .removeTimeDate(context);
                                },
                                icon: const Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Container(
                            child:
                                taskModel.time == null || taskModel.date == null
                                    ? Text(S.of(context).no_date)
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              '${taskModel.date!} . ${taskModel.time!}')
                                        ],
                                      ),
                          ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height / 30,
                ),
                Text(
                  S.of(context).created_at,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(taskSettingsCubit.formatDateTime(taskModel.createdAt)),
                SizedBox(
                  height: mediaQuery.height / 30,
                ),
                Text(
                  S.of(context).last_modified,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(taskSettingsCubit.formatDateTime(taskModel.updatedAt)),
                SizedBox(
                  height: mediaQuery.height / 30,
                ),
                !taskSettingsCubit.isUserInTask()
                    ? const SizedBox()
                    : BlocConsumer<UserCompleteTaskCubit,
                        UserCompleteTaskState>(
                        listener: (context, state) {
                          if (state is UserCompleteTaskSuccessState) {
                            Navigator.pop(context);
                          } else if (state is UserCompleteTaskLoadingState) {
                            loadingDialog(
                                context: context,
                                mediaQuery: mediaQuery,
                                title: '');
                          } else if (state is UserCompleteTaskFailedState) {
                            errorDialog(
                                context: context, text: state.errorMessage);
                          } else if (state is UserCompleteTaskExpiredState) {
                            showExpiredDialog(
                              context: context,
                              onConfirmBtnTap: () async {
                                await CashNetwork.clearCash();
                                await Hive.box('main').clear();
                                Phoenix.rebirth(context);
                              },
                            );
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () async {
                              userCompleteTaskCubit.userReadStateTask(
                                context: context,
                                userTaskModel: taskSettingsCubit.taskModel
                                    .users[taskSettingsCubit.userInTaskIndex],
                                value: !taskSettingsCubit
                                    .taskModel
                                    .users[taskSettingsCubit.userInTaskIndex]
                                    .read,
                                taskId:
                                    taskSettingsCubit.taskModel.id.toString(),
                              );
                            },
                            child: Container(
                              height: mediaQuery.height / 20,
                              width: mediaQuery.width,
                              margin: EdgeInsets.symmetric(
                                horizontal: mediaQuery.width / 15,
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: taskSettingsCubit
                                        .taskModel
                                        .users[
                                            taskSettingsCubit.userInTaskIndex]
                                        .read,
                                    activeColor: Colors.white,
                                    checkColor: AppColors.primaryColor,
                                    onChanged: (value) async {
                                      userCompleteTaskCubit.userReadStateTask(
                                        context: context,
                                        userTaskModel: taskSettingsCubit
                                                .taskModel.users[
                                            taskSettingsCubit.userInTaskIndex],
                                        value: !taskSettingsCubit
                                            .taskModel
                                            .users[taskSettingsCubit
                                                .userInTaskIndex]
                                            .read,
                                        taskId: taskSettingsCubit.taskModel.id
                                            .toString(),
                                      );
                                    },
                                  ),
                                  Text(
                                    taskSettingsCubit
                                            .taskModel
                                            .users[taskSettingsCubit
                                                .userInTaskIndex]
                                            .read
                                        ? S.of(context).readable
                                        : S.of(context).unreadable,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                SizedBox(
                  height: mediaQuery.height / 90,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await taskSettingsCubit.changeTaskStatus();
                  },
                  child: Container(
                    height: mediaQuery.height / 20,
                    width: mediaQuery.width,
                    margin: EdgeInsets.symmetric(
                      horizontal: mediaQuery.width / 15,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: taskSettingsCubit.taskModel.completed,
                          activeColor: Colors.white,
                          checkColor: AppColors.primaryColor,
                          onChanged: (value) async {
                            await taskSettingsCubit.changeTaskStatus();
                          },
                        ),
                        Text(
                          S.of(context).edit,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height / 90,
                ),
                BlocConsumer<CopyTaskCubit, CopyTaskState>(
                  listener: (context, state) {
                    if (state is CopyTaskSuccessState) {
                      Navigator.pop(context);
                      todoCubit.pagingController.itemList!.add(
                        state.copiesTasks,
                      );
                      todoCubit.refresh();
                      showLightSnackBar(
                          context, S.of(context).task_copied_successfully);
                    } else if (state is CopyTaskLoadingState) {
                      loadingDialog(
                          context: context, mediaQuery: mediaQuery, title: '');
                    } else if (state is CopyTaskFailedState) {
                      errorDialog(context: context, text: state.errorMessage);
                    } else if (state is CopyTaskExpiredState) {
                      showExpiredDialog(
                        context: context,
                        onConfirmBtnTap: () async {
                          await CashNetwork.clearCash();
                          await Hive.box('main').clear();
                          Phoenix.rebirth(context);
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        copyTaskCubit.copyTask(
                            applicationId: todoCubit.todoModel.id.toString(),
                            taskId: taskModel.id.toString(),
                            context: context);
                      },
                      child: Container(
                        height: mediaQuery.height / 20,
                        width: mediaQuery.width,
                        margin: EdgeInsets.symmetric(
                            horizontal: mediaQuery.width / 15),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            Text(
                              S.of(context).copy,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: mediaQuery.height / 90,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await updateTaskCubit.deleteTask(
                        context: context, taskModel: taskModel);
                  },
                  child: Container(
                    height: mediaQuery.height / 20,
                    width: mediaQuery.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: mediaQuery.width / 15),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          S.of(context).delete,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget memberWidget(
      {required TaskModel taskModel,
      required int index,
      required String memberName,
      required Size mediaQuery}) {
    if (index < 0 || index >= taskModel.users.length) {
      return const SizedBox();
    }
    return Container(
      alignment: Alignment.center,
      width: mediaQuery.width / 15,
      height: mediaQuery.height / 35,
      margin: EdgeInsets.symmetric(horizontal: mediaQuery.width / 190),
      padding: EdgeInsets.symmetric(
        horizontal: mediaQuery.width / 300,
        vertical: mediaQuery.height / 900,
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueAccent,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: taskModel.users[index].image!,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: mediaQuery.width / 8, // Adjust the size as needed
              height: mediaQuery.width / 8, // Adjust the size as needed
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
          width: mediaQuery.width / 8, // Adjust the size as needed
          height: mediaQuery.width / 8, // Adjust the size as needed
        ),
      ),
      // Text(
      //   memberName[0],
      //   style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: mediaQuery.width / 20),
      // ),
    );
  }
}
