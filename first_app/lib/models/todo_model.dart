
import 'package:cloud_firestore/cloud_firestore.dart';

class Todo{
  String firebaseID;
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo(this.firebaseID, this.userId, this.id, this.title, this.completed);

  factory Todo.fromJson(
    Map<String, dynamic> json,
  ) {
      return Todo(
        'firebaseID',
        json['userId'] as int,
        json['id'] as int,
        json['title'] as String,
        json['completed'] as bool,
      );
  }
}

class AllTodos{
  List<Todo> todos;

  AllTodos(this.todos);

  factory AllTodos.fromJson(List<dynamic> json) {
    var todos = json.map((index) => Todo.fromJson(index)).toList();
    return AllTodos(todos);
  }

  factory AllTodos.fromSnapshot(QuerySnapshot s) {
    List<Todo> todos = s.docs.map((DocumentSnapshot ds) {
      var X = Todo.fromJson(ds.data() as Map<String, dynamic>);
      X.firebaseID = ds.id;
      return X;
    },).toList();
      return AllTodos(todos);
  }
}
