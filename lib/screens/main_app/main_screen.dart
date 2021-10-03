import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/screens/todo/todo_list_screen.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<Todo> todos = List.filled(
    12,
    Todo(
      id: Uuid().v4(),
      created: DateTime.now(),
      due: DateTime.now(),
      title: "title",
      content: "content",
      groupId: Uuid().v4(),
      colorCode: 0,
      starred: false,
      recur: false,
      recurUntil: DateTime.now(),
      recurCode: 0,
      completed: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return TodoListScreen(
      todos: todos,
    );
  }
}
