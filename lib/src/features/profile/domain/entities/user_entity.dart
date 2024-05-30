import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String phoneNumber;
  final String level;
  final int experience;
  final String address;

  const UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.level,
    required this.experience,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, phoneNumber, level, experience, address];
}
