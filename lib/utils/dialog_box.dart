import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.controller,
    required this.saveNewTask,
  });

  final TextEditingController controller;

  final VoidCallback saveNewTask;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      title: const Text("New Task"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          helperText: "Add new Task",
        ),
      ),
      actions: [
        MaterialButton(
          color: Colors.yellow[400],
          onPressed: () => saveNewTask(),
          child: const Text("Save"),
        ),
        MaterialButton(
          color: Colors.yellow[400],
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
