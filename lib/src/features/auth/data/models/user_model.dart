import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.name,
    required super.phoneNumber,
    required super.experienceLevel,
    required super.yearsOfExperience,
    required super.address,
  }) : super(
          id: null,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['displayName'],
      phoneNumber: json['phone'],
      experienceLevel: json['level'],
      yearsOfExperience: json['experienceYears'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': name,
      'phone': phoneNumber,
      'level': experienceLevel,
      'experienceYears': yearsOfExperience,
      'address': address,
    };
  }
}
