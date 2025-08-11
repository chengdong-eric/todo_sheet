// A model for a single to-do item
class Todo {
  final String id;
  final String description;
  final bool isCompleted;

  Todo({required this.id, required this.description, this.isCompleted = false});

  // Helper method for updating, keeps the model immutable
  Todo copyWith({String? description, bool? isCompleted}) {
    return Todo(
      id: id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// A model for the entire page's data
class TodoPageData {
  final String title;
  final List<Todo> todos;

  // You could add other metadata here, like creation date, color theme, etc.
  TodoPageData({required this.title, required this.todos});
}
