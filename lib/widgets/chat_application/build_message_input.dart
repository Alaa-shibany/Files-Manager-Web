// import 'package:flutter/material.dart';
// import 'package:files_manager/core/functions/color_to_hex.dart';
// import 'package:files_manager/core/functions/darkness_color.dart';
// import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
// import 'package:files_manager/generated/l10n.dart';
// import 'package:files_manager/theme/color.dart';

// class BuildMessageInput extends StatelessWidget {
//   const BuildMessageInput({super.key, required this.chatCubit});
//   final ChatCubit chatCubit;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: darkenColor(
//           allColors[chatCubit.chatModel.getApplicationSelectedColor()]['real']!,
//           0.1),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             IconButton(
//               icon: const Icon(Icons.emoji_emotions),
//               onPressed: chatCubit.toggleEmojiKeyboard,
//             ),
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
//             Expanded(
//               child: TextField(
//                 style: const TextStyle(color: AppColors.dark),
//                 controller: chatCubit.messageTextController,
//                 onChanged: (text) {
//                   chatCubit.emit(ChatMessageChanged());
//                 },
//                 decoration: InputDecoration(
//                   labelStyle: const TextStyle(color: Colors.black),
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintStyle: const TextStyle(color: AppColors.primaryColor),
//                   hintText: '${S.of(context).write_your_message}...',
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: const Icon(Icons.send),
//               onPressed: (chatCubit.messageTextController.text.isNotEmpty ||
//                       chatCubit.hasMedia)
//                   ? () {
//                       chatCubit
//                           .sendMessage(chatCubit.messageTextController.text);
//                       chatCubit.messageTextController.clear();
//                       chatCubit.hasMedia = false;
//                     }
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
