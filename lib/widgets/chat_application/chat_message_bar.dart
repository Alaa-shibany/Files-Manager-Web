// import 'package:chat_bubbles/message_bars/message_bar.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:files_manager/core/functions/color_to_hex.dart';
// import 'package:files_manager/core/functions/darkness_color.dart';
// import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
// import 'package:files_manager/generated/l10n.dart';

// class ChatMessageBar extends StatelessWidget {
//   const ChatMessageBar({
//     super.key,
//     required this.chatCubit,
//     required this.showEmojiKeyboard,
//   });

//   final ChatCubit chatCubit;
//   final bool showEmojiKeyboard;

//   @override
//   Widget build(BuildContext context) {
//     if (chatCubit.isRecordingAudio) {
//       return Container(
//         color: Colors.red[100],
//         padding: const EdgeInsets.all(10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Recording..."),
//             IconButton(
//               icon: const Icon(Icons.stop),
//               onPressed: () async {
//                 await chatCubit.stopAudioRecording(context);
//               },
//             ),
//           ],
//         ),
//       );
//     }
//     return Column(
//       children: [
//         if (chatCubit.isReplying)
//           Container(
//             padding: const EdgeInsets.all(8.0),
//             color: Colors.grey[300],
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Replying to: ${chatCubit.messageToReply?.message ?? ''}'),
//                 IconButton(
//                   icon: Icon(
//                     Icons.close,
//                     color: darkenColor(
//                       allColors[chatCubit.chatModel
//                           .getApplicationSelectedColor()]['real']!,
//                       0.1,
//                     ),
//                   ),
//                   onPressed: () {
//                     chatCubit.cancelReplying();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         if (showEmojiKeyboard)
//           EmojiPicker(
//             onEmojiSelected: (category, emoji) {
//               chatCubit.messageTextController.text += emoji.emoji;
//               chatCubit.emit(ChatMessageChanged());
//             },
//             config: const Config(),
//           ),
//         MessageBar(
//           onTextChanged: (text) {
//             chatCubit.messageTextController.text = text;
//             print('Text Input is ================= $text');
//           },
//           messageBarColor: darkenColor(
//             allColors[chatCubit.chatModel.getApplicationSelectedColor()]
//                 ['real']!,
//             0.1,
//           ),
//           onSend: (_) {
//             chatCubit.sendMessageFun(
//               context: context,
//               applicationId: chatCubit.chatModel.id,
//               messageType: 'text',
//               replayMessageId:
//                   chatCubit.isReplying ? chatCubit.messageToReply?.id : null,
//             );
//             chatCubit.messageTextController.clear();
//             chatCubit.cancelReplying();
//             FocusScope.of(context).unfocus();
//           },
//           actions: [
//             PopupMenuButton<String>(
//               icon: const Icon(Icons.attach_file),
//               onSelected: (value) async {
//                 chatCubit.handlePopupMenuSelection(value, context);
//               },
//               itemBuilder: (BuildContext context) {
//                 return [
//                   PopupMenuItem(
//                     value: 'files',
//                     child: Row(
//                       children: [
//                         const Icon(Icons.attach_file),
//                         const SizedBox(width: 10),
//                         Text(S.of(context).attach_file),
//                       ],
//                     ),
//                   ),
//                   PopupMenuItem(
//                     value: 'audio',
//                     child: Row(
//                       children: [
//                         const Icon(Icons.mic),
//                         const SizedBox(width: 10),
//                         Text(S.of(context).record_audio),
//                       ],
//                     ),
//                   ),
//                   PopupMenuItem(
//                     value: 'video',
//                     child: Row(
//                       children: [
//                         const Icon(Icons.videocam),
//                         const SizedBox(width: 10),
//                         Text(S.of(context).record_video),
//                       ],
//                     ),
//                   ),
//                   PopupMenuItem(
//                     value: 'screen',
//                     child: Row(
//                       children: [
//                         const Icon(Icons.screen_share),
//                         const SizedBox(width: 10),
//                         Text(S.of(context).record_screen),
//                       ],
//                     ),
//                   ),
//                 ];
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.emoji_emotions),
//               onPressed: chatCubit.toggleEmojiKeyboard,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
