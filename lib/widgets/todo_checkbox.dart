import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/models/todo.dart';

class TodoCheckBox extends StatelessWidget {
  final Color checkedColor;
  final Todo todo;
  TodoCheckBox({Key? key, this.checkedColor = Colors.green, required this.todo}) : super(key: key);

  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    return IconButton(
      onPressed: () {
        BlocProvider.of<TodoBloc>(context).add(
          TodoAdded(
            todo: todo.copyWith(
              completed: !todo.completed,
            ),
          ),
        );
      },
      icon: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: todo.completed
            ? Icon(
                Icons.check_circle_rounded,
                key: Key("checked"),
                color: checkedColor,
                size: 40,
              )
            : Icon(
                Icons.check_circle_outline,
                key: Key("unchecked"),
                color: scheme.onSurface,
                size: 40,
              ),
      ),
    );
  }
}
