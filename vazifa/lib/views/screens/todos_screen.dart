import 'package:flutter/material.dart';
import 'package:lesson47/models/todo.dart';
import 'package:lesson47/viewmodels/todos_viewmodel.dart';
import 'package:lesson47/views/widgets/manage_todo_dialog.dart';
import 'package:lesson47/views/widgets/todo_item.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final toDosViewmodel = ToDosViewmodel();

  void addTodo() async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return const ManageTodoDialog();
      },
    );

    if (data != null) {
      try {
        toDosViewmodel.addToDo(data['title'], data['description'],
            DateTime.now().toString(), true);
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  void editTodo(ToDo todo) async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return ManageTodoDialog(todo: todo);
      },
    );

    if (data != null) {
      toDosViewmodel.editToDo(todo.id, data['title'], data['description'],
          DateTime.now().toString());
      setState(() {});
    }
  }

  void changePositionTodo(ToDo todo) async {
    toDosViewmodel.changePositionTodo(todo.id, !todo.isCompleted);
    setState(() {});
  }

  void deleteTodo(ToDo todo) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("ishonchingiz komilmi?"),
          content: Text("Siz ${todo.title} todo ni o'chirmoqchisiz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Bekor qilish"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ha, ishonchim komil"),
            ),
          ],
        );
      },
    );

    if (response) {
      await toDosViewmodel.deleteToDo(todo.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mahsulotlar"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: addTodo,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
          future: toDosViewmodel.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("Todo mavjud emas, iltimos qo'shing"),
              );
            }
            final todos = snapshot.data;
            return todos == null || todos.isEmpty
                ? const Center(
                    child: Text("Todo lar mavjud emas, iltimos qo'shing"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: todos.length,
                    itemBuilder: (ctx, index) {
                      final todo = todos[index];
                      return TodoItem(
                        todo: todo,
                        onEdit: () {
                          editTodo(todo);
                        },
                        changePosition: () {
                          changePositionTodo(todo);
                        },
                        onDelete: () {
                          deleteTodo(todo);
                        },
                      );
                    },
                  );
          }),
    );
  }
}
