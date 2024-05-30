import 'package:flutter/material.dart';
import 'package:lesson47/models/todo.dart';

class ManageTodoDialog extends StatefulWidget {
  final ToDo? todo;
  const ManageTodoDialog({
    super.key,
    this.todo,
  });

  @override
  State<ManageTodoDialog> createState() => _ManageTodoDialogState();
}

class _ManageTodoDialogState extends State<ManageTodoDialog> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      title = widget.todo!.title;
      description = widget.todo!.description;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.pop(context, {
        "title": title,
        "description": description,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        widget.todo != null ? "Todo ni tahrirlash" : "Todo qo'shish",
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Todo nomi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos Todo nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                title = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: description,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Todo tavsifi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot narxini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                description = newValue!;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor qilish"),
        ),
        FilledButton(
          onPressed: submit,
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}
