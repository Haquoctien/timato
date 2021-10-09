import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:timato/screens/todo/todo_edit_screen.dart';

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
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _fabPadding),
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
          foregroundColor: scheme.secondary,
          heroTag: "addFab",
          elevation: 0,
          backgroundColor: _fabColor,
          child: const Icon(
            Icons.add,
          ),
          onPressed: open,
        ),
        openBuilder: (context, close) => TodoEditScreen(close: close),
      ),
    );
  }
}
