import 'package:lesson47/models/todo.dart';
import 'package:lesson47/services/todo_http_services.dart';

class TodoRepository {
  final todosHttpServices = TodoHttpServices();

  Future<List<ToDo>> getTodos() async {
    return todosHttpServices.getTodos();
  }

  Future<ToDo> addToDo(String title,String description,String date,bool isCompleted,) async {
    final newToDo = await todosHttpServices.addTodo(title, description, date, isCompleted);
    return newToDo;
  }

  Future<void> editToDo(
      String id, String newTitle, String newDescription, String newDate) async {
    await todosHttpServices.editToDo(id, newTitle, newDescription, newDate);
  }
  Future<void> changePositionTodo(
      String id,bool isCompleted) async {
    await todosHttpServices.changePositionTodo(id,isCompleted);
  }

  Future<void> deleteToDo(String id) async {
    await todosHttpServices.deleteTodo(id);
  }

  
}
