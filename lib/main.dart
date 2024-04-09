import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lista_de_tareas/pages/home_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open a box
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        // colorSchemeSeed: Colors.yellow,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
