import 'package:animations/animations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:timato/models/todo.dart';
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
  final checked = false.obs;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: Duration(
        milliseconds: 700,
      ),
      transitionType: ContainerTransitionType.fadeThrough,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      closedElevation: 0,
      closedBuilder: (context, open) => Card(
        child: Column(
          children: [
            ExpandableNotifier(
              controller: controller,
              child: Expandable(
                collapsed: ListTile(
                  title: Text(
                    widget.todo.title,
                  ),
                  leading: Obx(
                    () => Checkbox(
                      onChanged: (toggled) => checked.value = toggled ?? false,
                      value: checked.value,
                    ),
                  ),
                  onTap: controller.toggle,
                  trailing: ExpandableButton(child: ExpandableIcon()),
                ),
                expanded: ListTile(
                  subtitle: Text(
                    DateFormat.jm().format(widget.todo.due) + ", " + DateFormat.yMEd().format(widget.todo.due),
                  ),
                  title: Text(
                    widget.todo.title,
                  ),
                  leading: Obx(
                    () => Checkbox(
                      onChanged: (toggled) => checked.value = toggled ?? false,
                      value: checked.value,
                    ),
                  ),
                  onTap: () {
                    controller.toggle();
                    open();
                  },
                  trailing: ExpandableButton(child: ExpandableIcon()),
                ),
              ),
            ),
          ],
        ),
      ),
      openBuilder: (context, close) => TodoEditScreen(
        close: close,
        todo: widget.todo,
      ),
    );
  }
}
