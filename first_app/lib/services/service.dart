
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

import '../models/todo_model.dart';

class FirebaseService {
  Future<List<Todo>> getTodos() async {
    QuerySnapshot qs =
      await FirebaseFirestore.instance.collection('todos').get();
      
    AllTodos todos = AllTodos.fromSnapshot(qs);
    return todos.todos;
  }

  Future<String> updateTodos(String id, bool completed) async {
    FirebaseFirestore.instance.collection('todos').doc(id).update({'completed':completed});
    return "Okay";
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
      print("OKkkkk");
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