// import 'package:flutter/material.dart';
// import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
// import 'package:files_manager/widgets/chat_application/full_screen_video_player.dart';

// class BuildVideoMessage extends StatelessWidget {
//   const BuildVideoMessage(
//       {super.key,
//       required this.videoPath,
//       required this.timestamp,
//       required this.chatCubit,
//       required this.userImage});
//   final String videoPath;
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
//         child: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     FullScreenVideoPlayer(videoPath: videoPath),
//               ),
//             );
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/video_placeholder.png',
//                     width: 200,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                   const Icon(
//                     Icons.play_circle_fill,
//                     color: Colors.white,
//                     size: 50,
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
