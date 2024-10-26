import 'package:files_manager/models/user_model.dart';

class Member {
  int id;
  Country country;
  Language language;
  Gender gender;
  String firstName;
  String lastName;
  String role;
  String mainRole;
  String dateOfBirth;
  String countryCode;
  String phone;
  String email;
  String? emailVerifiedAt;
  String image;
  String status = 'false';

  Member({
    required this.id,
    required this.country,
    required this.language,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.mainRole,
    required this.role,
    required this.dateOfBirth,
    required this.countryCode,
    required this.phone,
    required this.email,
    this.emailVerifiedAt,
    required this.image,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      country: Country.fromJson(json['country']),
      language: Language.fromJson(json['language']),
      gender: Gender.fromJson(json['gender']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      role: json['role_in_board'],
      mainRole: json['role'],
      dateOfBirth: json['date_of_birth'],
      countryCode: json['country_code'],
      phone: json['phone'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      image: json['image'],
    );
  }
}
