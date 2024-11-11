import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const TodoList());
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 40, 40, 40),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 76, 76, 76),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
