import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_todo_app/screens/add_todo.dart';
import 'package:firestore_todo_app/screens/display_todo.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => DisplayTodo(),
        '/addtodo': (context) => AddTodo(),
      },
    );
  }
}
