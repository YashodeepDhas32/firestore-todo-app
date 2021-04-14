import 'package:firestore_todo_app/screens/todolist.dart';
import 'package:firestore_todo_app/services/collection.dart';
import 'package:flutter/material.dart';
import 'package:firestore_todo_app/models/todo.dart';
import 'package:provider/provider.dart';

class DisplayTodo extends StatefulWidget {
  @override
  _DisplayTodoState createState() => _DisplayTodoState();
}

class _DisplayTodoState extends State<DisplayTodo> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Todo>>.value(
      initialData: [],
      value: DatabaseService().todos,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          backgroundColor: Colors.pink[800],
          title: Text('Firestore Todo App'),
          actions: [
            TextButton.icon(
              style: TextButton.styleFrom(primary: Colors.grey[100]),
              icon: Icon(
                Icons.add_box_rounded,
                color: Colors.grey[100],
              ),
              label: Text('Add Todo'),
              onPressed: () {
                Navigator.pushNamed(context, '/addtodo');
              },
            )
          ],
        ),
        body: Container(
          child: TodoList(),
        ),
      ),
    );
  }
}
