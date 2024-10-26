import 'package:files_manager/models/task_comment_model.dart';

class TaskModel {
  int id;
  String title;
  String? description;
  String? date;
  String? time;
  bool completed;
  String createdAt;
  String updatedAt;
  int commentsCount;
  int attachmentsCount;
  List<UserTaskModel> users;
  List<TaskComment> allComments = [];

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.date,
    this.time,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
    required this.commentsCount,
    required this.attachmentsCount,
    required this.users,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      completed: json['completed'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      commentsCount: json['comments_count'],
      attachmentsCount: json['attachments_count'],
      users: List<UserTaskModel>.from(
          json['users'].map((x) => UserTaskModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'completed': completed ? 1 : 0,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'comments_count': commentsCount,
      'attachments_count': attachmentsCount,
      'users': users,
    };
  }
}

class UserTaskModel {
  int id;
  String name;
  String? image;
  bool read;
  bool completed;

  UserTaskModel({
    required this.id,
    required this.completed,
    required this.name,
    required this.read,
    required this.image,
  });

  factory UserTaskModel.fromJson(Map<String, dynamic> json) {
    return UserTaskModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      completed: json['completed'] == 1,
      read: json['read'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'completed': completed ? 1 : 0,
    };
  }
}
