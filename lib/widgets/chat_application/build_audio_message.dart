// import 'package:flutter/material.dart';
// import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
// import 'package:files_manager/generated/l10n.dart';

// class BuildAudioMessage extends StatelessWidget {
//   const BuildAudioMessage(
//       {super.key,
//       required this.audioPath,
//       required this.timestamp,
//       required this.chatCubit,
//       required this.userImage});
//   final String audioPath;
//   final DateTime timestamp;
//   final ChatCubit chatCubit;
//   final String userImage;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: CircleAvatar(
//         backgroundImage: NetworkImage(userImage),
//       ),
//       title: Align(
//         alignment: Alignment.centerLeft,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           margin: const EdgeInsets.symmetric(vertical: 5),
//           decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(chatCubit.isPlayingAudio
//                         ? Icons.pause
//                         : Icons.play_arrow),
//                     color: Colors.white,
//                     onPressed: () {
//                       chatCubit.playAudio(
//                         1,
//                         audioPath,
//                       );
//                     },
//                   ),
//                   Text(
//                     S.of(context).voice_message,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 chatCubit.formatTimestamp(timestamp),
//                 style: const TextStyle(color: Colors.white70, fontSize: 12),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
