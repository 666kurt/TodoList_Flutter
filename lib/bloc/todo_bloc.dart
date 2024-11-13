import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/bloc/todo_event.dart';
import 'package:todo_flutter/bloc/todo_state.dart';
import 'package:todo_flutter/todo.dart';

class TodoBloc extends Bloc<TodoEvent, CurrentTodoState> {
  TodoBloc() : super(const CurrentTodoState()) {
    // Обработка события добавления задачи
    on<AddTodoEvent>((event, emit) {
      final updatedTodo = List<Todo>.from(state.todos)..add(event.todo);
      emit(CurrentTodoState(todos: updatedTodo));
    });

    // Обработка события удаления задачи
    on<DeleteTodoEvent>((event, emit) {
      final currentTodo = state.todos;
      final List<Todo> updatedTodo =
          currentTodo.where((todo) => todo.id != event.id).toList();
      emit(CurrentTodoState(todos: updatedTodo));
    });

    // Обработка события переключения статуса задачи
    on<ToggleStatusEvent>((event, emit) {
      final currentTodo = state.todos;
      final List<Todo> updatedTodo = currentTodo.map((todo) {
        if (todo.id == event.id) {
          // Меняю isCompleted на противоположное значение
          return Todo(
            id: todo.id,
            title: todo.title,
            isCompleted: !todo.isCompleted,
          );
        }
        return todo;
      }).toList();
      emit(CurrentTodoState(todos: updatedTodo));
    });
  }
}
