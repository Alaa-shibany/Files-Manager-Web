import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:files_manager/core/animation/dialogs/dialogs.dart';
import 'package:files_manager/core/animation/dialogs/expired_dialog.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/core/functions/darkness_color.dart';
import 'package:files_manager/core/functions/snackbar_function.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/all_boards_cubit/all_boards_cubit.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:files_manager/generated/l10n.dart';
import 'package:files_manager/models/folder_model.dart';
import 'package:files_manager/theme/color.dart';
import 'package:files_manager/widgets/chat_application/message_widget_chat.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_field.dart';
import 'package:files_manager/widgets/custom_text_fields/custom_text_fields.dart';
import 'package:files_manager/widgets/todo_application/pop_menu_widget.dart';

class ChatScreenTest extends StatelessWidget {
  const ChatScreenTest(
      {super.key,
      required this.allBoardsCubit,
      required this.boardCubit,
      required this.applicationCubit});
  final BoardCubit boardCubit;
  final AllBoardsCubit allBoardsCubit;
  final ApplicationCubit applicationCubit;
  @override
  Widget build(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();
    final mediaQuery = MediaQuery.of(context).size;
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Localizations.override(
          context: context,
          child: WillPopScope(
            onWillPop: () async {
              FocusScope.of(context).unfocus();
              await chatCubit.refresh();
              return true;
            },
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatScreenRecordingStarted) {
                  showLightSnackBar(
                      context, S.of(context).screen_recording_started);
                }
                if (state is ChatScreenRecordingStopped) {
                  showLightSnackBar(context,
                      '${S.of(context).screen_recording_stopped} ${state.path}');
                }
                if (state is FetchChatMessagesFailure) {
                  errorDialog(context: context, text: state.errorMessage);
                } else if (state is FetchChatMessagesExpiredToken) {
                  showExpiredDialog(
                    context: context,
                    onConfirmBtnTap: () async {
                      await CashNetwork.clearCash();
                      await Hive.box('main').clear();
                      Phoenix.rebirth(context);
                    },
                  );
                } else if (state is FetchChatMessagesNoINternet) {
                  internetDialog(context: context, mediaQuery: mediaQuery);
                } else if (state is FetchChatMessagesSuccess) {
                  final isLastPage = state.isReachMax;
                  print('Is the last page => $isLastPage');
                  if (isLastPage) {
                    chatCubit.pagingController
                        .appendLastPage(state.newMessages);
                  } else {
                    final nextPageKey =
                        (chatCubit.messagesData.length ~/ chatCubit.pageSize) +
                            1;
                    print('The next page is =>$nextPageKey');
                    chatCubit.pagingController
                        .appendPage(state.newMessages, nextPageKey);
                  }
                }
              },
              builder: (context, state) {
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: allColors[chatCubit.chatModel
                      .getApplicationSelectedColor()]['real'],
                  appBar: AppBar(
                    title: CustomTextFields(
                      controller: chatCubit.taskTitleController,
                      onChanged: (p0) async {
                        await chatCubit.editTaskName();
                      },
                    ),
                    centerTitle: true,
                    actions: [
                      PopMenuWidget(
                          applicationCubit: applicationCubit,
                          mediaQuery: mediaQuery,
                          application: chatCubit.chatModel,
                          boardCubit: boardCubit,
                          chatCubit: chatCubit,
                          todoCubit: null,
                          path: '',
                          allBoardsCubit: allBoardsCubit)
                    ],
                  ),
                  body: SingleChildScrollView(
                    controller: chatCubit.chatScrollController,
                    child: Column(
                      children: [
                        SizedBox(
                          height: mediaQuery.height / 1.24,
                          child: PagedListView<int, ChatMessageModel>(
                            padding: EdgeInsets.zero,
                            reverse: true,
                            pagingController: chatCubit.pagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<ChatMessageModel>(
                              itemBuilder: (context, item, index) =>
                                  MessageWidgetChat(
                                      mediaQuery: mediaQuery,
                                      chatMessage: item),
                              noItemsFoundIndicatorBuilder: (context) => Center(
                                  child: Text(S.of(context).no_messages_yet)),
                              firstPageProgressIndicatorBuilder: (context) =>
                                  const Center(
                                      child: CircularProgressIndicator()),
                              newPageProgressIndicatorBuilder: (context) =>
                                  const Center(
                                      child: CircularProgressIndicator()),
                            ),
                          ).animate().fade(
                                duration: const Duration(milliseconds: 500),
                              ),
                        ),
                        chatCubit.emojiKeyboard
                            ? EmojiPicker(
                                onEmojiSelected: (category, emoji) async {
                                  await chatCubit.selectEmoji(emoji.emoji);
                                  print('selectEmoji');
                                },
                                config: const Config(),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  bottomSheet: BlocConsumer<ChatCubit, ChatState>(
                    listener: (context, state) {},
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
                            chatCubit.isRecordingAudio
                                ? Container(
                                    color: const Color.fromARGB(
                                        255, 193, 153, 101),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(S
                                            .of(context)
                                            .audio_recording_in_progress),
                                        IconButton(
                                          icon: const Icon(Icons.stop),
                                          onPressed: () async {
                                            await chatCubit
                                                .stopAudioRecording(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            chatCubit.isReplying
                                ? Container(
                                    padding:
                                        EdgeInsets.all(mediaQuery.width / 40),
                                    color: Colors.grey[300],
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${S.of(context).replying_to}: ${chatCubit.messageToReply?.message ?? ''}'),
                                        IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            color: darkenColor(
                                              AppColors.dark,
                                              0.1,
                                            ),
                                          ),
                                          onPressed: () {
                                            chatCubit.cancelReplying();
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
                                    FocusScope.of(context).unfocus();
                                    chatCubit.messageFucusNode.unfocus();
                                    chatCubit.handlePopupMenuSelection(
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
                                    await chatCubit.showEmojiKeyboard();
                                  },
                                  icon: const Icon(
                                    Icons.emoji_emotions,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: mediaQuery.width / 1.6,
                                  // height: mediaQuery.height / 14,
                                  child: CustomFormTextField(
                                    nameLabel: '',
                                    maxLines: 10,
                                    fillColor: Colors.transparent,
                                    focusNode: chatCubit.messageFucusNode,
                                    styleInput:
                                        const TextStyle(color: Colors.white),
                                    controller: chatCubit.messageController,
                                    hintText: S.of(context).enter_a_message,
                                    validator: (p0) {
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (chatCubit
                                        .messageController.text.isEmpty) {
                                      return;
                                    }
                                    chatCubit.sendMessage(
                                        context: context,
                                        replyId: chatCubit.messageToReply?.id
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
            ),
          ),
        );
      },
    );
  }
}
