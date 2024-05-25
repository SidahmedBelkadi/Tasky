import 'package:todo_app/src/features/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    super.id,
    required super.image,
    required super.title,
    required super.description,
    required super.priority,
    super.status,
    super.user,
    super.createdAt,
    super.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      image: json['image'],
      title: json['title'],
      description: json['desc'],
      priority: json['priority'],
      status: json['status'],
      user: json['user'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "image": image,
      "title": title,
      "desc": description,
      "priority": priority,
    };

    if (id != null) data["_id"] = id;
    if (status != null) data["status"] = status;
    if (user != null) data["user"] = user;
    if (createdAt != null) data["createdAt"] = createdAt;
    if (updatedAt != null) data["updatedAt"] = updatedAt;

    return data;
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      image: entity.image,
      title: entity.title,
      description: entity.description,
      priority: entity.priority,
      status: entity.status,
      user: entity.user,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}