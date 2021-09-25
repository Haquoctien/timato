import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/screens/timer/timer_body.dart';
import 'package:timato/screens/todo/todo_body.dart';
import 'package:timato/widgets/safe_padding.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<Todo> todos = [
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
    Todo(
      id: Uuid().v4(),
      created: DateTime.now(),
      due: DateTime.now(),
      title: "title1",
      content: "content",
      groupId: Uuid().v4(),
      colorCode: 0,
      starred: false,
      recur: false,
      recurUntil: DateTime.now(),
      recurCode: 0,
      completed: false,
    ),
    Todo(
      id: Uuid().v4(),
      created: DateTime.now(),
      due: DateTime.now(),
      title: "title2",
      content: "content",
      groupId: Uuid().v4(),
      colorCode: 0,
      starred: false,
      recur: false,
      recurUntil: DateTime.now(),
      recurCode: 0,
      completed: false,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: TabBar(
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(width: 2),
              ),
            ),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.timelapse,
                  color: Colors.black54,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.list,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Timato"),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            TimerBody(),
            TodoListBody(todos: todos),
          ],
        ),
      ),
    );
  }
}
