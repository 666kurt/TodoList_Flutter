class Todo {
  final int id;
  final String title;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  // todo -> map (для сохранения)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  // map -> todo (для чтения)
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'],
    );
  }
}
