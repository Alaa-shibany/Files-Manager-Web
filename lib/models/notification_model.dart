class NotificationModel {
  final String id;
  final String type;
  final String notifiableType;
  final int notifiableId;
  final TaskData task;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? readAt;

  NotificationModel({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.task,
    required this.createdAt,
    required this.updatedAt,
    this.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      notifiableType: json['notifiable_type'] ?? '',
      notifiableId: json['notifiable_id'] ?? 0,
      task: TaskData.fromJson(json['data']['task'] ?? {}),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at']) : null,
    );
  }
}

class TaskData {
  final int id;
  final String title;
  final String description;
  final String? date;
  final String time;
  final int completed;
  final int modificationsCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<User> users;

  TaskData({
    required this.id,
    required this.title,
    required this.description,
    this.date,
    required this.time,
    required this.completed,
    required this.modificationsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      date: json['date'],
      time: json['time'] ?? 'No Time',
      completed: (json['completed'] is bool)
          ? (json['completed'] ? 1 : 0)
          : (json['completed'] ?? 0),
      modificationsCount: json['modifications_count'] ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      users: (json['users'] as List<dynamic>? ?? [])
          .map((user) => User.fromJson(user))
          .toList(),
    );
  }
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String image;
  final String roleName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.image,
    required this.roleName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      roleName: json['role_name'] ?? '',
    );
  }
}
