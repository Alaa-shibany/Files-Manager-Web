// import 'package:flutter/material.dart';
// import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';

// class BuildTextMessage extends StatelessWidget {
//   const BuildTextMessage(
//       {super.key,
//       required this.message,
//       required this.timestamp,
//       required this.chatCubit,
//       required this.userImage});
//   final String message;
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
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 message,
//                 style: const TextStyle(color: Colors.white),
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
