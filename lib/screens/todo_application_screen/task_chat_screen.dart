import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/functions/darkness_color.dart';
import 'package:files_manager/cubits/task_commetns_cubit/task_comments_cubit.dart';
import 'package:files_manager/cubits/task_documents_cubit/task_documents_cubit.dart';
import 'package:files_manager/cubits/update_task_cubit/update_task_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/task_comment_model.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';
import 'package:files_manager/widgets/task_chat/message_widget.dart';

import '../../core/shared/local_network.dart';

class TaskChatScreen extends StatelessWidget {
  const TaskChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final taskCommentsCubit = context.read<TaskCommentsCubit>();
    final taskSettingsCubit = context.read<UpdateTaskCubit>();

    final taskDocumentCubit = context.read<TaskDocumentsCubit>();
    return BlocConsumer<TaskCommentsCubit, TaskCommentsState>(
      listener: (context, state) {
        if (state is TaskCommentsInitial) {
          taskSettingsCubit.refreshScreen();
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            controller: taskCommentsCubit.chatScrollController,
            child: Column(
              children: [
                SizedBox(
                  height: mediaQuery.height / 1.45,
                  child: BlocConsumer<TaskCommentsCubit, TaskCommentsState>(
                    listener: (context, state) {
                      if (state is TaskCommentsSuccessState) {
                        final isLastPage = state.isReachMax;
                        if (isLastPage) {
                          taskCommentsCubit.pagingController
                              .appendLastPage(state.allComments);
                        } else {
                          final nextPageKey =
                              (taskCommentsCubit.taskModel.allComments.length ~/
                                      taskCommentsCubit.pageSize) +
                                  1;
                          print('The next page is =>$nextPageKey');
                          taskCommentsCubit.pagingController
                              .appendPage(state.allComments, nextPageKey);
                        }
                      } else if (state is TaskCommentsExpiredState) {
                        showExpiredDialog(
                          context: context,
                          onConfirmBtnTap: () async {
                            await CashNetwork.clearCash();
                            await Hive.box('main').clear();
                            Phoenix.rebirth(context);
                          },
                        );
                      } else if (state is TaskCommentsInternetState) {
                        noInternetDialog(
                            context: context,
                            mediaQuery: mediaQuery,
                            onPressed: () async {
                              await taskCommentsCubit.initState(
                                context: context,
                              );
                            });
                      } else if (state is TaskCommentsFailedState) {
                        errorDialog(context: context, text: state.errorMessage);
                      }
                    },
                    builder: (context, state) {
                      return PagedListView<int, TaskComment>(
                        padding: EdgeInsets.zero,
                        reverse: true,
                        pagingController: taskCommentsCubit.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<TaskComment>(
                          itemBuilder: (context, item, index) => MessageWidget(
                              mediaQuery: mediaQuery, taskComment: item),
                          noItemsFoundIndicatorBuilder: (context) =>
                              const Center(child: Text('No messages')),
                          firstPageProgressIndicatorBuilder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          newPageProgressIndicatorBuilder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                      ).animate().fade(
                            duration: const Duration(milliseconds: 500),
                          );
                    },
                  ),
                ),
                taskCommentsCubit.emojiKeyboard
                    ? EmojiPicker(
                        onEmojiSelected: (category, emoji) async {
                          await taskCommentsCubit.selectEmoji(emoji.emoji);
                          print('selectEmoji');
                        },
                        config: const Config(),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          bottomSheet: BlocConsumer<TaskCommentsCubit, TaskCommentsState>(
            listener: (context, state) {
              if (state is TaskCommentsSendMessageState) {
                taskDocumentCubit.allDocuments.add(state.documentModel);
                print(taskDocumentCubit.allDocuments);
                taskDocumentCubit.refresh();
              }
            },
            builder: (context, state) {
              return Container(
                height: mediaQuery.height / 9,
                // padding: EdgeInsets.symmetric(vertical: mediaQuery.height / 90),
                decoration: BoxDecoration(
                  color: darkenColor(AppColors.dark),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    taskCommentsCubit.isRecordingAudio
                        ? Container(
                            color: const Color.fromARGB(255, 186, 154, 112),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.of(context).audio_recording_in_progress),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.cancel),
                                      onPressed: () async {
                                        await taskCommentsCubit.cancelRecord();
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.stop),
                                      onPressed: () async {
                                        await taskCommentsCubit
                                            .stopAudioRecording(context);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : const SizedBox(),
                    taskCommentsCubit.isReplying
                        ? Container(
                            padding: EdgeInsets.all(mediaQuery.width / 40),
                            color: Colors.grey[300],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${S.of(context).replying_to}: ${taskCommentsCubit.messageToReply?.comment ?? ''}'),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: darkenColor(
                                      AppColors.dark,
                                      0.1,
                                    ),
                                  ),
                                  onPressed: () {
                                    taskCommentsCubit.cancelReplying();
                                  },
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupMenuButton<String>(
                          icon: const Icon(Icons.attach_file),
                          onSelected: (value) async {
                            taskCommentsCubit.messageFocusNode.unfocus();
                            taskCommentsCubit.handlePopupMenuSelection(
                                value, context);
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                value: 'files',
                                child: Row(
                                  children: [
                                    const Icon(Icons.attach_file),
                                    const SizedBox(width: 10),
                                    Text(S.of(context).attach_file),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'audio',
                                child: Row(
                                  children: [
                                    const Icon(Icons.mic),
                                    const SizedBox(width: 10),
                                    Text(S.of(context).record_audio),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'video',
                                child: Row(
                                  children: [
                                    const Icon(Icons.videocam),
                                    const SizedBox(width: 10),
                                    Text(S.of(context).record_video),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'screen',
                                child: Row(
                                  children: [
                                    const Icon(Icons.screen_share),
                                    const SizedBox(width: 10),
                                    Text(S.of(context).record_screen),
                                  ],
                                ),
                              ),
                            ];
                          },
                        ),
                        IconButton(
                          onPressed: () async {
                            await taskCommentsCubit.showEmojiKeyboard();
                          },
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: mediaQuery.width / 1.6,
                          height: mediaQuery.height / 9.5,
                          child: CustomFormTextField(
                            nameLabel: '',
                            maxLines: 10,
                            fillColor: Colors.transparent,
                            styleInput: const TextStyle(color: Colors.white),
                            controller: taskCommentsCubit.messageController,
                            focusNode: taskCommentsCubit.messageFocusNode,
                            hintText: S.of(context).enter_a_message,
                            validator: (p0) {
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (taskCommentsCubit
                                .messageController.text.isEmpty) {
                              return;
                            }
                            taskCommentsCubit.sendMessage(
                                context: context,
                                replyId: taskCommentsCubit.messageToReply?.id
                                    .toString());
                          },
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
