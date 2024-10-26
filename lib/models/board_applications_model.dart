import 'package:files_manager/models/language_model.dart';

class BoardApplicationsModel {
  final int id;
  final int boardId;
  final ApplicationBoard application;
  final String color;
  final Language language;
  final String? firstDay;
  final String title;
  final String mode;
  final bool showIcon;
  final bool showTitle;
  final bool showDescription;
  final DateTime createdAt;
  final DateTime updatedAt;

  BoardApplicationsModel({
    required this.id,
    required this.boardId,
    required this.application,
    required this.color,
    required this.language,
    this.firstDay,
    required this.title,
    required this.mode,
    required this.showIcon,
    required this.showTitle,
    required this.showDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BoardApplicationsModel.fromJson(Map<String, dynamic> json) {
    return BoardApplicationsModel(
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class ApplicationBoard {
  final int id;
  final String type;
  final String about;

  ApplicationBoard({
    required this.id,
    required this.type,
    required this.about,
  });

  factory ApplicationBoard.fromJson(Map<String, dynamic> json) {
    return ApplicationBoard(
      id: json['id'],
      type: json['type'],
      about: json['about'],
    );
  }
}
