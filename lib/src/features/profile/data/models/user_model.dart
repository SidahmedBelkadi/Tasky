import 'package:tasky/src/features/profile/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.level,
    required super.experience,
    required super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['displayName'],
      phoneNumber: json['username'],
      level: json['level'],
      experience: json['experienceYears'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': name,
      'username': phoneNumber,
      'level': level,
      'experienceYears': experience,
      'address': address,
    };
  }
}
