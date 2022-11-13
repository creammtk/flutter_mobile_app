import 'dart:async';
import 'dart:convert';

import 'package:first_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../controllers/todo_controller.dart';
import '../services/service.dart';

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

  void _updateTodo(String id, bool completed) async{
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
                _updateTodo(todos[index].firebaseID, value!);
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



