import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/core/functions/darkness_color.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/copy_task_cubit/copy_task_cubit.dart';
import 'package:files_manager/cubits/task_commetns_cubit/task_comments_cubit.dart';
import 'package:files_manager/cubits/task_documents_cubit/task_documents_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/create_task_cubit/create_task_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/task_settings_cubit/task_settings_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/todo_cubit.dart';
import 'package:files_manager/cubits/update_task_cubit/update_task_cubit.dart';
import 'package:files_manager/cubits/user_complete_task_cubit/user_complete_task_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/task_model.dart';
import 'package:files_manager/screens/todo_application_screen/task_settings_screen.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';
import 'package:files_manager/widgets/todo_application/pop_menu_widget.dart';
import '../../core/shared/local_network.dart';

class TodoApplicationScreen extends StatelessWidget {
  const TodoApplicationScreen(
      {super.key,
      required this.boardCubit,
      required this.allBoardsCubit,
      required this.applicationCubit});
  final BoardCubit boardCubit;
  final AllBoardsCubit allBoardsCubit;
  final ApplicationCubit applicationCubit;
  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final mediaQuery = MediaQuery.of(context).size;
    final createTaskCubit = context.read<CreateTaskCubit>();
    return WillPopScope(
      onWillPop: () async {
        await boardCubit.refresh();
        return true;
      },
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor:
                allColors[todoCubit.todoModel.getApplicationSelectedColor()]
                    ['real'],
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                  )),
              title: Text(
                todoCubit.taskTitleController.text,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                PopMenuWidget(
                  applicationCubit: applicationCubit,
                  allBoardsCubit: allBoardsCubit,
                  boardCubit: boardCubit,
                  mediaQuery: mediaQuery,
                  application: todoCubit.todoModel,
                  chatCubit: null,
                  todoCubit: todoCubit,
                  path: '',
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocConsumer<TodoCubit, TodoState>(
                    listener: (context, state) {
                      if (state is TodoFailedState) {
                        errorDialog(context: context, text: state.errorMessage);
                      } else if (state is TodoExpiredState) {
                        showExpiredDialog(
                          context: context,
                          onConfirmBtnTap: () async {
                            await CashNetwork.clearCash();
                            await Hive.box('main').clear();
                            Phoenix.rebirth(context);
                          },
                        );
                      } else if (state is TodoNoInternetState) {
                        internetDialog(
                            context: context, mediaQuery: mediaQuery);
                      } else if (state is TodoSuccessState) {
                        final isLastPage = state.isReachMax;
                        print('Is the last page => $isLastPage');
                        if (isLastPage) {
                          todoCubit.pagingController
                              .appendLastPage(state.newTasks);
                        } else {
                          final nextPageKey =
                              (todoCubit.todoModel.tasks.length ~/
                                      todoCubit.pageSize) +
                                  1;
                          print('The next page is =>$nextPageKey');
                          todoCubit.pagingController
                              .appendPage(state.newTasks, nextPageKey);
                        }
                        FocusScope.of(context).unfocus();
                      }
                    },
                    builder: (context, state) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          await todoCubit.refreshData();
                        },
                        child: SizedBox(
                          height: mediaQuery.height / 1.25,
                          child: PagedListView<int, TaskModel>(
                            padding: EdgeInsets.zero,
                            pagingController: todoCubit.pagingController,
                            shrinkWrap: true,
                            // physics: const BouncingScrollPhysics(),
                            builderDelegate:
                                PagedChildBuilderDelegate<TaskModel>(
                              itemBuilder: (context, item, index) => ListTile(
                                subtitle: Wrap(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                    item.users.length + 3,
                                    (index1) {
                                      if (index1 == 0) {
                                        return item.time != null &&
                                                item.date != null
                                            ? Icon(
                                                Icons.timelapse_outlined,
                                                color: Colors.white30,
                                                size: mediaQuery.width / 20,
                                              )
                                            : const SizedBox();
                                      } else if (index1 == 1) {
                                        return item.description != null &&
                                                item.description!.isNotEmpty
                                            ? Icon(
                                                Icons.text_fields_rounded,
                                                color: Colors.white30,
                                                size: mediaQuery.width / 20,
                                              )
                                            : const SizedBox();
                                      } else if (index1 == 2) {
                                        return item.commentsCount != 0
                                            ? Icon(
                                                Icons.chat,
                                                color: Colors.white30,
                                                size: mediaQuery.width / 20,
                                              )
                                            : const SizedBox();
                                      }
                                      // تأكد من أن الفهرس index1 - 3 ضمن النطاق الصحيح
                                      int userIndex = index1 - 3;
                                      if (userIndex < 0 ||
                                          userIndex >= item.users.length) {
                                        return const SizedBox(); // ارجع إلى SizedBox فارغ إذا كان الفهرس غير صالح
                                      }
                                      return memberWidget(
                                        memberName: item.users[userIndex].name,
                                        mediaQuery: mediaQuery,
                                        taskModel: item,
                                        index:
                                            userIndex, // استخدم userIndex بدلاً من index
                                      );
                                    },
                                  ),
                                ),
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    todoCubit.isUserInTask(item)
                                        ? !item.users[todoCubit.userInTaskIndex]
                                                .read
                                            ? Container(
                                                height: mediaQuery.height / 60,
                                                width: mediaQuery.width / 19,
                                                decoration: const BoxDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    shape: BoxShape.circle),
                                              )
                                            : const SizedBox()
                                        : const SizedBox(),
                                    Checkbox(
                                        checkColor: allColors[todoCubit
                                                .todoModel
                                                .getApplicationSelectedColor()]
                                            ['real'],
                                        // fillColor: Colors.white,
                                        side: const BorderSide(
                                            color: Colors.black),
                                        activeColor: AppColors.white,
                                        value: item.completed,
                                        onChanged: (value) async {
                                          todoCubit.newTaskFocusNode.unfocus();
                                          await createTaskCubit.changeTaskState(
                                              context: context,
                                              taskId: item.id.toString(),
                                              taskStatus: value!);
                                          FocusScope.of(context).unfocus();
                                        }),
                                  ],
                                ),
                                onTap: () {
                                  print('task settings');
                                  todoCubit.newTaskFocusNode.unfocus();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MultiBlocProvider(
                                        providers: [
                                          BlocProvider(
                                            create: (context) =>
                                                TaskSettingsCubit(
                                                    taskModel: item)
                                                  ..initState(),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                UpdateTaskCubit(),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                UserCompleteTaskCubit(),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                CopyTaskCubit(),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                TaskCommentsCubit(
                                              taskModel: item,
                                            )..initState(context: context),
                                          ),
                                          BlocProvider(
                                            create: (context) =>
                                                TaskDocumentsCubit()
                                                  ..getAllDocuments(
                                                      context: context,
                                                      taskId:
                                                          item.id.toString()),
                                          ),
                                        ],
                                        child: TaskSettingsScreen(
                                          boardCubit: boardCubit,
                                          todoCubit: todoCubit,
                                          taskModel: item,
                                        ),
                                      ),
                                    ),
                                  );
                                  FocusScope.of(context).unfocus();
                                },
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                    color: AppColors.white,
                                  ),
                                ),
                              ).animate().fade(
                                    duration: const Duration(milliseconds: 500),
                                  ),
                              noItemsFoundIndicatorBuilder: (context) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: mediaQuery.height / 1.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.done_all,
                                            color: Colors.white,
                                            size: mediaQuery.width / 3,
                                          ),
                                        ),
                                        Text(
                                          S.of(context).there_are_no_tasks_yet,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ).animate().fade(
                                  duration: const Duration(milliseconds: 500)),
                              firstPageProgressIndicatorBuilder: (context) =>
                                  Container(
                                height: mediaQuery.height / 1.25,
                                alignment: Alignment.center,
                                child: SpinKitFadingCircle(
                                  color: AppColors.primaryColor,
                                  size: mediaQuery.width / 8,
                                ),
                              ),
                              newPageProgressIndicatorBuilder: (context) =>
                                  SpinKitFadingCircle(
                                color: AppColors.primaryColor,
                                size: mediaQuery.width / 8,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ).animate().fade(
                  duration: const Duration(milliseconds: 500),
                ),
            bottomSheet: Container(
              height: mediaQuery.height / 10.5,
              alignment: Alignment.center,
              color: darkenColor(
                  allColors[todoCubit.todoModel.getApplicationSelectedColor()]
                      ['real']!,
                  0.1),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: mediaQuery.width / 30),
                width: mediaQuery.width,
                child: BlocConsumer<CreateTaskCubit, CreateTaskState>(
                  listener: (context, state) {
                    if (state is CreateTaskLoadingState) {
                      loadingDialog(
                          context: context,
                          mediaQuery: mediaQuery,
                          title: S.of(context).new_task_is_being_added);
                    }
                    if (state is CreateTaskUpdateLoadingState) {
                      loadingDialog(
                          context: context,
                          mediaQuery: mediaQuery,
                          title: S.of(context).editing_in_progress);
                    } else if (state is CreateTaskSuccessState) {
                      Navigator.pop(context);
                      todoCubit.todoModel.tasks.insert(0, state.newTaskModel);
                      todoCubit.pagingController.itemList!
                          .insert(0, state.newTaskModel);
                      todoCubit.taskController = TextEditingController();
                      todoCubit.refresh();
                    } else if (state is CreateTaskUpdateSuccessState) {
                      Navigator.pop(context);
                      // todoCubit.todoModel.tasks
                      //     .where(
                      //       (element) => element.id == state.taskModel.id,
                      //     )
                      //     .first
                      //     .completed = state.taskModel.completed;
                      // todoCubit.pagingController.itemList!
                      //     .where(
                      //       (element) => element.id == state.taskModel.id,
                      //     )
                      //     .first
                      //     .completed = state.taskModel.completed;
                      todoCubit.refreshData();
                      // todoCubit.refresh();
                    } else if (state is CreateTaskFailedState) {
                      errorDialog(context: context, text: state.errorMessage);
                    } else if (state is CreateTaskExpiredState) {
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
                    return SizedBox(
                      height: mediaQuery.height / 10,
                      child: CustomFormTextField(
                        fillColor: Colors.transparent,
                        styleInput: TextStyle(color: Colors.white),
                        nameLabel: '',
                        controller: todoCubit.taskController,
                        focusNode: todoCubit.newTaskFocusNode,
                        validator: (p0) {
                          return null;
                        },
                        hintText: S.of(context).add_new_task,
                        icon: Icons.add,
                        colorIcon: Colors.white,
                        onPressedIcon: () async {
                          todoCubit.newTaskFocusNode.unfocus();
                          print('add');
                          if (todoCubit.taskController.text.isEmpty) {
                            return;
                          }
                          await createTaskCubit.createTask(
                            context: context,
                            taskTitle: todoCubit.taskController.text,
                            todoApplicationId:
                                todoCubit.todoModel.id.toString(),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
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
      //       fontSize: mediaQuery.width / 30),
      // ),
    );
  }
}
