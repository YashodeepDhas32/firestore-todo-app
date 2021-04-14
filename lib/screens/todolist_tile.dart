import 'package:firestore_todo_app/models/todo.dart';
import 'package:firestore_todo_app/services/collection.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatefulWidget {
  final Todo todo;
  TodoTile({this.todo});

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.pink[50],
        child: ListTile(
          leading: widget.todo.complete
              ? Icon(
                  Icons.check_box,
                  color: Colors.pink[800],
                )
              : Icon(Icons.check_box_outline_blank),
          title: Text('${widget.todo.task}'),
          subtitle: Text('${widget.todo.detail}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.pink[800],
            iconSize: 30.0,
            onPressed: () async {
              var docId = await DatabaseService().getId('${widget.todo.task}');
              setState(() => DatabaseService().deleteTodo(docId));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Deleted Todo ${widget.todo.task}'),
                backgroundColor: Colors.pink[800],
              ));
            },
          ),
          onTap: () async {
            var docId = await DatabaseService().getId('${widget.todo.task}');
            setState(() {
              widget.todo.complete = !widget.todo.complete;
              DatabaseService()
                  .updateCompleteStatus(docId, widget.todo.complete);
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Updated Todo ${widget.todo.task} Status'),
              backgroundColor: Colors.pink[800],
            ));
          },
        ),
      ),
    );
  }
}
