import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:files_manager/models/folder_model.dart';

import '../../theme/color.dart';

class MessageWidgetChat extends StatelessWidget {
  const MessageWidgetChat(
      {super.key, required this.mediaQuery, required this.chatMessage});
  final ChatMessageModel chatMessage;
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();
    final String fileName = chatMessage.messageType.toString();

    return GestureDetector(
      onLongPress: () {
        final cubit = context.read<ChatCubit>();
        cubit.setReplyingMessage(chatMessage);
      },
      onTap: () async {
        print(chatMessage.media);
        print(chatMessage.messageType);
        print(chatMessage.message);
        if (chatMessage.messageType == 'video' ||
            chatMessage.messageType == 'file' ||
            chatMessage.messageType == 'voice' ||
            chatMessage.messageType == 'screen') {
          String? filePath = chatMessage.media ?? chatMessage.message;
          print('File Path from message widget $filePath');
          if (filePath != null && filePath.isNotEmpty) {
            chatCubit.openFile(filePath);
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
            if (chatMessage.reply != null)
              _buildReplySection(chatMessage.reply!),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: chatMessage.reply != null
                          ? const Color.fromARGB(29, 238, 238, 238)
                          : Colors.transparent)),
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width / 90,
                vertical: mediaQuery.height / 150,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.top,
                leading: memberWidget(
                    name: chatMessage.userMessageData.name,
                    mediaQuery: mediaQuery),
                title: Text(
                  chatMessage.userMessageData.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
                subtitle: chatMessage.messageType != 'text'
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
                                chatMessage.messageType == 'video'
                                    ? Icons.video_camera_back_rounded
                                    : chatMessage.messageType == 'voice'
                                        ? Icons.audio_file_rounded
                                        : chatMessage.messageType == 'screen'
                                            ? Icons.video_camera_back_rounded
                                            : Icons.image,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: mediaQuery.height / 60,
                                  horizontal: mediaQuery.width / 90),
                              width: mediaQuery.width / 3.1,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Text(
                                fileName,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        width: mediaQuery.width / 2,
                        child: Text(
                          chatMessage.message ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('dd MMM yyyy').format(
                        DateTime.parse(
                          chatMessage.createdAt.toString(),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: mediaQuery.width / 30,
                      ),
                    ),
                    Text(
                      DateFormat('h:mm a').format(
                        DateTime.parse(
                          chatMessage.createdAt.toString(),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: mediaQuery.width / 30,
                      ),
                    ),
                    chatMessage.isSent!
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
          reply.messageType != 'text'
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
                        reply.messageType == 'video'
                            ? Icons.video_camera_back_rounded
                            : reply.messageType == 'voice'
                                ? Icons.audio_file_rounded
                                : reply.messageType == 'screen'
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
                          reply.message ?? '',
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
