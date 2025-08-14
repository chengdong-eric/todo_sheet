import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Todo {
  final String id;
  final String description;
  final bool isCompleted;
  final DateTime creationTime;

  Todo({
    String? id,
    required this.description,
    this.isCompleted = false,
    DateTime? creationTime,
  }) : id = id ?? uuid.v4(),
       creationTime = creationTime ?? DateTime.now();

  Todo copyWith({
    String? id,
    String? description,
    bool? isCompleted,
    DateTime? creationTime,
  }) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      creationTime: creationTime ?? this.creationTime,
    );
  }

  /// Converts a Todo instance into a Map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isCompleted': isCompleted,
      'creationTime': creationTime
          .toIso8601String(), // Convert DateTime to a string
    };
  }

  /// Creates a Todo instance from a Map.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      creationTime: DateTime.parse(
        json['creationTime'],
      ), // Parse the string back to DateTime
    );
  }
}
