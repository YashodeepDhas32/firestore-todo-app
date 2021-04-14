import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_todo_app/models/todo.dart';

class DatabaseService {
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection('todolist');

  // add the task details and complete in the firestore database

  Future updateData(String task, String detail, bool complete) async {
    return await todoCollection.doc().set({
      'task': task,
      'detail': detail,
      'complete': complete,
    });
  }

  // get the desired document id
  Future<String> getId(String task) async {
    var docId;
    await FirebaseFirestore.instance
        .collection('todolist')
        .where('task', isEqualTo: '$task')
        .get()
        .then((QuerySnapshot snapshot) => {
              snapshot.docs.forEach((document) {
                docId = document.reference.id;
              })
            });
    return docId;
  }

  // update the complete status for todo task
  void updateCompleteStatus(String docId, bool complete) {
    todoCollection.doc('$docId').update({'complete': complete}).then(
        (value) => print('Todo status updated'));
  }

  // delete the todo tile
  void deleteTodo(String docId) {
    todoCollection
        .doc('$docId')
        .delete()
        .then((value) => print('Todo Deleted'));
  }

  // list of todos from snapshot
  List<Todo> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Todo(
        task: doc.data()['task'] ?? '',
        detail: doc.data()['detail'] ?? '',
        complete: doc.data()['complete'] ?? false,
      );
    }).toList();
  }

  Stream<List<Todo>> get todos {
    return todoCollection.snapshots().map(_todoListFromSnapshot);
  }
}
