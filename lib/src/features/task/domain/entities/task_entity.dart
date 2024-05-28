import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

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

  String get formattedUpdatedAt {
    if (updatedAt == null) return 'N/A';
    final dateTime = DateTime.tryParse(updatedAt!);
    if (dateTime == null) return 'Invalid Date';
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  TaskEntity copyWith({
    String? id,
    String? image,
    String? title,
    String? description,
    String? priority,
    String? status,
    String? user,
    String? createdAt,
    String? updatedAt,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt ?? DateTime.now().toIso8601String(),
    );
  }
}
