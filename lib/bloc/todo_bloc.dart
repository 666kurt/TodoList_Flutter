import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/bloc/todo_event.dart';
import 'package:todo_flutter/bloc/todo_state.dart';
import 'package:todo_flutter/todo.dart';

class TodoBloc extends Bloc<TodoEvent, CurrentTodoState> {
  TodoBloc() : super(const CurrentTodoState()) {
    _loadTodo();
    // Обработка события добавления задачи
    on<AddTodoEvent>((event, emit) {
      final updatedTodo = List<Todo>.from(state.todos)..add(event.todo);
      emit(CurrentTodoState(todos: updatedTodo));
      _saveTodo(updatedTodo);
    });

    // Обработка события удаления задачи
    on<DeleteTodoEvent>((event, emit) {
      final currentTodo = state.todos;
      final List<Todo> updatedTodo =
          currentTodo.where((todo) => todo.id != event.id).toList();
      emit(CurrentTodoState(todos: updatedTodo));
      _saveTodo(updatedTodo);
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
      _saveTodo(updatedTodo);
    });
  }

  // Сохранения списка задач
  Future<void> _saveTodo(List<Todo> todos) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData =
        jsonEncode(todos.map((todo) => todo.toMap()).toList());
    await prefs.setString('todo_list', encodedData);
  }

  // Загрузки списка задач
  Future<void> _loadTodo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('todo_list');
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      final List<Todo> loadedTodo =
          decodedData.map((todo) => Todo.fromMap(todo)).toList();
      emit(CurrentTodoState(todos: loadedTodo));
    }
  }
}
