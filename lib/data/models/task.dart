// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    required this.id,
    required this.description,
    required this.title,
    this.beginedAt,
    this.finishedAt,
    required this.deadlineAt,
    required this.priority,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  String id, createdAt, updatedAt, deadlineAt;
  String description;
  String title;
  String? beginedAt;
  String? finishedAt;
  String priority;
  String userId;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        description: json["description"],
        title: json["title"],
        beginedAt: json["begined_at"],
        finishedAt: json["finished_at"],
        deadlineAt: json["deadline_at"],
        priority: json["priority"],
        userId: json["user_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "title": title,
        "begined_at": beginedAt,
        "finished_at": finishedAt,
        "deadline_at": deadlineAt,
        "priority": priority,
        "user_id": userId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  @override
  String toString() {
    return 'Task{id: $id, description: $description, title: $title, beginedAt: $beginedAt, finishedAt: $finishedAt, deadlineAt: $deadlineAt, priority: $priority, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
