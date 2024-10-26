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
