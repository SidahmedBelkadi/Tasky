import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String phoneNumber;
  final String experienceLevel;
  final int yearsOfExperience;
  final String address;

  const UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.experienceLevel,
    required this.yearsOfExperience,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, experienceLevel, yearsOfExperience, address];
}
