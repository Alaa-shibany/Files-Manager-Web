import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:files_manager/cubits/task_commetns_cubit/task_comments_cubit.dart';
import 'package:files_manager/models/task_comment_model.dart';

import '../../theme/color.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, required this.mediaQuery, required this.taskComment});
  final TaskComment taskComment;
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    final taskCommentCubit = context.read<TaskCommentsCubit>();
    final String fileName = taskComment.type.toString();
    return GestureDetector(
      onLongPress: () {
        final cubit = context.read<TaskCommentsCubit>();
        cubit.setReplyingMessage(taskComment);
      },
      onTap: () async {
        print(taskComment.type);
        print(taskComment.comment);
        if (taskComment.type == 'video' ||
            taskComment.type == 'file' ||
            taskComment.type == 'voice' ||
            taskComment.type == 'screen') {
          String? filePath = taskComment.media ?? taskComment.comment;
          if (filePath != null && filePath.isNotEmpty) {
            taskCommentCubit.openFile(filePath);
          } else {
            print('File path is empty or null');
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width / 90,
          vertical: mediaQuery.height / 150,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (taskComment.reply != null)
              _buildReplySection(taskComment.reply!),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: taskComment.reply != null
                          ? const Color.fromARGB(29, 238, 238, 238)
                          : Colors.transparent)),
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width / 90,
                vertical: mediaQuery.height / 150,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                leading: memberWidget(
                    name: taskComment.user!.name, mediaQuery: mediaQuery),
                title: Text(
                  taskComment.user!.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
                subtitle: taskComment.type != 'text'
                    ? SizedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: mediaQuery.height / 90,
                              ),
                              alignment: Alignment.center,
                              width: mediaQuery.width / 8,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white24)),
                              child: Icon(
                                taskComment.type == 'video'
                                    ? Icons.video_camera_back_rounded
                                    : taskComment.type == 'voice'
                                        ? Icons.audio_file_rounded
                                        : taskComment.type == 'screen'
                                            ? Icons.video_camera_back_rounded
                                            : Icons.image,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: mediaQuery.height / 60,
                                  horizontal: mediaQuery.width / 90),
                              width: mediaQuery.width / 3,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white24)),
                              child: Text(
                                fileName,
                                style: const TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        width: mediaQuery.width / 2,
                        child: Text(
                          taskComment.comment ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(DateTime.parse(
                        taskComment.createdAt.toString(),
                      )),
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: mediaQuery.width / 30,
                      ),
                    ),
                    Text(
                      DateFormat('h:mm a').format(
                        DateTime.parse(
                          taskComment.createdAt.toString(),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: mediaQuery.width / 30,
                      ),
                    ),
                    taskComment.isSent
                        ? Icon(
                            Icons.done_all,
                            color: Colors.white38,
                            size: mediaQuery.width / 25,
                          )
                        : Icon(
                            Icons.timelapse_rounded,
                            color: Colors.white38,
                            size: mediaQuery.width / 25,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplySection(ReplyingModel reply) {
    return Container(
      width: mediaQuery.width,
      padding: EdgeInsets.symmetric(
        vertical: mediaQuery.height / 180,
        horizontal: mediaQuery.width / 90,
      ),
      margin: EdgeInsets.only(bottom: mediaQuery.height / 80),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: mediaQuery.height / 100),
          reply.type != 'text'
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_downward_rounded),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: mediaQuery.height / 80,
                        horizontal: mediaQuery.width / 100,
                      ),
                      alignment: Alignment.center,
                      width: mediaQuery.width / 6,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        reply.type == 'video'
                            ? Icons.video_camera_back_rounded
                            : reply.type == 'voice'
                                ? Icons.audio_file_rounded
                                : reply.type == 'screen'
                                    ? Icons.video_camera_back_rounded
                                    : Icons.image,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: mediaQuery.width / 50),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.height / 60,
                          horizontal: mediaQuery.width / 90),
                      width: mediaQuery.width / 3,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        'file name',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
              : SizedBox(
                  width: mediaQuery.width / 2,
                  child: Row(
                    children: [
                      Icon(Icons.arrow_downward_rounded,
                          size: mediaQuery.width / 20),
                      SizedBox(width: mediaQuery.width / 40),
                      Flexible(
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          reply.comment ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
          SizedBox(height: mediaQuery.height / 100),
        ],
      ),
    );
  }

  Widget memberWidget({required String name, required Size mediaQuery}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width / 30,
            vertical: mediaQuery.height / 140,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
          ),
          child: Text(
            name[0],
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: mediaQuery.width / 20),
          ),
        ),
      ],
    );
  }
}
