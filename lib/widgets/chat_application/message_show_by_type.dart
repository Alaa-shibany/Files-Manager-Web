// import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
// import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
// import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:files_manager/core/shared/local_network.dart';
// import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
// import 'package:files_manager/models/chat_model.dart';
// import 'package:files_manager/widgets/chat_application/full_screen_video_player.dart';

// class MessageShowByType extends StatelessWidget {
//   const MessageShowByType({
//     super.key,
//     required this.message,
//     required this.chatCubit,
//     required this.mediaQuery,
//   });

//   final ChatMessageModel message;
//   final ChatCubit chatCubit;
//   final Size mediaQuery;

//   ChatMessageModel? findReplyMessage(
//       int? replyId, List<ChatMessageModel> messages) {
//     try {
//       return messages.firstWhere((msg) => msg.id == replyId);
//     } catch (e) {
//       return null;
//     }
//   }

//   static String? userID = CashNetwork.getCashData(key: 'id');

//   @override
//   Widget build(BuildContext context) {
//     final bool isPlaying = chatCubit.isPlayingAudioMap[message.id] ?? false;
//     final bool isLoading = chatCubit.isLoadingAudioMap[message.id] ?? false;
//     final Duration duration =
//         chatCubit.audioDurationMap[message.id] ?? Duration.zero;
//     final Duration position =
//         chatCubit.audioPositionMap[message.id] ?? Duration.zero;

//     Widget userAvatar() {
//       return CircleAvatar(
//         backgroundImage: NetworkImage(message.userMessageData.userImage),
//         radius: 18,
//         onBackgroundImageError: (_, __) => const Icon(Icons.person),
//         child: message.userMessageData.userImage.isEmpty
//             ? const Icon(Icons.person)
//             : null,
//       );
//     }

//     Widget replyMessage(ChatMessageModel? repliedMessage) {
//       if (repliedMessage == null) return const SizedBox();

//       return Padding(
//         padding: EdgeInsets.symmetric(horizontal: mediaQuery.width / 40),
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           margin: const EdgeInsets.only(bottom: 4),
//           decoration: BoxDecoration(
//             color: Colors.grey[400],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 4,
//                 height: 40,
//                 color: Colors.blue,
//                 margin: const EdgeInsets.only(right: 8),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       repliedMessage.userMessageData.name,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       repliedMessage.message ?? "Media",
//                       style: const TextStyle(fontSize: 12),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     switch (message.messageType) {
//       case 'text':
//         return Padding(
//           padding: EdgeInsets.all(mediaQuery.width / 40),
//           child: Row(
//             mainAxisAlignment: userID == message.userMessageData.id.toString()
//                 ? MainAxisAlignment.end
//                 : MainAxisAlignment.start,
//             children: [
//               if (userID != message.userMessageData.id.toString()) userAvatar(),
//               Container(
//                 constraints: BoxConstraints(maxWidth: mediaQuery.width / 2),
//                 child: Column(
//                   crossAxisAlignment:
//                       userID == message.userMessageData.id.toString()
//                           ? CrossAxisAlignment.end
//                           : CrossAxisAlignment.start,
//                   children: [
//                     if (message.reply != null)
//                       replyMessage(findReplyMessage(
//                           message.reply!.id, chatCubit.messagesData)),
//                     BubbleSpecialThree(
//                       text: message.message!,
//                       tail: true,
//                       delivered: chatCubit.deliveredMessage,
//                       isSender: userID == message.userMessageData.id.toString(),
//                     ).animate().fade(
//                           duration: const Duration(milliseconds: 500),
//                         ),
//                   ],
//                 ),
//               ),
//               if (userID == message.userMessageData.id.toString()) userAvatar(),
//             ],
//           ),
//         );
//       case 'file':
//         if (message.media!.endsWith(".jpg") ||
//             message.media!.endsWith(".png")) {
//           return Padding(
//             padding: EdgeInsets.all(mediaQuery.width / 40),
//             child: Container(
//               constraints: BoxConstraints(maxWidth: mediaQuery.width / 2),
//               child: Column(
//                 crossAxisAlignment:
//                     userID == message.userMessageData.id.toString()
//                         ? CrossAxisAlignment.end
//                         : CrossAxisAlignment.start,
//                 children: [
//                   if (message.reply != null)
//                     replyMessage(findReplyMessage(
//                         message.reply!.id, chatCubit.messagesData)),
//                   BubbleNormalImage(
//                     isSender: userID == message.userMessageData.id.toString(),
//                     delivered: chatCubit.deliveredMessage,
//                     id: 'id001',
//                     image: Image.network(
//                       message.media!,
//                       errorBuilder: (context, error, stackTrace) {
//                         return Icon(Icons.file_present_rounded,
//                             size: mediaQuery.width / 6);
//                       },
//                     ),
//                   ).animate().fade(duration: const Duration(milliseconds: 500)),
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return Padding(
//             padding: EdgeInsets.all(mediaQuery.width / 40),
//             child: Container(
//               constraints: BoxConstraints(maxWidth: mediaQuery.width / 2),
//               alignment: userID == message.userMessageData.id.toString()
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               child: Column(
//                 crossAxisAlignment:
//                     userID == message.userMessageData.id.toString()
//                         ? CrossAxisAlignment.end
//                         : CrossAxisAlignment.start,
//                 children: [
//                   if (message.reply != null)
//                     replyMessage(findReplyMessage(
//                         message.reply!.id, chatCubit.messagesData)),
//                   BubbleNormalFile(
//                     message: message,
//                     userID: userID!,
//                     onTap: () {
//                       // التعامل مع تحميل الملف
//                     },
//                     mediaQuery: mediaQuery,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }

//       case 'video':
//         return Padding(
//           padding: EdgeInsets.all(mediaQuery.width / 40),
//           child: Row(
//             mainAxisAlignment: userID == message.userMessageData.id.toString()
//                 ? MainAxisAlignment.end
//                 : MainAxisAlignment.start,
//             children: [
//               if (userID != message.userMessageData.id.toString()) userAvatar(),
//               Container(
//                 constraints: BoxConstraints(maxWidth: mediaQuery.width / 2),
//                 child: Column(
//                   crossAxisAlignment:
//                       userID == message.userMessageData.id.toString()
//                           ? CrossAxisAlignment.end
//                           : CrossAxisAlignment.start,
//                   children: [
//                     if (message.reply != null)
//                       replyMessage(findReplyMessage(
//                           message.reply!.id, chatCubit.messagesData)),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) =>
//                               //  FullScreenVideoPlayer(
//                               //     videoPath:
//                               //         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),

//                               FullScreenVideoPlayer(videoPath: message.media!),
//                         ));
//                       },
//                       child: SizedBox(
//                         width: mediaQuery.width / 2.5,
//                         height: mediaQuery.height / 5,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Image.network(
//                               message.media!,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                   'assets/images/video_placeholder.png',
//                                   width: mediaQuery.width / 2,
//                                   height: mediaQuery.height / 4,
//                                   fit: BoxFit.cover,
//                                 );
//                               },
//                             ),
//                             const Icon(Icons.play_circle_fill,
//                                 size: 64, color: Colors.white),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ).animate().fade(duration: const Duration(milliseconds: 500)),
//               if (userID == message.userMessageData.id.toString()) userAvatar(),
//             ],
//           ),
//         );

//       case 'voice':
//         final double maxDuration =
//             duration.inSeconds > 0 ? duration.inSeconds.toDouble() : 0.0;
//         final double currentPosition =
//             (position.inSeconds <= duration.inSeconds)
//                 ? position.inSeconds.toDouble()
//                 : 0.0;

//         // Determine if audioPath is local or network
//         final bool isNetworkAudio = message.media!.startsWith('http') ||
//             message.media!.startsWith('https');

//         return Container(
//           constraints: BoxConstraints(maxWidth: mediaQuery.width / 2),
//           child: Column(
//             crossAxisAlignment: userID == message.userMessageData.id.toString()
//                 ? CrossAxisAlignment.end
//                 : CrossAxisAlignment.start,
//             children: [
//               if (message.reply != null)
//                 replyMessage(findReplyMessage(
//                     message.reply!.id, chatCubit.messagesData)),
//               BubbleNormalAudio(
//                 isSender: userID == message.userMessageData.id.toString(),
//                 delivered: chatCubit.deliveredMessage,
//                 color: const Color(0xFFE8E8EE),
//                 duration: maxDuration,
//                 position: currentPosition,
//                 isPlaying: isPlaying,
//                 isLoading: isLoading,
//                 isPause: !isPlaying && position > Duration.zero,
//                 onSeekChanged: (value) {
//                   chatCubit.seekAudio(message.id, value);
//                 },
//                 onPlayPauseButtonClick: () {
//                   if (isPlaying) {
//                     chatCubit.stopAudio(message.id);
//                   } else {
//                     if (isNetworkAudio) {
//                       // Handle network audio playback
//                       chatCubit.playAudio(message.id, message.media!,
//                           isLocal: false);
//                     } else {
//                       // Handle local audio playback
//                       chatCubit.playAudio(message.id, message.media!,
//                           isLocal: true);
//                     }
//                   }
//                 },
//                 sent: true,
//               ).animate().fade(
//                     duration: const Duration(milliseconds: 500),
//                   ),
//             ],
//           ),
//         );

//       default:
//         return const ListTile(
//           leading: Icon(Icons.error_outline, color: Colors.red),
//           title: Text("File not found"),
//         ).animate().fade(
//               duration: const Duration(milliseconds: 500),
//             );
//     }
//   }
// }

// class BubbleNormalFile extends StatelessWidget {
//   const BubbleNormalFile({
//     super.key,
//     required this.onTap,
//     required this.mediaQuery,
//     required this.message,
//     required this.userID,
//   });

//   final VoidCallback onTap;
//   final Size mediaQuery;
//   final ChatMessageModel message;
//   final String userID;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: mediaQuery.width / 2,
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.only(
//           topLeft: const Radius.circular(12),
//           topRight: const Radius.circular(12),
//           bottomLeft: userID == message.userMessageData.id.toString()
//               ? const Radius.circular(0)
//               : const Radius.circular(12),
//           bottomRight: userID == message.userMessageData.id.toString()
//               ? const Radius.circular(12)
//               : const Radius.circular(0),
//         ),
//       ),
//       child: ListTile(
//         leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
//         title: const Text("Download File"),
//         onTap: onTap,
//       ).animate().fade(duration: const Duration(milliseconds: 500)),
//     );
//   }
// }
