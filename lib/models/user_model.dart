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
      name: json['name'] ?? '',
      iso3: json['iso3'] ?? '',
      code: json['code'] ?? '',
    );
  }
}

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
      type: json['type'] ?? '',
    );
  }
}

class User {
  final int id;
  final Country country;
  final Language language;
  final Gender gender;
  final String firstName;
  final String lastName;
  final String role;
  final String dateOfBirth;
  final String countryCode;
  final String phone;
  final String email;
  final String? emailVerifiedAt;
  final String image;

  User({
    required this.id,
    required this.country,
    required this.language,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.dateOfBirth,
    required this.countryCode,
    required this.phone,
    required this.email,
    this.emailVerifiedAt,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      country: Country.fromJson(json['country']),
      language: Language.fromJson(json['language']),
      gender: Gender.fromJson(json['gender']),
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'],
      role: json['role'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      countryCode: json['country_code'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
