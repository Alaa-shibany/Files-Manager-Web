import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:files_manager/cubits/application_cubit/application_cubit.dart';
import 'package:files_manager/cubits/board_cubit/board_cubit.dart';
import 'package:files_manager/cubits/locale_cubit/locale_cubit.dart';
import 'package:files_manager/interfaces/applications_abstract.dart';

import '../cubits/all_boards_cubit/all_boards_cubit.dart';

class FolderModel extends Application {
  BoardCubit? boardCubit;
  int? applicationColor;
  int id;
  int boardId;
  String title;
  String mode;
  DateTime createdAt;
  IconData icon = Icons.folder;
  DateTime updatedAt;
  List<FileMode> allFiles = [];
  FolderModel({
    required this.id,
    required this.boardId,
    required this.title,
    required this.mode,
    required this.allFiles,
    required this.createdAt,
    required this.updatedAt,
    this.boardCubit,
  });

  factory FolderModel.fromJson(Map<String, dynamic> json) {
    return FolderModel(
      id: json['id'],
      boardId: json['board_id'],
      allFiles: [],
      title: json['title'],
      mode: json['mode'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  IconData getIcon() {
    return Icons.folder;
  }

  @override
  int getApplicationFilesCount() {
    return allFiles.length;
  }

  @override
  bool isFolder() {
    return true;
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
  void updateApplicationTitle(String title) {
    this.title = title;
  }

  @override
  void pushToScreen({
    required BuildContext context,
    Application? application,
    required BoardCubit boardCubit,
    required AllBoardsCubit allBoardCubit,
    required ApplicationCubit applicationCubit,
  }) {}
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
