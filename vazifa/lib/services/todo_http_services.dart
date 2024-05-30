import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lesson47/models/todo.dart';

class TodoHttpServices {
  Future<List<ToDo>> getTodos() async {
    Uri url =
        Uri.parse("https://oy-3-dars-6-default-rtdb.firebaseio.com/todo.json");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<ToDo> loadedTodos = [];
    if (data != null) {
      data.forEach((key, value) {
        value['id'] = key;
        loadedTodos.add(ToDo.fromJson(value));
      });
    }
    return loadedTodos;
  }

  Future<ToDo> addTodo(
      String title, String description, String date, bool isCompleted) async {
    Uri url =
        Uri.parse("https://oy-3-dars-6-default-rtdb.firebaseio.com/todo.json");

    Map<String, dynamic> todoData = {
      "title": title,
      "description": description,
      "date": date,
      "isCompleted": isCompleted,
    };
    final response = await http.post(
      url,
      body: jsonEncode(todoData),
    );

    final data = jsonDecode(response.body);
    todoData['id'] = data['name'];
    ToDo newTodo = ToDo.fromJson(todoData);
    return newTodo;
  }

  Future<void> editToDo(
    String id,
    String newTitle,
    String newDescription,
    String newDate,
  ) async {
    Uri url = Uri.parse(
        "https://oy-3-dars-6-default-rtdb.firebaseio.com/todo/$id.json");

    Map<String, dynamic> todoData = {
      "title": newTitle,
      "description": newDescription,
      "date": newDate,
    };
    await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }

  Future<void> changePositionTodo(
    String id,
    bool newIsCompleted,
  ) async {
    Uri url = Uri.parse(
        "https://oy-3-dars-6-default-rtdb.firebaseio.com/todo/$id.json");

    Map<String, dynamic> todoData = {
      "isCompleted": newIsCompleted,
    };
    await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }

  Future<void> deleteTodo(String id) async {
    Uri url = Uri.parse(
        "https://oy-3-dars-6-default-rtdb.firebaseio.com/todo/$id.json");

    await http.delete(url);
  }
}
