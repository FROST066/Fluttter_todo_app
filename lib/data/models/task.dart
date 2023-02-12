// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  Task({
    required this.title,
    required this.description,
    required this.priority,
    required this.deadlineAt,
  });

  String title;
  String description;
  String priority;
  String deadlineAt;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json["title"],
        description: json["description"],
        priority: json["priority"],
        deadlineAt: json["deadline_at"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "priority": priority,
        "deadline_at": deadlineAt,
      };

  @override
  String toString() {
    return 'Task{title: $title, description: $description, priority: $priority, deadlineAt: $deadlineAt}';
  }

  Task copyWith({
    String? title,
    String? description,
    String? priority,
    String? deadlineAt,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      deadlineAt: deadlineAt ?? this.deadlineAt,
    );
  }
}
