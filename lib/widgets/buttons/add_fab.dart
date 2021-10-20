import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/constants/app_theme.dart';
import 'package:timato/screens/todo/todo_edit_screen.dart';

class AddFab extends StatelessWidget {
  const AddFab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: CircleBorder(),
      transitionDuration: Duration(
        milliseconds: 700,
      ),
      transitionType: ContainerTransitionType.fade,
      closedColor: Colors.transparent,
      openColor: AppTheme.fab.bgColor,
      closedElevation: 0,
      openElevation: 0,
      closedBuilder: (context, open) => FloatingActionButton(
        foregroundColor: AppTheme.fab.fgColor,
        heroTag: "addFab",
        elevation: 2,
        backgroundColor: AppTheme.fab.bgColor,
        child: Icon(
          Icons.add,
        ),
        onPressed: open,
      ),
      openBuilder: (context, close) => TodoEditScreen(close: close),
    );
  }
}
