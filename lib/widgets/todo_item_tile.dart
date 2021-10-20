import 'package:animations/animations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/constants/app_theme.dart';
import 'package:timato/constants/todo_color.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/drawn_triangle.dart';
import 'package:timato/widgets/todo_details.dart';
import 'todo_checkbox.dart';
import '../screens/todo/todo_edit_screen.dart';

class TodoItemTile extends StatefulWidget {
  TodoItemTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  State<TodoItemTile> createState() => _TodoItemTileState();
}

class _TodoItemTileState extends State<TodoItemTile> with AutomaticKeepAliveClientMixin {
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
    super.build(context);

    return SizeChangedLayoutNotifier(
      child: AnimatedPadding(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: _margin),
        child: ExpandableNotifier(
          controller: controller,
          child: Expandable(
            collapsed: Card(
              color: AppTheme.card.bgColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: widget.todo.colorCode != -1 ? 5 : 2,
                  color: TodoColor.getColor(widget.todo.colorCode),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: InkWell(
                  onTap: controller.toggle,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TodoCheckBox(
                            todo: widget.todo,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.todo.title,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                DateFormat.jm().format(widget.todo.due) +
                                    ", " +
                                    DateFormat.yMEd().format(widget.todo.due),
                              ),
                            ],
                          ),
                          Spacer(),
                          StarButton(
                            todo: widget.todo,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            expanded: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 3,
                  color: TodoColor.getColor(widget.todo.colorCode),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              elevation: 7,
              child: CustomPaint(
                foregroundPainter: DrawnTriangle(color: TodoColor.getColor(widget.todo.colorCode)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: GestureDetector(
                    onTap: () {
                      controller.toggle();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TodoCheckBox(todo: widget.todo),
                            Spacer(),
                            TimerButton(todo: widget.todo),
                            OpenContainer(
                              transitionDuration: Duration(
                                milliseconds: 700,
                              ),
                              transitionType: ContainerTransitionType.fadeThrough,
                              closedColor: AppTheme.icon.bgColor,
                              closedElevation: 0,
                              openElevation: 0,
                              closedShape: CircleBorder(),
                              closedBuilder: (context, open) => EditButton(
                                open: open,
                              ),
                              openBuilder: (context, close) => TodoEditScreen(
                                close: close,
                                todo: widget.todo,
                              ),
                            ),
                            StarButton(
                              todo: widget.todo,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14),
                          child: TodoDetails(todo: widget.todo),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => mounted;
}

class StarButton extends StatelessWidget {
  const StarButton({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 1,
      onPressed: () {
        BlocProvider.of<TodoBloc>(context).add(
          TodoAdded(
            todo: todo.copyWith(starred: !todo.starred),
          ),
        );
      },
      icon: Star(starred: todo.starred),
    );
  }
}

class Star extends StatelessWidget {
  const Star({
    Key? key,
    required bool starred,
  })  : _starred = starred,
        super(key: key);

  final bool _starred;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _starred
          ? const Icon(
              Icons.star,
              key: Key("starred"),
            )
          : const Icon(
              Icons.star_outline,
              key: Key("unstarred"),
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
      icon: const Icon(Icons.edit),
      color: AppTheme.icon.fgColor,
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
    return IconButton(
        iconSize: 40,
        icon: Icon(
          Icons.timelapse_outlined,
          color: AppTheme.icon.fgColor,
        ),
        onPressed: () {});
  }
}
