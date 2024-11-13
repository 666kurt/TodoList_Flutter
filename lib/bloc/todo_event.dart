import '../todo.dart';

abstract class TodoEvent {
  const TodoEvent();
}

// Событие добавление новой задачи
class AddTodoEvent extends TodoEvent {
  final Todo todo;

  const AddTodoEvent({required this.todo});
}

// Событие удаления задачи
class DeleteTodoEvent extends TodoEvent {
  final int id;

  const DeleteTodoEvent({required this.id});
}

// Событие изменения статуса задачи
class ToggleStatusEvent extends TodoEvent {
  final int id;

  const ToggleStatusEvent({required this.id});
}
