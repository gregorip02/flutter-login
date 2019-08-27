class Todo {
  final String description;
  final bool completed;

  Todo({ this.description, this.completed });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      description: json['description'],
      completed: json['completed']
    );
  }
}