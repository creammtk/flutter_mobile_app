import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SixthPage extends StatefulWidget {
  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  List<Todo> todos = List.empty();
  bool isLoading = false;
  TodoController controller = TodoController();

  void initState() {
    super.initState();

    controller.onSync.listen((event) => setState(() {
      isLoading = event;
      }));

  }

  void _getTodos() async {
    var newTodos = await controller.fetchTodos();
    setState(() => todos = newTodos);
  }

  void _updateTodo(int id, bool completed) async{
    controller.updateTodo(id, completed);
  }

  Widget get body => 
    isLoading ? CircularProgressIndicator() : ListView.builder(
      itemCount: todos.isNotEmpty ? todos.length : 1,
      itemBuilder: (context, index) {
        if (todos.isNotEmpty) {
          return CheckboxListTile(
            onChanged: (value) {
              setState(() {
                _updateTodo(todos[index].id, value!);
                todos[index].completed = value;
              });
            },
            value: todos[index].completed,
            title: Text(todos[index].title),
          );
        } else{
          return Text('Tap button to fetch todos');
        }
      },
    );



  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch Todos"),
      ),
      body: Center(
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTodos,
        child: Icon(Icons.add),
      ),
    );
  }
}


class HttpService {
  Client client = Client();

  Future<String>updateTodos(int id, bool completed) async{
    final response = await client.put(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
      headers: <String, String>{
        'Content-Type' : 'application/json; charset=UTF-8',
      },
      body:jsonEncode(<String, bool> {
        "completed" : completed,
      }));
    if (response.statusCode == 200) {
      print("OKkkkkk");
      return("OK");
    } else{
      throw Exception('Failed upload todos');
    }
  }

  Future<List<Todo>> getTodos() async{
    final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      var all = AllTodos.fromJson(json.decode(response.body));
      return all.todos;
    } else{
      throw Exception('Failed to load todos');
    }
  }
}



class TodoController {
  final HttpService service = HttpService();
  List<Todo> todos = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  Future<List<Todo>> fetchTodos() async {
    onSyncController.add(true);
    todos = await service.getTodos();
    onSyncController.add(false);
    return todos;
  }

  Future<String> updateTodo(int id, bool completed) async{
    return service.updateTodos(id, completed);
  }
}

class Todo{
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  factory Todo.fromJson(
    Map<String, dynamic> json,
  ) {
      return Todo(
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
}