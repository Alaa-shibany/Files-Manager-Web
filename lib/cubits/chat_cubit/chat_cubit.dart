import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dioo;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:open_file/open_file.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/connect.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/models/folder_model.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatModel) : super(ChatInitial());
  final FolderModel chatModel;
  TextEditingController taskTitleController = TextEditingController();

  List<String> messages = [];
  List<DateTime> messageTimestamps = [];
  bool isRecordingAudio = false;
  bool isRecordingScreen = false;
  bool hasMedia = false;
  final AudioRecorder audioRecorder = AudioRecorder();
  String? recordedAudioPath;
  // final AudioPlayer audioPlayer = AudioPlayer();
  //Remove This Var : //
  bool isPlayingAudio = false;
  bool isLoadingAudio = false;
  bool isPausedAudio = false;
  Duration audioDuration = Duration.zero;
  Duration audioPosition = Duration.zero;
  //==================== //

  bool openVideo = false;
  bool emojiKeyboard = false;
  TextEditingController messageController = TextEditingController();
  FocusNode messageFucusNode = FocusNode();
  TextEditingController messageTextController =
      TextEditingController(text: '.');
  IconData fileIcon = Icons.insert_drive_file;
  List<ChatMessageModel> messagesData = [];
  final int pageSize = 10;
  bool isReplying = false;
  ChatMessageModel? messageToReply;
  bool deliveredMessage = false;
  final ScrollController scrollController = ScrollController();
  ScrollController chatScrollController = ScrollController();

  PagingController<int, ChatMessageModel> pagingController =
      PagingController(firstPageKey: 1);

  Future<void> initState({
    required BuildContext context,
    required int applicationId,
  }) async {
    taskTitleController = TextEditingController(text: chatModel.title);

    pagingController.addPageRequestListener(
      (pageKey) async {
        getMessagesFun(
            context: context, applicationId: applicationId, pageKey: pageKey);
      },
    );
    FirebaseMessaging.onMessage.listen((message) async {
      print('Hello message ${message.data}');
      ChatMessageModel comment =
          ChatMessageModel.fromJson(json.decode(message.data['chat_message']));

      pagingController.itemList!.insert(
        0,
        comment,
      );
      emit(ChatInitial());
    });
    // await scrollToBottom();
    emit(ChatInitial());
  }

  Future<void> editTaskName() async {
    // chatModel.title = taskTitleController.text;
    emit(ChatEditData());
  }

  Future<void> refresh() async {
    taskTitleController = TextEditingController(text: chatModel.title);
    messageTextController = TextEditingController(text: '.');
    emit(ChatInitial());
  }

  Future<void> selectApplicationColor(int newColorIndex) async {
    chatModel.applicationColor = newColorIndex;
    print('new application name => ${chatModel.applicationColor}');
    emit(ChatInitial());
  }

  // void iconSendFile(String filePath) {
  //   if (filePath.endsWith('.pdf')) {
  //     fileIcon = Icons.picture_as_pdf;
  //   } else if (filePath.endsWith('.mp4') || filePath.endsWith('.mov')) {
  //     fileIcon = Icons.video_file;
  //   } else if (filePath.endsWith('.jpg') || filePath.endsWith('.png')) {
  //     fileIcon = Icons.image;
  //   } else {
  //     fileIcon = Icons.insert_drive_file;
  //   }
  // }

  // Future<String?> generateThumbnail(String videoPath) async {
  //   final thumbnail = await VideoThumbnail.thumbnailFile(
  //     video: videoPath,
  //     imageFormat: ImageFormat.JPEG,
  //     maxHeight: 200,
  //     quality: 75,
  //   );
  //   return thumbnail;
  // }

  Future<void> sendMessageFun({
    required BuildContext context,
    required ChatMessageModel chatMessage,
    required int applicationId,
    required String messageType,
    required int? replayMessageId,
    PlatformFile? file,
  }) async {
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      FormData formData = FormData();
      formData.fields.add(MapEntry('message_type', messageType));
      formData.fields.add(MapEntry('message', chatMessage.message!));
      print('the save message is =>${chatMessage.message!}');
      if (replayMessageId != null) {
        formData.fields.add(MapEntry('reply_id', replayMessageId.toString()));
      }
      if (file != null) {
        formData.files.add(
          MapEntry(
            'file',
            await MultipartFile.fromFile(
              file.path!,
              filename: file.name,
              contentType: Dioo.DioMediaType('application', 'octet-stream'),
            ),
          ),
        );
      }
      final response = await dio().post(
        'chats/send-message-in-chat-application/${chatModel.id}',
        data: formData,
        options: Dioo.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      print('The status code is => ${response.statusCode}');
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        chatMessage.isSent = true;
        chatMessage.id = response.data['chat_message']['id'];
        emit(ChatInitial());
      }
    } on DioException catch (e) {
      print('Dio Error is ${e.message}');
      errorHandler(e: e, context: context);
      print(e.response!.data);
      if (e.response?.statusCode == 422) {
        print('<===== ERROR FOR 422 STATUS CODE IS =====>');
        print(e.message);
        print(e.requestOptions.data);
        print(e.requestOptions.path);
      }
      chatMessage.isSent = false;
      emit(ChatInitial());
    } catch (e) {
      print('General Error is ${e.toString()}');
      chatMessage.isSent = false;
      emit(ChatInitial());
    }
  }

  //Success Functions To Use ::: From TASKS Comment
  void setReplyingMessage(ChatMessageModel message) {
    isReplying = true;
    messageToReply = message;
    emit(ChatReplying(message: message));
  }

  void cancelReplying() {
    isReplying = false;
    messageToReply = null;
    emit(ChatReplyCancelled());
  }

  void handlePopupMenuSelection(String value, BuildContext context) async {
    switch (value) {
      case 'files':
        await pickFiles(context);
        break;
      case 'audio':
        if (!isRecordingAudio) {
          await startAudioRecording();
        } else {
          await stopAudioRecording(context);
        }
        break;
      case 'video':
        await recordVideo(context);
        break;
      case 'screen':
        if (isRecordingScreen) {
          await stopScreenRecording(context);
        } else {
          await startScreenRecording();
        }
        break;
    }
  }

  Future<void> selectEmoji(String newIcon) async {
    messageController.text = messageController.text + newIcon;
    emit(ChatInitial());
  }

  Future<void> showEmojiKeyboard() async {
    emojiKeyboard = !emojiKeyboard;
    emit(ChatInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    print('scroll');
    await chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    emit(ChatInitial());
  }

  Future<void> getMessagesFun({
    required BuildContext context,
    required int applicationId,
    required int pageKey,
  }) async {
    try {
      emit(FetchChatMessagesLoading());
      String? token = CashNetwork.getCashData(key: 'token');
      print('The page we will get is => $pageKey');
      final response = await dio().get(
        'chats/get-messages-in-chat-application/$applicationId',
        queryParameters: {'page': pageKey},
        options: Dioo.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        final List jsonData =
            await response.data['chat_messages']['data'] as List;
        final List<ChatMessageModel> newMessages =
            jsonData.map((e) => ChatMessageModel.fromJson(e)).toList();
        print('we will emit success');
        messagesData.addAll(newMessages);
        emit(FetchChatMessagesSuccess(
            newMessages: newMessages,
            isReachMax:
                response.data['chat_messages']['links']['next'] == null));
      }
      if (response.statusCode == 204) {
        emit(FetchChatMessagesSuccess(
          newMessages: messagesData = [],
          isReachMax: false,
        ));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        await checkInternet()
            ? emit(FetchChatMessagesServerError())
            : emit(FetchChatMessagesNoINternet());
        print('Connection Error.');
        return;
      }
      errorHandlerWithoutInternet(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(FetchChatMessagesExpiredToken());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(FetchChatMessagesFailure(errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(FetchChatMessagesFailure(errorMessage: 'Catch exception'));
      print(e);
    }
  }

//***************************************************************************************** */

  Future<void> pickFiles(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      ChatMessageModel newMessage = ChatMessageModel(
          id: null,
          userMessageData: UserMessageData(id: -1, name: 'You', userImage: ''),
          messageType: 'file',
          message: '${file.path}',
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: null,
          isSent: false,
          media: null,
          isMedia: true,
          isDirty: null,
          boardApplication: null,
          reply: null,
          isFormAPi: null);
      print('Adding the message');
      pagingController.itemList!.insert(0, newMessage);
      String message = messageController.text;
      messageController = TextEditingController();
      print('We will emit from pick file function');
      print(message);
      emit(ChatInitial());
      await sendMessageFun(
        chatMessage: newMessage,
        context: context,
        messageType: 'file',
        replayMessageId: null,
        applicationId: chatModel.id,
        file: file,
      );
    }
  }

  Future<void> startAudioRecording() async {
    if (await audioRecorder.hasPermission()) {
      recordedAudioPath = await getAudioFilePath();
      await audioRecorder.start(const RecordConfig(), path: recordedAudioPath!);
      isRecordingAudio = true;
      emit(ChatInitial());
    }
  }

  Future<String> getAudioFilePath() async {
    String filePath =
        '/storage/emulated/0/Download/recorded_audio_${DateTime.now().millisecondsSinceEpoch}.mp3';
    return filePath;
  }

  Future<void> stopAudioRecording(BuildContext context) async {
    await audioRecorder.stop();
    if (recordedAudioPath != null) {
      isRecordingAudio = false;

      final File audioFile = File(recordedAudioPath!);
      final fileName = audioFile.path.split('/').last;
      final fileSize = await audioFile.length();

      ChatMessageModel newMessage = ChatMessageModel(
          id: null,
          userMessageData: UserMessageData(id: -1, name: 'You', userImage: ''),
          messageType: 'voice',
          message: '$recordedAudioPath',
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: null,
          isSent: false,
          media: null,
          isMedia: true,
          isDirty: null,
          boardApplication: null,
          reply: null,
          isFormAPi: null);
      print('Adding the message');
      pagingController.itemList!.insert(0, newMessage);
      String message = messageController.text;
      messageController = TextEditingController();

      print('We will emit in voice stop record');
      print(message);
      emit(ChatInitial());
      await sendMessageFun(
        chatMessage: newMessage,
        context: context,
        messageType: 'voice',
        replayMessageId: null,
        applicationId: chatModel.id,
        file: PlatformFile(
          path: recordedAudioPath,
          name: fileName,
          size: fileSize,
        ),
      );
      // await sendMessageFun(
      //   context: context,
      //   applicationId: chatModel.id,
      //   messageType: 'voice',
      //   replayMessageId: messageToReply?.id,
      //   file: PlatformFile(
      //     path: recordedAudioPath,
      //     name: fileName,
      //     size: fileSize,
      //   ),
      // );
    }
  }

  final ImagePicker imagePicker = ImagePicker();

  Future<void> recordVideo(BuildContext context) async {
    final XFile? video =
        await imagePicker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      // String? thumbnailPath = await generateThumbnail(video.path);
      ChatMessageModel newMessage = ChatMessageModel(
          id: null,
          userMessageData: UserMessageData(id: -1, name: 'You', userImage: ''),
          messageType: 'file',
          message: video.path,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: null,
          isSent: false,
          media: null,
          isMedia: true,
          isDirty: null,
          boardApplication: null,
          reply: null,
          isFormAPi: null);
      print('Adding the message');
      pagingController.itemList!.insert(0, newMessage);
      String message = messageController.text;
      messageController = TextEditingController();

      print('We will emit');
      print(message);
      emit(ChatInitial());
      await sendMessageFun(
        chatMessage: newMessage,
        context: context,
        messageType: 'video',
        replayMessageId: null,
        applicationId: chatModel.id,
        file: PlatformFile(
          path: video.path,
          name: video.name,
          size: await File(video.path).length(),
        ),
      );
    }
  }

  Future<void> stopScreenRecording(BuildContext context) async {
    try {
      // String? videoPath = await FlutterScreenRecording.stopRecordScreen;
      // String? thumbnailPath = await generateThumbnail(videoPath);
      isRecordingScreen = false;

      // await sendScreenRecording(videoPath, context);
    } catch (e) {
      print('Error stopping screen recording: $e');
    }
  }

  Future<void> sendScreenRecording(
      String videoPath, BuildContext context) async {
    ChatMessageModel newMessage = ChatMessageModel(
        id: null,
        userMessageData: UserMessageData(id: -1, name: 'You', userImage: ''),
        messageType: 'screen',
        message: videoPath,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: null,
        isSent: false,
        media: null,
        isMedia: true,
        isDirty: null,
        boardApplication: null,
        reply: null,
        isFormAPi: null);
    print('Adding the message');
    pagingController.itemList!.insert(
      0,
      newMessage,
    );
    String message = messageController.text;
    messageController = TextEditingController();

    print('We will emit in screen recording');
    print(message);
    emit(ChatInitial());
    await sendMessageFun(
      chatMessage: newMessage,
      context: context,
      messageType: 'screen',
      replayMessageId: null,
      applicationId: chatModel.id,
      file: PlatformFile(
        path: videoPath,
        name: 'screen_recording.mp4',
        size: await File(videoPath).length(),
      ),
    );
  }

  Future<void> startScreenRecording() async {
    try {
      // await FlutterScreenRecording.startRecordScreen('video1');
      isRecordingScreen = true;
      emit(ChatInitial());
    } catch (e) {
      print('Error starting screen recording: $e');
    }
  }

  void openFile(String filePath) async {
    if (filePath.startsWith('http') || filePath.startsWith('https')) {
      try {
        var tempDir = await getTemporaryDirectory();
        String tempPath = '${tempDir.path}/${filePath.split('/').last}';
        Dio dio = Dio();
        await dio.download(filePath, tempPath);
        OpenFile.open(tempPath);
      } catch (e) {
        print("Failed to download and open the file: $e");
      }
    } else {
      OpenFile.open(filePath);
    }
  }

//tets function for file: Comment last function and UnComment this function to see error when open the fil
  // void openFile(String filePath) async {
  //   PermissionStatus status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     status = await Permission.storage.request();
  //   }
  //   // if (status.isDenied || status.isPermanentlyDenied) {
  //   //   openAppSettings();
  //   // }

  //   if (status.isGranted) {
  //     if (filePath.startsWith('http') || filePath.startsWith('https')) {
  //       try {
  //         var tempDir = await getTemporaryDirectory();
  //         String tempPath = '${tempDir.path}/${filePath.split('/').last}';
  //         Dio dio = Dio();
  //         await dio.download(filePath, tempPath);
  //         var result = await OpenFile.open(tempPath);
  //         print('OpenFile result: ${result.message}');
  //       } catch (e) {
  //         print("Failed to download and open the file: $e");
  //       }
  //     } else {
  //       print('Hello From else condition in openFile');
  //       print(filePath);
  //       var result = await OpenFile.open(filePath);
  //       print('OpenFile result: ${result.message}');
  //     }
  //   } else {
  //     print('Permission denied by user');
  //   }
  // }

  Future<void> sendMessage({
    required BuildContext context,
    required String? replyId,
  }) async {
    ChatMessageModel newMessage = ChatMessageModel(
        id: null,
        userMessageData: UserMessageData(id: -1, name: 'You', userImage: ''),
        messageType: 'text',
        message: messageController.text,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: null,
        isSent: false,
        media: null,
        isDirty: null,
        boardApplication: null,
        reply: null,
        isFormAPi: null);
    print('Adding the message');
    pagingController.itemList!.insert(0, newMessage);
    String message = messageController.text;
    messageController = TextEditingController();
    print('We will emit $isReplying $replyId');
    print(message);
    emit(ChatInitial());
    await sendMessageFun(
      chatMessage: newMessage,
      context: context,
      applicationId: chatModel.id,
      messageType: 'text',
      replayMessageId: isReplying ? messageToReply?.id : null,
    );
  }
}
