import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lista_de_tareas/data/database.dart';
import 'package:lista_de_tareas/utils/dialog_box.dart';
import 'package:lista_de_tareas/utils/todo_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _mybox = Hive.box('mybox');

  final _controller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();

    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool value, int index) {
    setState(() {
      db.toDoList[index][1] = !value;
    });
  }

  void saveNewTask() {
    setState(() {
      if (_controller.text.length > 1) {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
      }
    });
    Navigator.pop(context);
    db.updateDataBase();
  }

  void deleteFunction(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          saveNewTask: saveNewTask,
          controller: _controller,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Center(child: Text('Lista de Tareas')),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          final name = db.toDoList[index][0];
          final value = db.toDoList[index][1];
          return TodoTitle(
            taskName: name,
            taskCompleted: value,
            onChanged: (_) => checkBoxChanged(value, index),
            deleteFunction: (_) => deleteFunction(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
