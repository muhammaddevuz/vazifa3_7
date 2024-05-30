import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class ToDo {
  String id;
  String title;
  String description;
  String date;
  bool isCompleted;

  ToDo(
      {required this.id,
      required this.title,
      required this.description,
      required this.date,
      required this.isCompleted});

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return _$ToDoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ToDoToJson(this);
  }
}
