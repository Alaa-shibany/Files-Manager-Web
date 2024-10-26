class Country {
  final int id;
  final String name;
  final String iso3;
  final String code;

  Country({
    required this.id,
    required this.name,
    required this.iso3,
    required this.code,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      iso3: json['iso3'],
      code: json['code'],
    );
  }
}
