import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/chat_cubit/chat_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';
import 'package:files_manager/models/application_board.dart';
import 'package:files_manager/models/language_model.dart';
import 'package:files_manager/screens/chat_application_screen/chat_screen_test.dart';

import '../cubits/all_boards_cubit/all_boards_cubit.dart';
import '../cubits/delete_application_cubit/delete_application_cubit.dart';

class ChatModel extends Application {
  BoardCubit? boardCubit;
  int? applicationColor;
  String langChatApp = 'default';
  int id;
  int boardId;
  ApplicationBoard application;
  String color;
  Language language;
  String? firstDay;
  String title;
  String mode;
  bool showIcon;
  bool showTitle;
  bool showDescription;
  String createdAt;
  String updatedAt;
  List<ChatMessageModel> allMessages = [];
  ChatModel({
    required this.id,
    required this.boardId,
    required this.application,
    required this.color,
    required this.language,
    required this.firstDay,
    required this.title,
    required this.mode,
    required this.showIcon,
    required this.showTitle,
    required this.showDescription,
    required this.createdAt,
    required this.updatedAt,
    this.boardCubit,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      boardId: json['board_id'],
      application: ApplicationBoard.fromJson(json['application']),
      color: json['color'],
      language: Language.fromJson(json['language']),
      firstDay: json['first_day'] ?? '',
      title: json['title'],
      mode: json['mode'],
      showIcon: json['show_icon'],
      showTitle: json['show_title'],
      showDescription: json['show_description'],
      createdAt: DateTime.parse(json['created_at']).toIso8601String(),
      updatedAt: DateTime.parse(json['updated_at']).toIso8601String(),
    );
  }

  @override
  IconData getIcon() {
    return Icons.chat;
  }

  @override
  String getApplicationName() {
    return title;
  }

  @override
  int getApplicationId() {
    return id;
  }

  Locale getApplicationLanguage(BuildContext context) {
    final langChatApp = context.read<LocaleCubit>().locale;
    return langChatApp;
  }

  @override
  void updateApplicationColor(int colorIndex, String hex) {
    color = hex;
    applicationColor = colorIndex;
  }

  @override
  void updateApplicationTitle(String title) {
    this.title = title;
  }

  @override
  int getApplicationSelectedColor() {
    if (applicationColor == null) {
      int index = allColors.indexWhere(
        (element) {
          return colorToHex(element['real']!) == color;
        },
      );
      if (index == -1) {
        allColors.last['real'] = hexToColor(color);
        allColors.last['show'] = hexToColor(color);
        return allColors.length - 1;
      }
      return index;
    }
    return applicationColor!;
  }

  @override
  String getApplicationAbout() {
    return application.about;
  }

  @override
  void updateApplicationLanguage(String language) {
    this.language.code = language;
  }

  @override
  String getLanguage() {
    return language.code;
  }

  @override
  void pushToScreen({
    required BuildContext context,
    Application? application,
    required BoardCubit boardCubit,
    required AllBoardsCubit allBoardCubit,
    required ApplicationCubit applicationCubit,
  }) {
    print('chat navigation');
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ChatCubit(application! as ChatModel)
                ..initState(context: context, applicationId: id),
            ),
            BlocProvider(
              create: (context) => DeleteApplicationCubit(),
            ),
          ],
          child: ChatScreenTest(
            allBoardsCubit: allBoardCubit,
            boardCubit: boardCubit,
            applicationCubit: applicationCubit,
          ),
        ),
        // child: ChatApplicationScreen(
        //   boardCubit: boardCubit,
        // )),
      ),
    )
        .then(
      (value) async {
        await boardCubit.refresh();
        await allBoardCubit.refresh();
      },
    );
  }
}

class ChatMessageModel {
  int? id;
  String messageType;
  String? message;
  String? boardApplication;
  UserMessageData userMessageData;
  ReplyingModel? reply;
  String? createdAt;
  String? updatedAt;
  bool? isDirty;
  String? media;
  bool? isFormAPi;
  bool? isSent;
  bool? isMedia;
  ChatMessageModel({
    required this.id,
    required this.messageType,
    required this.message,
    required this.boardApplication,
    required this.userMessageData,
    required this.reply,
    required this.createdAt,
    required this.updatedAt,
    required this.isDirty,
    required this.media,
    this.isSent = true,
    this.isMedia = false,
    this.isFormAPi = true,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'],
      messageType: json['message_type'],
      message: json['message'],
      boardApplication: json['board_application'],
      userMessageData: UserMessageData.fromJson(json['user']),
      reply:
          json['reply'] != null ? ReplyingModel.fromJson(json['reply']) : null,
      createdAt: json['created_at'] ?? DateTime.now(),
      updatedAt: json['updated_at'] ?? DateTime.now(),
      isDirty: json['is_dirty'],
      media: json['media'],
    );
  }
}

class UserMessageData {
  final int id;
  final String name;
  final String userImage;

  UserMessageData({
    required this.id,
    required this.name,
    required this.userImage,
  });
  factory UserMessageData.fromJson(Map<String, dynamic> json) {
    return UserMessageData(
      id: json['id'],
      name: json['name'] ?? '',
      userImage: json['image'] ?? '',
    );
  }
}

class ReplyingModel {
  int id;
  String messageType;
  String? message;
  String boardApplication;
  UserMessageData userMessageData;
  ReplyingModel? reply;
  String createdAt;
  String updatedAt;
  bool? isDirty;
  String? media;
  bool isFormAPi;
  bool isSent;
  bool isMedia;
  ReplyingModel({
    required this.id,
    required this.messageType,
    required this.message,
    required this.boardApplication,
    required this.userMessageData,
    required this.reply,
    required this.createdAt,
    required this.updatedAt,
    required this.isDirty,
    required this.media,
    this.isSent = true,
    this.isMedia = false,
    this.isFormAPi = true,
  });

  factory ReplyingModel.fromJson(Map<String, dynamic> json) {
    return ReplyingModel(
      id: json['id'],
      messageType: json['message_type'],
      message: json['message'],
      boardApplication: json['board_application'],
      userMessageData: UserMessageData.fromJson(json['user']),
      reply:
          json['reply'] != null ? ReplyingModel.fromJson(json['reply']) : null,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      isDirty: json['is_dirty'] ?? false,
      media: json['media'],
    );
  }
}
