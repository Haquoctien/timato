import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/screens/timer/timer_screen.dart';

class TimerFab extends StatelessWidget {
  const TimerFab({
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
          heroTag: "timerFab",
          backgroundColor: _fabColor,
          elevation: 0,
          child: Icon(Icons.timelapse_outlined),
          onPressed: open,
        ),
        openBuilder: (context, close) => TimerScreen(close: close),
      ),
    );
  }
}
