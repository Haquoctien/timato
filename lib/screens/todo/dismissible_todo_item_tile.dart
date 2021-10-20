import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/dialogs.dart';
import 'package:timato/widgets/todo_item_tile.dart';

class DismissibleTodoItemTile extends StatelessWidget {
  final Todo todo;
  const DismissibleTodoItemTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => BlocProvider.of<TodoBloc>(context).add(TodoRemoved(todo: todo)),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog<bool>(
            context: context,
            builder: (context) => const ConfirmDeleteDialog(),
          );
        } else {
          return Future.value(false);
        }
      },
      child: TodoItemTile(
        todo: todo,
      ),
    );
  }
}
