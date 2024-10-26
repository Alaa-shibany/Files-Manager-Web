class Gender {
  final int id;
  final String type;

  Gender({
    required this.id,
    required this.type,
  });

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: json['id'],
      type: json['type'],
    );
  }
}
