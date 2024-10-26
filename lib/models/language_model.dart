class Language {
  int id;
  String name;
  String code;
  String direction;

  Language({
    required this.id,
    required this.name,
    required this.code,
    required this.direction,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      direction: json['direction'] ?? '',
    );
  }
}
