import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/task_commetns_cubit/task_comments_cubit.dart';
import 'package:files_manager/cubits/task_documents_cubit/task_documents_cubit.dart';
import 'package:files_manager/cubits/todo_cubit/task_settings_cubit/task_settings_cubit.dart';
import 'package:files_manager/widgets/helper/no_data.dart';

import '../../core/animation/dialogs/dialogs.dart';

class TaskDocuments extends StatelessWidget {
  const TaskDocuments({super.key, required this.taskSettingsCubit});
  final TaskSettingsCubit taskSettingsCubit;

  @override
  Widget build(BuildContext context) {
    final taskDocumentCubit = context.read<TaskDocumentsCubit>();
    final taskCommentsCubit = context.read<TaskCommentsCubit>();

    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<TaskDocumentsCubit, TaskDocumentsState>(
        listener: (context, state) {
          if (state is TaskDocumentsExpiredState) {
            showExpiredDialog(
              context: context,
              onConfirmBtnTap: () async {
                await CashNetwork.clearCash();
                await Hive.box('main').clear();
                Phoenix.rebirth(context);
              },
            );
          } else if (state is TaskDocumentsInternetState) {
            noInternetDialog(
                context: context,
                mediaQuery: mediaQuery,
                onPressed: () async {
                  await taskDocumentCubit.getAllDocuments(
                      context: context,
                      taskId: taskSettingsCubit.taskModel.id.toString());
                });
          } else if (state is TaskDocumentsFailedState) {
            errorDialog(context: context, text: state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is TaskDocumentsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskDocumentsSuccessState) {
            return taskDocumentCubit.allDocuments.isEmpty
                ? const Center(
                    child: NoData(
                        iconData: Icons.edit_document, text: 'No Documents'),
                  )
                : ListView(
                    children: List.generate(
                      taskDocumentCubit.allDocuments.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            String? filePath = taskDocumentCubit
                                .allDocuments[index].originalUrl;
                            if (filePath.isNotEmpty) {
                              taskCommentsCubit.openFile(filePath);
                            } else {
                              print('File path is empty or null');
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: mediaQuery.height / 90),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height / 40,
                                      horizontal: mediaQuery.width / 15),
                                  // margin: EdgeInsets.symmetric(
                                  //     horizontal: mediaQuery.width / 10),
                                  alignment: Alignment.center,
                                  // width: mediaQuery.width,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.white24)),
                                  child: Icon(
                                    taskDocumentCubit
                                                .allDocuments[index].extension
                                                .split('/')[0] ==
                                            'video'
                                        ? Icons.video_camera_back_rounded
                                        : taskDocumentCubit.allDocuments[index]
                                                    .extension
                                                    .split('/')[0] ==
                                                'audio'
                                            ? Icons.audio_file_rounded
                                            : Icons.image,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaQuery.height / 35,
                                      horizontal: mediaQuery.width / 40),
                                  width: mediaQuery.width / 1.8,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.white24)),
                                  child: const Text(
                                    'file name',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          } else {
            return const Center(
              child:
                  NoData(iconData: Icons.edit_document, text: 'No Documents'),
            );
          }
        },
      ),
    );
  }
}
