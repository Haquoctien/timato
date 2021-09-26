import 'package:animations/animations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/screens/timer/timer_screen.dart';
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
    return OpenContainer(
      transitionDuration: Duration(
        milliseconds: 700,
      ),
      transitionType: ContainerTransitionType.fadeThrough,
      closedColor: Theme.of(context).backgroundColor,
      openColor: Theme.of(context).backgroundColor,
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
              collapsed: Card(
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
                      IconButton(
                        onPressed: open,
                        icon: Icon(Icons.edit),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: ExpandableButton(child: Icon(Icons.arrow_drop_down)),
                      )
                    ],
                  ),
                ),
              ),
              expanded: Card(
                borderOnForeground: true,
                shadowColor: Colors.grey,
                elevation: 7,
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
                            OpenContainer(
                              closedShape: CircleBorder(),
                              transitionDuration: Duration(
                                milliseconds: 700,
                              ),
                              transitionType: ContainerTransitionType.fadeThrough,
                              closedColor: Colors.transparent,
                              openColor: Colors.transparent,
                              closedElevation: 0,
                              closedBuilder: (context, open) => IconButton(
                                iconSize: 40,
                                icon: Icon(Icons.timelapse_outlined),
                                onPressed: open,
                              ),
                              openBuilder: (context, close) => TimerScreen(
                                close: close,
                                todo: widget.todo,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TodoDetails(todo: widget.todo),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: open,
                        icon: Icon(Icons.edit),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: ExpandableButton(
                          child: Icon(Icons.arrow_drop_up),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    controller.toggle();
                    open();
                  },
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
