import 'package:firestore_todo_app/services/collection.dart';
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String addedtask;
  String addeddetails;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        title: Text('Add Your Todos'),
      ),
      body: Container(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(
                    hintText: 'Enter your task',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter task!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() => addedtask = value);
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(
                    hintText: 'Enter your task details',
                  ),
                  onChanged: (value) {
                    setState(() => addeddetails = value);
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                OutlinedButton(
                  child: Text(
                    'Add Todo',
                    style: TextStyle(color: Colors.pink[800]),
                  ),
                  onPressed: () {
                    try {
                      if (_formkey.currentState.validate()) {
                        _onFormSubmit();
                      } else {
                        print('Form is invalid!');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormSubmit() async {
    await DatabaseService().updateData(
      addedtask,
      addeddetails,
      false,
    );

    Navigator.pop(context);
  }
}
