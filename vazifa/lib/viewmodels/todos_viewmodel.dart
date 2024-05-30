import 'package:lesson47/models/todo.dart';
import 'package:lesson47/repositories/todo_repository.dart';

class ToDosViewmodel {
  final todosRepository = TodoRepository();

  List<ToDo> _list = [
    ToDo(
        id: "salom",
        title: "aa",
        description: "bb",
        date: DateTime.now().toString(),
        isCompleted: true)
  ];

  Future<List<ToDo>> get list async {
    _list = await todosRepository.getTodos();
    return [..._list];
  }

  void addToDo(
      String title, String description, String date, bool isCompleted) async {
    final newToDo =
        await todosRepository.addToDo(title, description, date, isCompleted);
    _list.add(newToDo);
  }

  void editToDo(
      String id, String newTitle, String newDescription, String newDate) {
    todosRepository.editToDo(id, newTitle, newDescription, newDate);
    final index = _list.indexWhere((todo) {
      return todo.id == id;
    });

    _list[index].title = newTitle;
    _list[index].description = newDescription;
    _list[index].date = newDate;
  }

  void changePositionTodo(String id, bool isCompleted) {
    todosRepository.changePositionTodo(id, isCompleted);
    final index = _list.indexWhere((todo) {
      return todo.id == id;
    });

    _list[index].isCompleted = isCompleted;
  }

  Future<void> deleteToDo(String id) async {
    await todosRepository.deleteToDo(id);
    _list.removeWhere((todo) {
      return todo.id == id;
    });
  }
}
