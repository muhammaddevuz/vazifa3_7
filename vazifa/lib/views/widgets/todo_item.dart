import 'package:flutter/material.dart';
import 'package:lesson47/models/todo.dart';

class TodoItem extends StatelessWidget {
  final ToDo todo;
  final Function() onEdit;
  final Function() changePosition;
  final Function() onDelete;
  const TodoItem({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.changePosition,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: changePosition,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.yellow),
          child: ListTile(
            leading: todo.isCompleted
                ? const Icon(
                    Icons.circle_outlined,
                    color: Colors.blue,
                  )
                : const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
            title: Text(todo.title,
                style: todo.isCompleted
                    ? const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)
                    : const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
            subtitle: Text(todo.description,
                style: todo.isCompleted
                    ? const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)
                    : const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed:todo.isCompleted ? onEdit : () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    )),
                IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
