import 'package:flutter/material.dart';
import 'package:timato/constants/todo_color.dart';

class TodoColorPicker extends StatefulWidget {
  const TodoColorPicker({Key? key}) : super(key: key);

  @override
  State<TodoColorPicker> createState() => _TodoColorPickerState();
}

class _TodoColorPickerState extends State<TodoColorPicker> {
  int? _colorCode;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Choose a color: "),
      content: Row(
        children: [
          ...[0, 1, 2, 3].map((code) => InkWell(
                customBorder: CircleBorder(),
                radius: 60,
                splashColor: TodoColor.getColor(code).withAlpha(200),
                onTap: () => setState(() {
                  if (_colorCode == code) {
                    _colorCode = null;
                  } else {
                    _colorCode = code;
                  }
                }),
                child: Card(
                  elevation: 3,
                  color: TodoColor.getColor(code),
                  shape: CircleBorder(),
                  child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: _colorCode == code
                          ? Icon(
                              Icons.check,
                              size: 50,
                            )
                          : Container(
                              height: 50,
                              width: 50,
                            )),
                ),
              ))
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _colorCode),
          child: Text("Confirm"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );
  }
}
