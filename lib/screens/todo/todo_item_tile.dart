import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:timato/models/todo.dart';

class TodoItemTile extends StatelessWidget {
  TodoItemTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;
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
        child: ListTile(
          title: Text(
            todo.title,
          ),
          leading: Obx(
            () => Checkbox(
              onChanged: (toggled) => checked.value = toggled ?? false,
              value: checked.value,
            ),
          ),
          onTap: open,
        ),
      ),
      openBuilder: (context, close) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: close,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    "Title",
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text(
                    "Content",
                  ),
                ),
              ),
              DatePickerDialog(
                initialDate: DateTime.now(),
                firstDate: DateTime.fromMillisecondsSinceEpoch(0),
                lastDate: DateTime.parse(
                  "2100-02-27",
                ),
              ),
              TimePickerDialog(
                initialTime: TimeOfDay.now(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
