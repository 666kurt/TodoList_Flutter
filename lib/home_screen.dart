import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_flutter/bloc/todo_bloc.dart';
import 'package:todo_flutter/bloc/todo_event.dart';
import 'package:todo_flutter/bloc/todo_state.dart';
import 'package:todo_flutter/todo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ToDo List")),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 16,
        ),
        child: Column(
          children: [
            // TextField
            CupertinoTextField(
              controller: _controller, // хранение текста
              padding: const EdgeInsets.all(10),
              placeholder: "Enter the todo",
              placeholderStyle: TextStyle(color: Colors.grey.shade500),
              style: const TextStyle(color: Colors.white),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 100, 100, 100),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // Button
            GestureDetector(
              onTap: () {
                final String title =
                    _controller.text; // забираем текст из контроллера
                final int id = Random().nextInt(
                    10000); // генерируем случайное целое в диапазоне от 0 до 10000 для айди
                final Todo newTodo = Todo(id: id, title: title);
                if (title.isNotEmpty) {
                  context.read<TodoBloc>().add(AddTodoEvent(todo: newTodo));
                  _controller.clear();
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.all(10),
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(206, 62, 62, 255),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "Add todo",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Divider(),
            // List
            Expanded(
              child: BlocBuilder<TodoBloc, CurrentTodoState>(
                builder: (context, state) {
                  final List<Todo> todos = state.todos;
                  if (todos.isEmpty) {
                    return const Center(
                      child: Text(
                        "Todo list is empty!",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final Todo todo = todos[index];
                        return ListTile(
                          title: Text(
                            todo.title,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (value) {
                              context
                                  .read<TodoBloc>()
                                  .add(ToggleStatusEvent(id: todo.id));
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(DeleteTodoEvent(id: todo.id));
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
