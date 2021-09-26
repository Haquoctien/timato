import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timato/models/todo.dart';

class TodoDetails extends StatelessWidget {
  const TodoDetails({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          Divider(),
          Text(
            todo.content,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Divider(),
          Text(
            DateFormat.jm().format(todo.due) + ", " + DateFormat.yMEd().format(todo.due),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(),
        ],
      ),
    );
  }
}