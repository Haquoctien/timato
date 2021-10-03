import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoCheckBox extends StatefulWidget {
  final Color checkedColor;
  final bool checked;
  TodoCheckBox({Key? key, this.checkedColor = Colors.green, this.checked = false}) : super(key: key);

  @override
  _TodoCheckBoxState createState() => _TodoCheckBoxState();
}

class _TodoCheckBoxState extends State<TodoCheckBox> {
  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: widget.checked
          ? Icon(
              Icons.check_circle_rounded,
              key: Key("checked"),
              color: widget.checkedColor,
              size: 40,
            )
          : Icon(
              Icons.check_circle_outline,
              key: Key("unchecked"),
              color: scheme.onSurface,
              size: 40,
            ),
    );
  }
}
