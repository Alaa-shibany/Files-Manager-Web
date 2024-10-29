import 'dart:io';

import 'package:files_manager/core/functions/color_to_hex.dart';
import 'package:files_manager/models/invited_user_model.dart';
import 'package:files_manager/models/member_model.dart';
import 'package:files_manager/models/user_model.dart';

import '../interfaces/applications_abstract.dart';

class Board {
  int id;
  String uuid;
  int? parentId;
  int userId;
  Language language;
  String? roleInBoard;
  String color;
  String title;
  String description;
  int tasksCommentsCount;
  String icon;
  bool hasImage;
  bool isFavorite;
  String shareLink;
  String image;
  String visibility;
  DateTime createdAt;
  List<Board> children;
  List<Member> members;
  List<InvitedUser> invitedUsers;
  List<Application> allFiles;
  int? boardColorIndex;
  File? imageFile;

  int getApplicationSelectedColor() {
    if (boardColorIndex == null) {
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
    return boardColorIndex!;
  }

  Board({
    required this.id,
    required this.uuid,
    required this.parentId,
    required this.userId,
    required this.language,
    required this.roleInBoard,
    required this.color,
    required this.allFiles,
    required this.tasksCommentsCount,
    required this.shareLink,
    required this.title,
    required this.description,
    required this.icon,
    required this.hasImage,
    required this.isFavorite,
    required this.image,
    required this.visibility,
    required this.createdAt,
    required this.children,
    required this.members,
    required this.invitedUsers,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'],
      uuid: json['uuid'],
      allFiles: [],
      parentId: json['parent_id'],
      shareLink: json['share_link'],
      userId: json['user_id'],
      tasksCommentsCount: json['tasks_comments_count'] ?? 0,
      language: Language.fromJson(json['language']),
      roleInBoard: json['role_in_board'],
      color: json['color'],
      title: json['title'],
      description: json['description'] ?? '',
      icon: json['icon'],
      hasImage: json['has_image'],
      isFavorite: json['is_favorite'] ?? false,
      image: json['image'],
      visibility: json['visibility'],
      createdAt: DateTime.parse(json['created_at']),
      children:
          List<Board>.from(json['children'].map((x) => Board.fromJson(x))),
      members:
          List<Member>.from(json['members'].map((x) => Member.fromJson(x))),
      invitedUsers: List<InvitedUser>.from(
          json['invitations'].map((x) => InvitedUser.fromJson(x))),
    );
  }
}
