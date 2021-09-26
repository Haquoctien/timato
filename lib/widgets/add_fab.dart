import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/screens/todo/todo_edit_screen.dart';
import 'package:uuid/uuid.dart';

class AddFab extends StatelessWidget {
  const AddFab({
    Key? key,
    required double fabPadding,
    required Color fabColor,
  })  : _fabPadding = fabPadding,
        _fabColor = fabColor,
        super(key: key);

  final double _fabPadding;
  final Color _fabColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_fabPadding),
      child: OpenContainer(
        closedShape: CircleBorder(),
        transitionDuration: Duration(
          milliseconds: 700,
        ),
        transitionType: ContainerTransitionType.fadeThrough,
        closedColor: Colors.transparent,
        openColor: Colors.transparent,
        closedElevation: 0,
        closedBuilder: (context, open) => FloatingActionButton(
          heroTag: "addFab",
          elevation: 0,
          backgroundColor: _fabColor,
          child: Icon(
            Icons.add,
          ),
          onPressed: open,
        ),
        openBuilder: (context, close) => TodoEditScreen(
            todo: Todo(
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
            close: close),
      ),
    );
  }
}
