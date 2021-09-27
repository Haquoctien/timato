import 'dart:math';

import 'package:animations/animations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/constants/todo_color.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/screens/timer/timer_screen.dart';
import 'package:timato/widgets/drawn_triangle.dart';
import 'package:timato/widgets/todo_details.dart';
import 'todo_checkbox.dart';
import 'todo_edit_screen.dart';

class TodoItemTile extends StatefulWidget {
  TodoItemTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  State<TodoItemTile> createState() => _TodoItemTileState();
}

class _TodoItemTileState extends State<TodoItemTile> {
  final ExpandableController controller = ExpandableController();
  double _margin = 0;
  bool _starred = false;
  Color? tileColor = Random().nextDouble() < 0.6 ? null : TodoColor.getColor(Random().nextInt(4));
  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        if (controller.expanded) {
          _margin = 20;
        } else {
          _margin = 0;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    return OpenContainer(
      transitionDuration: Duration(
        milliseconds: 700,
      ),
      transitionType: ContainerTransitionType.fadeThrough,
      // TODO
      closedColor: scheme.background,
      //openColor: Theme.of(context).backgroundColor,
      closedElevation: 0,
      openElevation: 1,
      closedShape: ContinuousRectangleBorder(),
      closedBuilder: (context, open) => AnimatedPadding(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: _margin, horizontal: 10),
        child: ExpandableNotifier(
          controller: controller,
          child: ScrollOnExpand(
            child: Expandable(
              collapsed: Stack(
                children: [
                  Card(
                    color: tileColor ?? scheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        widget.todo.title,
                      ),
                      leading: TodoCheckBox(),
                      onTap: controller.toggle,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          EditButton(
                            open: open,
                          ),
                          SizedBox(
                            width: 30,
                          )
                          // Padding(
                          //   padding: EdgeInsets.only(right: 20),
                          //   child: ExpandableButton(
                          //     child: Icon(
                          //       Icons.arrow_drop_down,
                          //       color: scheme.onSurface,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 15,
                    child: IconButton(
                      splashRadius: 1,
                      onPressed: () => setState(() {
                        _starred = !_starred;
                      }),
                      icon: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        child: _starred
                            ? Card(
                                shape: CircleBorder(),
                                elevation: tileColor == null ? 2 : 0,
                                color: tileColor ?? scheme.background,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.yellowAccent,
                                ),
                              )
                            : Icon(
                                Icons.star_outline,
                              ),
                      ),
                    ),
                  )
                ],
              ),
              expanded: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                elevation: 7,
                child: Stack(
                  children: [
                    CustomPaint(
                      foregroundPainter: DrawnTriangle(color: tileColor ?? scheme.surface),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 0, bottom: 10, top: 0, right: 8),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  TodoCheckBox(),
                                  TimerButton(todo: widget.todo),
                                ],
                              ),
                            ),
                            TodoDetails(todo: widget.todo),
                          ],
                        ),
                        onTap: () {
                          controller.toggle();
                        },
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 38,
                      child: EditButton(
                        open: open,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 0,
                      child: IconButton(
                        onPressed: controller.toggle,
                        icon: Icon(
                          Icons.arrow_drop_up,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                        splashRadius: 1,
                        onPressed: () => setState(() {
                          _starred = !_starred;
                        }),
                        icon: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: _starred
                              ? Card(
                                  shape: CircleBorder(),
                                  elevation: tileColor == null ? 2 : 0,
                                  color: tileColor ?? scheme.background,
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellowAccent,
                                  ),
                                )
                              : Icon(
                                  Icons.star_outline,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      openBuilder: (context, close) => TodoEditScreen(
        close: close,
        todo: widget.todo,
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final VoidCallback open;

  const EditButton({
    Key? key,
    required this.open,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: open,
      icon: Icon(Icons.edit),
      color: Colors.black,
    );
  }
}

class TimerButton extends StatelessWidget {
  const TimerButton({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: CircleBorder(),
      transitionDuration: Duration(
        milliseconds: 700,
      ),
      transitionType: ContainerTransitionType.fadeThrough,
      closedElevation: 0,
      closedBuilder: (context, open) => IconButton(
        iconSize: 40,
        icon: Icon(Icons.timelapse_outlined),
        onPressed: open,
      ),
      openBuilder: (context, close) => TimerScreen(
        close: close,
        todo: todo,
      ),
    );
  }
}
