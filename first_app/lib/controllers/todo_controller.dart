

import 'dart:async';

import '../models/todo_model.dart';
import '../services/service.dart';


class TodoController {
  final FirebaseService service = FirebaseService(); 
  List<Todo> todos = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await service.getTodos();
    onSyncController.add(false);
    return todos;
  }

  Future<String> updateTodo(String id, bool completed) async{
    return service.updateTodos(id, completed);
  }
}