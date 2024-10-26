import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/functions/snackbar_function.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/task_commetns_cubit/task_comments_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/task_settings_cubit/task_settings_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/todo_cubit.dart';
import 'package:files_manager/cubits/update_task_cubit/update_task_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/task_model.dart';
import 'package:files_manager/screens/todo_application_screen/task_chat_screen.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_fields.dart';
import 'package:files_manager/widgets/task_settings/details_section.dart';
import 'package:files_manager/widgets/task_settings/quill_widget.dart';
import 'package:files_manager/widgets/task_settings/task_documents.dart';

class TaskSettingsScreen extends StatefulWidget {
  const TaskSettingsScreen({
    super.key,
    required this.todoCubit,
    required this.taskModel,
    required this.boardCubit,
  });
  final TodoCubit todoCubit;
  final TaskModel taskModel;
  final BoardCubit boardCubit;

  @override
  State<TaskSettingsScreen> createState() => _TaskSettingsScreenState();
}

class _TaskSettingsScreenState extends State<TaskSettingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0; // Current tab index

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(
      () {
        if (tabController.index == 3 &&
            context.read<TaskSettingsCubit>().taskModel.attachmentsCount == 0) {
          setState(() {
            tabController.index = tabIndex; // Force to stay on the previous tab
          });
          showLightSnackBar(context, S.of(context).there_are_no_documents_yet);
        } else {
          tabIndex = tabController.index;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final taskSettingsCubit = context.read<TaskSettingsCubit>();
    final updateTaskCubit = context.read<UpdateTaskCubit>();
    return BlocConsumer<UpdateTaskCubit, UpdateTaskState>(
      listener: (context, state) {
        if (state is UpdateTaskSuccessState) {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          taskSettingsCubit.showTimeDatePicker = false;
          taskSettingsCubit.taskModel.allComments.clear();
          widget.todoCubit.sortList(context: context);
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          widget.todoCubit.refresh();
        } else if (state is DeleteTaskSuccessState) {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          taskSettingsCubit.showTimeDatePicker = false;
          widget.todoCubit.pagingController.itemList!.removeWhere(
            (element) => element.id == widget.taskModel.id,
          );
          taskSettingsCubit.taskModel.allComments.clear();
          widget.todoCubit.sortList(context: context);
          Navigator.pop(context);
          FocusScope.of(context).unfocus();
          widget.todoCubit.refresh();
        } else if (state is UpdateTaskLoadingState) {
          loadingDialog(
              context: context,
              mediaQuery: mediaQuery,
              title: state.loadingMessage);
        } else if (state is UpdateTaskFailedState) {
          errorDialog(
            context: context,
            text: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        return BlocConsumer<TaskCommentsCubit, TaskCommentsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                await updateTaskCubit.updateTask(
                    context: context, taskModel: taskSettingsCubit.taskModel);
                return false;
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.darkGray,
                  flexibleSpace: SizedBox(
                    height: mediaQuery.height / 3,
                  ),
                  toolbarHeight: mediaQuery.height / 12,
                  title: SizedBox(
                    child: CustomTextFields(
                      textAlign: TextAlign.end,
                      styleInput: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: mediaQuery.width / 15),
                      controller: taskSettingsCubit.taskNameController,
                      onChanged: (p0) async {
                        await taskSettingsCubit.editTaskName();
                      },
                    ),
                  ),
                  centerTitle: true,
                  leading: IconButton(
                      onPressed: () async {
                        await updateTaskCubit.updateTask(
                            context: context,
                            taskModel: taskSettingsCubit.taskModel);
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      )),
                  bottom: TabBar(
                    controller: tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicator: const BoxDecoration(
                      color: AppColors.dark,
                    ),
                    labelStyle: TextStyle(fontSize: mediaQuery.width / 30),
                    unselectedLabelStyle:
                        TextStyle(fontSize: mediaQuery.width / 30),
                    onTap: (value) {},
                    tabs: [
                      Tab(
                        text: S.of(context).description,
                        icon: const Icon(
                          Icons.text_fields_rounded,
                          color: Colors.white,
                        ),
                      ),
                      Tab(
                        text: S.of(context).details,
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      ),
                      Tab(
                        text:
                            '(${taskSettingsCubit.taskModel.commentsCount}) ${S.of(context).comments}',
                        icon: const Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ),
                      Tab(
                        text:
                            '(${taskSettingsCubit.taskModel.attachmentsCount}) ${S.of(context).attachments}',
                        icon: const Icon(
                          Icons.edit_document,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const QuillWidget(),
                    DetailsSection(
                      todoCubit: widget.todoCubit,
                      taskModel: widget.taskModel,
                      boardCubit: widget.boardCubit,
                    ),
                    const TaskChatScreen(),
                    TaskDocuments(taskSettingsCubit: taskSettingsCubit),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
