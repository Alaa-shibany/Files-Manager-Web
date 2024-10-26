import 'dart:convert';
import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as Dioo;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:files_manager/core/functions/apis_error_handler.dart';
import 'package:files_manager/core/server/dio_settings.dart';
import 'package:files_manager/core/shared/connect.dart';
import 'package:files_manager/core/shared/local_network.dart';
import 'package:files_manager/cubits/task_documents_cubit/task_documents_cubit.dart';
import 'package:files_manager/models/document_model.dart';
import 'package:files_manager/models/task_comment_model.dart';
import 'package:files_manager/models/task_model.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

part 'task_comments_state.dart';

class TaskCommentsCubit extends Cubit<TaskCommentsState> {
  TaskCommentsCubit({
    required this.taskModel,
  }) : super(TaskCommentsInitial());
  final TaskModel taskModel;
  TextEditingController messageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();

  Map<int, bool> isPlayingAudioMap = {};
  Map<int, bool> isLoadingAudioMap = {};
  Map<int, bool> isPausedAudioMap = {};
  Map<int, Duration> audioDurationMap = {};
  Map<int, Duration> audioPositionMap = {};
  final int pageSize = 10;
  PagingController<int, TaskComment> pagingController =
      PagingController(firstPageKey: 1);
  ScrollController chatScrollController = ScrollController();
  bool isReplying = false;
  bool isRecordingAudio = false;

  Future<void> initState({required BuildContext context}) async {
    pagingController.addPageRequestListener((pageKey) {
      getAllComments(context: context, pageKey: pageKey);
    });
    FirebaseMessaging.onMessage.listen((message) async {
      print('Hello message ${message.data}');
      TaskComment comment =
          TaskComment.fromJson(json.decode(message.data['comment']));
      print('the user is =>${CashNetwork.getCashData(key: 'id')}');
      if (CashNetwork.getCashData(key: 'id') == comment.user!.id.toString()) {
        print('the same user');
        return;
      }
      taskModel.allComments.insert(0, comment);
      pagingController.itemList!.insert(
        0,
        comment,
      );
      emit(TaskCommentsInitial());
    });
  }

  // final AudioPlayer audioPlayer = AudioPlayer();

  bool emojiKeyboard = false;
  TaskComment? messageToReply;

  Future<void> pickFiles(
    BuildContext context,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      TaskComment newComment = TaskComment(
          id: null,
          user: User(
              id: -1,
              name:
                  '${CashNetwork.getCashData(key: 'first_name')} ${CashNetwork.getCashData(key: 'last_name')}',
              image: ''),
          type: 'file',
          comment: '${file.path}',
          createdAt: DateTime.now(),
          updatedAt: null,
          isSent: false,
          media: null,
          isMedia: true,
          isDirty: null);
      print('Adding the message');
      taskModel.allComments.insert(0, newComment);
      pagingController.itemList!.insert(
        0,
        newComment,
      );
      String message = messageController.text;
      messageController = TextEditingController();

      print('We will emit');
      print(message);
      emit(TaskCommentsInitial());
      await sendMessageFun(
        context: context,
        messageType: 'file',
        replayMessageId: null,
        commentIndex: pagingController.itemList!.length - 1,
        taskComment: newComment,
        file: file,
      );
    }
  }

  bool isRecordingScreen = false;

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

  // Future<String?> generateThumbnail(String videoPath) async {
  //   // final thumbnail = await VideoThumbnail.thumbnailFile(
  //   //   video: videoPath,
  //   //   imageFormat: ImageFormat.JPEG,
  //   //   maxHeight: 200,
  //   //   quality: 75,
  //   // );
  //   // return thumbnail;
  // }

  String? recordedAudioPath;

  final AudioRecorder audioRecorder = AudioRecorder();

  final ImagePicker imagePicker = ImagePicker();

  Future<void> recordVideo(BuildContext context) async {
    final XFile? video =
        await imagePicker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      // String? thumbnailPath = await generateThumbnail(video.path);
      TaskComment newComment = TaskComment(
          id: null,
          user: User(
              id: -1,
              name:
                  '${CashNetwork.getCashData(key: 'first_name')} ${CashNetwork.getCashData(key: 'last_name')}',
              image: ''),
          type: 'video',
          comment: video.path,
          createdAt: DateTime.now(),
          updatedAt: null,
          isSent: false,
          media: null,
          isMedia: true,
          isDirty: null);
      print('Adding the message');
      taskModel.allComments.insert(0, newComment);
      pagingController.itemList!.insert(
        0,
        newComment,
      );
      String message = messageController.text;
      messageController = TextEditingController();

      print('We will emit');
      print(message);
      emit(TaskCommentsInitial());
      await sendMessageFun(
        context: context,
        messageType: 'video',
        replayMessageId: null,
        commentIndex: pagingController.itemList!.length - 1,
        taskComment: newComment,
        file: PlatformFile(
          path: video.path,
          name: video.name,
          size: await File(video.path).length(),
        ),
      );
    }
  }

  Future<void> startScreenRecording() async {
    try {
      // await FlutterScreenRecording.startRecordScreen('video1');
      isRecordingScreen = true;
      emit(TaskCommentsInitial());
    } catch (e) {
      print('Error starting screen recording: $e');
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
    TaskComment newComment = TaskComment(
        id: null,
        user: User(
            id: -1,
            name:
                '${CashNetwork.getCashData(key: 'first_name')} ${CashNetwork.getCashData(key: 'last_name')}',
            image: ''),
        type: 'screen',
        comment: videoPath,
        createdAt: DateTime.now(),
        updatedAt: null,
        isSent: false,
        media: null,
        isMedia: true,
        isDirty: null);
    print('Adding the message');
    taskModel.allComments.insert(0, newComment);
    pagingController.itemList!.insert(
      0,
      newComment,
    );
    String message = messageController.text;
    messageController = TextEditingController();

    print('We will emit');
    print(message);
    emit(TaskCommentsInitial());
    await sendMessageFun(
      context: context,
      messageType: 'screen',
      replayMessageId: null,
      commentIndex: pagingController.itemList!.length - 1,
      taskComment: newComment,
      file: PlatformFile(
        path: videoPath,
        name: 'screen_recording.mp4',
        size: await File(videoPath).length(),
      ),
    );
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

  Future<void> startAudioRecording() async {
    if (await audioRecorder.hasPermission()) {
      recordedAudioPath = await getAudioFilePath();
      await audioRecorder.start(const RecordConfig(), path: recordedAudioPath!);
      isRecordingAudio = true;
      emit(TaskCommentsInitial());
    }
  }

  Future<String> getAudioFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    print(
        '${directory.path}/recorded_audio_${DateTime.now().millisecondsSinceEpoch}.m4a');
    return '${directory.path}/recorded_audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
  }

  Future<void> cancelRecord() async {
    await audioRecorder.stop();
    isRecordingAudio = false;
    emit(TaskCommentsInitial());
  }

  Future<void> stopAudioRecording(BuildContext context) async {
    await audioRecorder.stop();
    if (recordedAudioPath != null) {
      isRecordingAudio = false;
      print('Path audio is LOCALLY $recordedAudioPath');
      final File audioFile = File(recordedAudioPath!);
      final fileName = audioFile.path.split('/').last;
      final fileSize = await audioFile.length();

      TaskComment newComment = TaskComment(
          id: null,
          user: User(
              id: -1,
              name:
                  '${CashNetwork.getCashData(key: 'first_name')} ${CashNetwork.getCashData(key: 'last_name')}',
              image: ''),
          type: 'voice',
          comment: '$recordedAudioPath',
          createdAt: DateTime.now(),
          updatedAt: null,
          isSent: false,
          media: null,
          isMedia: true,
          isDirty: null);
      print('Adding the message');
      taskModel.allComments.insert(0, newComment);
      pagingController.itemList!.insert(
        0,
        newComment,
      );
      String message = messageController.text;
      messageController = TextEditingController();

      print('We will emit');
      print(message);
      emit(TaskCommentsInitial());
      await sendMessageFun(
        context: context,
        messageType: 'voice',
        replayMessageId: null,
        commentIndex: pagingController.itemList!.length - 1,
        taskComment: newComment,
        file: PlatformFile(
          path: recordedAudioPath,
          name: fileName,
          size: fileSize,
        ),
      );
    }
  }

  // Future<void> playAudio(int messageId, String audioPath,
  //     {bool isLocal = true}) async {
  //   isLoadingAudioMap[messageId] = true;
  //   emit(TaskCommentsInitial());

  //   try {
  //     if (isLocal) {
  //       print('Audio Path in local is : =====> $audioPath');
  //       await audioPlayer.play(DeviceFileSource(audioPath));
  //     } else {
  //       print('Audio Path in Network is : =====> $audioPath');
  //       await audioPlayer.play(UrlSource(audioPath));
  //     }

  //     isPlayingAudioMap[messageId] = true;
  //     isLoadingAudioMap[messageId] = false;

  //     audioPlayer.onPositionChanged.listen((Duration p) {
  //       audioPositionMap[messageId] = p;
  //       emit(TaskCommentsInitial());
  //     });

  //     audioPlayer.onDurationChanged.listen((Duration d) {
  //       audioDurationMap[messageId] = d;
  //       emit(TaskCommentsInitial());
  //     });

  //     audioPlayer.onPlayerComplete.listen((event) {
  //       isPlayingAudioMap[messageId] = false;
  //       emit(TaskCommentsInitial());
  //     });
  //   } catch (e) {
  //     isPlayingAudioMap[messageId] = false;
  //     isLoadingAudioMap[messageId] = false;
  //     print("Error playing audio: $e");
  //   }
  // }

  // Future<void> stopAudio(int messageId) async {
  //   await audioPlayer.stop();
  //   isPlayingAudioMap[messageId] = false;
  // }

  // void seekAudio(int messageId, double position) {
  //   audioPlayer.seek(Duration(seconds: position.toInt()));
  //   emit(TaskCommentsInitial());
  // }

  Future<void> sendMessage({
    required BuildContext context,
    required String? replyId,
  }) async {
    TaskComment newComment = TaskComment(
        id: null,
        user: User(
            id: -1,
            name:
                '${CashNetwork.getCashData(key: 'first_name')} ${CashNetwork.getCashData(key: 'last_name')}',
            image: ''),
        type: 'text',
        comment: messageController.text,
        createdAt: DateTime.now(),
        updatedAt: null,
        isSent: false,
        media: null,
        isDirty: null);
    print('Adding the message');
    taskModel.allComments.insert(0, newComment);
    pagingController.itemList!.insert(
      0,
      newComment,
    );
    String message = messageController.text;
    messageController = TextEditingController();
    print('We will emit $isReplying $replyId');
    print(message);
    emit(TaskCommentsInitial());
    await sendMessageFun(
      context: context,
      taskComment: newComment,
      commentIndex: pagingController.itemList!.length - 1,
      messageType: 'text',
      replayMessageId: isReplying ? messageToReply?.id : null,
    );
  }

  Future<void> sendMessageFun({
    required BuildContext context,
    required TaskComment taskComment,
    required int commentIndex,
    // required int applicationId,
    required String messageType,
    required int? replayMessageId,
    TaskDocumentsCubit? taskDocumentCubit,
    PlatformFile? file,
  }) async {
    try {
      String? token = CashNetwork.getCashData(key: 'token');
      FormData formData = FormData();
      formData.fields.add(MapEntry('type', messageType));
      formData.fields.add(MapEntry('comment', taskComment.comment!));
      print('the save comment is =>${taskComment.comment}');
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
        'tasks/add-comment-in-task/${taskModel.id}',
        data: formData,
        options: Dioo.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      print('The status code is => ${response.statusCode}');
      print(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        taskComment.isSent = true;
        taskComment.id = response.data['comment']['id'];

        taskModel.commentsCount++;
        if (file != null) {
          print('we will send');
          taskModel.attachmentsCount++;

          emit(TaskCommentsSendMessageState(
            documentModel: DocumentModel(
              createdAt: DateTime.now(),
              extension: file.extension!,
              fileName: file.name,
              originalUrl: file.path!,
              name: '',
              size: 0,
            ),
          ));
        } else {
          emit(TaskCommentsInitial());
        }
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
      taskComment.isSent = false;
      emit(TaskCommentsInitial());
    } catch (e) {
      print('General Error is ${e.toString()}');
      taskComment.isSent = false;
      emit(TaskCommentsInitial());
    }
  }

  void setReplyingMessage(TaskComment message) async {
    isReplying = true;
    messageToReply = TaskComment(
        id: message.id,
        user: message.user,
        type: message.type,
        comment: message.comment,
        createdAt: message.createdAt,
        updatedAt: message.updatedAt,
        media: message.media,
        isDirty: message.isDirty);
    emit(CommentsReplying(taskComment: message));
    await Future.delayed(const Duration(milliseconds: 300));
    print('scroll');
    await chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    emit(TaskCommentsInitial());
  }

  void cancelReplying() {
    isReplying = false;
    messageToReply = null;
    emit(CommentsReplyCancelled());
  }

  Future<void> showEmojiKeyboard() async {
    emojiKeyboard = !emojiKeyboard;
    emit(TaskCommentsInitial());
    await Future.delayed(const Duration(milliseconds: 300));
    print('scroll');
    await chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
    emit(TaskCommentsInitial());
  }

  Future<void> selectEmoji(String newIcon) async {
    messageController.text = messageController.text + newIcon;
    emit(TaskCommentsInitial());
  }

  Future<void> getAllComments({
    required BuildContext context,
    required int pageKey,
  }) async {
    try {
      emit(TaskCommentsLoadingState());
      String? token = CashNetwork.getCashData(key: 'token');
      print('The page we will get is => $pageKey');
      final response = await dio().get(
        'tasks/get-task-comments/${taskModel.id}',
        queryParameters: {'page': pageKey},
        options: Dioo.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      print('The status code is => ${response.statusCode}');
      print(response.data);
      if (response.statusCode == 200) {
        final List jsonData = await response.data['comments']['data'] as List;
        final List<TaskComment> newComments =
            jsonData.map((e) => TaskComment.fromJson(e)).toList();
        print('we will emit success');
        taskModel.allComments.addAll(newComments);
        emit(TaskCommentsSuccessState(
            allComments: newComments.reversed.toList(),
            isReachMax: response.data['comments']['links']['next'] == null));
      }
      if (response.statusCode == 204) {
        emit(
            TaskCommentsSuccessState(allComments: const [], isReachMax: false));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        await checkInternet()
            ? emit(TaskCommentsServerState())
            : emit(TaskCommentsInternetState());
        print('Connection Error.');
        return;
      }
      errorHandlerWithoutInternet(e: e, context: context);
      if (e.response!.statusCode == 401) {
        emit(TaskCommentsExpiredState());
        return;
      }
      print('The response is => ${e.response!.data}');
      print('The failed status code is ${e.response!.statusCode}');
      emit(TaskCommentsFailedState(errorMessage: e.response!.data['message']));
    } catch (e) {
      print('================ catch exception =================');
      print(e);
      emit(TaskCommentsFailedState(errorMessage: 'Catch exception'));
      print(e);
    }
  }
}
