class TaskComment {
  int? id;
  User? user;
  String? type;
  String? comment;
  ReplyingModel? reply;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? media;
  bool? isDirty;
  int fileType;
  bool isFormAPi;
  bool isSent;
  bool isMedia;
  TaskComment({
    required this.id,
    required this.user,
    required this.type,
    required this.comment,
    this.reply,
    this.fileType = 0,
    this.isSent = true,
    this.isMedia = false,
    this.isFormAPi = true,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
    required this.isDirty,
  });

  factory TaskComment.fromJson(Map<String, dynamic> json) {
    return TaskComment(
      id: json['id'],
      user: User.fromJson(json['user']),
      type: json['type'],
      comment: json['comment'],
      reply:
          json['reply'] != null ? ReplyingModel.fromJson(json['reply']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      media: json['media'],
      isDirty: json['is_dirty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user!.toJson(),
      'type': type,
      'comment': comment,
      'reply': reply?.toJson(),
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
      'media': media,
      'is_dirty': isDirty,
    };
  }
}

class User {
  final int id;
  final String name;
  final String image;

  User({
    required this.id,
    required this.name,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

class ReplyingModel {
  int? id;
  User? user;
  String? type;
  String? comment;
  ReplyingModel? reply;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? media;
  bool? isDirty;
  int fileType;
  bool isFormAPi;
  bool isSent;
  bool isMedia;
  ReplyingModel({
    required this.id,
    required this.user,
    required this.type,
    required this.comment,
    this.reply,
    this.isSent = true,
    this.fileType = 0,
    this.isMedia = false,
    this.isFormAPi = true,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
    required this.isDirty,
  });

  factory ReplyingModel.fromJson(Map<String, dynamic> json) {
    return ReplyingModel(
      id: json['id'],
      user: User.fromJson(json['user']),
      type: json['type'],
      comment: json['comment'],
      reply:
          json['reply'] != null ? ReplyingModel.fromJson(json['reply']) : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      media: json['media'],
      isDirty: json['is_dirty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user!.toJson(),
      'type': type,
      'comment': comment,
      'reply': reply?.toJson(),
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
      'media': media,
      'is_dirty': isDirty,
    };
  }
}
