import 'dart:io';

class UserProfile {
  String? firstName;
  String? lastName;
  DateTime? birthDate;
  String? gender;
  double? heightCm;
  double? weightKg;
  File? avatarFile;

  UserProfile({
    this.firstName,
    this.lastName,
    this.birthDate,
    this.gender,
    this.heightCm,
    this.weightKg,
    this.avatarFile,
  });

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    String? gender,
    double? heightCm,
    double? weightKg,
    File? avatarFile,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      avatarFile: avatarFile ?? this.avatarFile,
    );
  }
}
class UserProfileRepo {
  static final UserProfileRepo instance = UserProfileRepo._();
  UserProfileRepo._();

  UserProfile current = UserProfile();
}
