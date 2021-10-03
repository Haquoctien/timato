import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoCheckBox extends StatefulWidget {
  const TodoCheckBox({Key? key}) : super(key: key);

  @override
  _TodoCheckBoxState createState() => _TodoCheckBoxState();
}

class _TodoCheckBoxState extends State<TodoCheckBox> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    var scheme = Theme.of(context).colorScheme;
    return IconButton(
        iconSize: 40,
        icon: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _checked
              ? Icon(
                  Icons.check_circle_rounded,
                  key: Key("checked"),
                  color: Colors.green,
                )
              : Icon(
                  Icons.check_circle_outline,
                  key: Key("unchecked"),
                  color: scheme.onSurface,
                ),
        ),
        onPressed: () {
          setState(() {
            _checked = !_checked;
          });
        });
  }
}