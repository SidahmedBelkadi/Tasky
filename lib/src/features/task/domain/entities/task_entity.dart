// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? id;
  final String image;
  final String title;
  final String description;
  final String priority;
  final String? status;
  final String? user;
  final String? createdAt;
  final String? updatedAt;

  const TaskEntity({
    this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.priority,
    this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        title,
        description,
        priority,
        status,
        user,
        createdAt,
        updatedAt,
      ];

  @override
  bool get stringify => true;
}
