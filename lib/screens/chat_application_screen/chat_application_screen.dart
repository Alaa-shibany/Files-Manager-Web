// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:files_manager/core/functions/color_to_hex.dart';
// import 'package:files_manager/core/functions/snackbar_function.dart';
// import 'package:files_manager/core/shared/local_network.dart';
// import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
// import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
// import 'package:files_manager/cubits/chat_cubit/chat_settings_cubit/chat_settings_cubit.dart';
// import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
// import 'package:files_manager/generated/l10n.dart';
// import 'package:files_manager/widgets/chat_application/build_file_message.dart';
// import 'package:files_manager/widgets/chat_application/build_message_input.dart';
// import 'package:files_manager/widgets/chat_application/build_recording_banner.dart';
// import 'package:files_manager/widgets/chat_application/build_video_message.dart';
// import 'package:files_manager/widgets/chat_application/chat_settings_screen.dart';
// import 'package:files_manager/widgets/applications_widgets/settings_application_menu.dart';
// import 'package:files_manager/widgets/chat_application/build_audio_message.dart';
// import 'package:files_manager/widgets/chat_application/build_text_message.dart';
// import 'package:files_manager/widgets/custom_text_fields/custom_text_fields.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

// class ChatApplicationScreen extends StatelessWidget {
//   const ChatApplicationScreen({super.key, required this.boardCubit});
//   final BoardCubit boardCubit;
//   static String userImage = CashNetwork.getCashData(key: 'image');

//   @override
//   Widget build(BuildContext context) {
//     final chatCubit = context.read<ChatCubit>();
//     final mediaQuery = MediaQuery.of(context).size;
//     final localCubit = context.read<LocaleCubit>();

//     return BlocConsumer<ChatCubit, ChatState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Localizations.override(
//           locale: chatCubit.chatModel.langChatApp == 'default'
//               ? localCubit.locale
//               : Locale(chatCubit.chatModel.langChatApp),
//           context: context,
//           child: WillPopScope(
//             onWillPop: () async {
//               FocusScope.of(context).unfocus();
//               await boardCubit.refresh();
//               return true;
//             },
//             child: BlocConsumer<ChatCubit, ChatState>(
//               listener: (context, state) {
//                 if (state is ChatScreenRecordingStarted) {
//                   showLightSnackBar(
//                       context, S.of(context).screen_recording_started);
//                 }
//                 if (state is ChatScreenRecordingStopped) {
//                   showLightSnackBar(context,
//                       '${S.of(context).screen_recording_stopped} ${state.path}');
//                 }
//               },
//               builder: (context, state) {
//                 final showEmojiKeyboard = state is ChatEmojiKeyboardShown;
//                 return Scaffold(
//                   backgroundColor:
//                       allColors[chatCubit.chatModel.applicationColor]['real'],
//                   appBar: AppBar(
//                     title: CustomTextFields(
//                       controller: chatCubit.taskTitleController,
//                       onChanged: (p0) async {
//                         // await chatCubit.editTaskName();
//                       },
//                     ),
//                     centerTitle: true,
//                     actions: [
//                       SettingsApplicationMenu(
//                         onSelected: (value) {
//                           if (value == 'settings') {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                   builder: (context) => MultiBlocProvider(
//                                         providers: [
//                                           BlocProvider(
//                                             create: (context) =>
//                                                 ChatSettingsCubit(chatCubit),
//                                           ),
//                                           BlocProvider<ChatCubit>(
//                                             create: (context) =>
//                                                 ChatCubit(chatCubit.chatModel),
//                                           ),
//                                         ],
//                                         child: ChatSettingsScreen(
//                                             chatCubit: chatCubit),
//                                       )),
//                             );
//                             FocusScope.of(context).unfocus();
//                           } else if (value == 'delete') {
//                           } else {
//                             print(value);
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                   body: Column(
//                     children: [
//                       Expanded(
//                         child: chatCubit.messages.isEmpty
                            // ? Center(
                            //     child: Column(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         Icon(
                            //           Icons.message,
                            //           color: Colors.grey,
                            //           size: mediaQuery.width / 3,
                            //         ),
                            //         Text(S.of(context).no_messages_yet),
                            //       ],
                            //     ),
                            //   )
//                             : ListView.builder(
//                                 itemCount: chatCubit.messages.length,
//                                 itemBuilder: (context, index) {
//                                   final message = chatCubit.messages[index];
//                                   final timestamp =
//                                       chatCubit.messageTimestamps[index];
//                                   if (message.startsWith(
//                                           'screen_recording_message:') ||
//                                       message.startsWith(
//                                           'video_recording_message:')) {
//                                     final videoPath = message.split(': ')[1];
//                                     return BuildVideoMessage(
//                                       videoPath: videoPath,
//                                       chatCubit: chatCubit,
//                                       timestamp: timestamp,
//                                       userImage: userImage,
//                                     );
//                                   } else if (message
//                                       .startsWith('attach_file_message:')) {
//                                     final filePath = message.split(': ')[1];
//                                     return BuildFileMessage(
//                                       filePath: filePath,
//                                       chatCubit: chatCubit,
//                                     );
//                                   } else if (message
//                                       .startsWith('voice_message:')) {
//                                     final audioPath = message.split(': ')[1];
//                                     return BuildAudioMessage(
//                                       audioPath: audioPath,
//                                       chatCubit: chatCubit,
//                                       timestamp: timestamp,
//                                       userImage: userImage,
//                                     );
//                                   } else {
//                                     return BuildTextMessage(
//                                       message: message,
//                                       timestamp: timestamp,
//                                       chatCubit: chatCubit,
//                                       userImage: userImage,
//                                     );
//                                   }
//                                 },
//                               ),
//                       ),
                      // if (showEmojiKeyboard)
                      //   EmojiPicker(
                      //     onEmojiSelected: (category, emoji) {
                      //       chatCubit.textController.text += emoji.emoji;
                      //       chatCubit.emit(ChatMessageChanged());
                      //     },
                      //     config: const Config(),
                      //   ),
//                       BuildMessageInput(chatCubit: chatCubit),
//                       if (chatCubit.isRecordingScreen ||
//                           chatCubit.isRecordingAudio)
//                         BuildRecordingBanner(chatCubit: chatCubit),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
