import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              onTap: () {},
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
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: const Text(
                      "Sample title",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    leading: Checkbox(
                      value: true,
                      onChanged: (value) {},
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
