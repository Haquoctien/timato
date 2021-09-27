import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timato/constants/todo_color.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/color_picker_dialog.dart';
import 'package:timato/widgets/safe_padding.dart';

class TodoEditScreen extends StatefulWidget {
  final Todo? todo;
  final VoidCallback close;
  TodoEditScreen({
    this.todo,
    required this.close,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  late Todo todo;
  late final TextEditingController titleEditingController;
  late final TextEditingController descriptionEditingController;

  Color? color;
  @override
  void initState() {
    todo = widget.todo ?? Todo.empty();
    titleEditingController = TextEditingController(text: todo.title);
    descriptionEditingController = TextEditingController(text: todo.content);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: buildAppBar(scheme, context),
      body: SingleChildScrollView(
        child: SafePadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle(),
              buildContent(),
              SizedBox(
                height: 20,
              ),
              buildDate(context),
              Divider(),
              SizedBox(
                height: 20,
              ),
              buildTimeAndColor(context, scheme),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(ColorScheme scheme, BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close),
        color: scheme.secondary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Discard changes?"),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(result: true),
                        child: Text(
                          "Confirm",
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.back(result: false),
                        child: Text(
                          "Cancel",
                        ),
                      )
                    ],
                  )).then((value) {
            if (value) {
              widget.close();
            }
          });
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.check),
          color: scheme.secondary,
          onPressed: () {
            widget.close();
            Fluttertoast.showToast(
              msg: "Todo saved!",
              backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
              gravity: ToastGravity.CENTER,
            );
          },
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  TextField buildTitle() {
    return TextField(
      controller: titleEditingController,
      maxLength: 128,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        return Text("$currentLength/$maxLength");
      },
      decoration: InputDecoration(
        label: Text(
          "Title",
        ),
      ),
    );
  }

  TextField buildContent() {
    return TextField(
      controller: descriptionEditingController,
      maxLength: 512,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        return Text("$currentLength/$maxLength");
      },
      decoration: InputDecoration(
        label: Text(
          "Description",
        ),
      ),
    );
  }

  InkWell buildDate(BuildContext context) {
    return InkWell(
      onTap: () => showDatePicker(
        context: context,
        selectableDayPredicate: (date) =>
            date.isAfter(DateTime.now()) ||
            date.isAtSameMomentAs(
              DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
            ),
        initialDate: DateTime.now(),
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime.parse(
          "2100-02-27",
        ),
      ),
      child: Row(
        children: [
          Icon(FontAwesomeIcons.calendarAlt),
          SizedBox(
            width: 10,
          ),
          Text(
            DateFormat.yMMMMEEEEd().format(todo.due),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Row buildTimeAndColor(BuildContext context, ColorScheme scheme) {
    return Row(
      children: [
        Flexible(
          child: InkWell(
            onTap: () => showTimePicker(
              context: context,
              initialEntryMode: TimePickerEntryMode.input,
              initialTime: TimeOfDay.now(),
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.clock),
                SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat.jm().format(todo.due),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          color: scheme.primary,
          width: 1,
          height: 36,
        ),
        Flexible(
          child: InkWell(
            onTap: () {
              showGeneralDialog(
                  context: context,
                  pageBuilder: (context, _, __) {
                    return TodoColorPicker();
                  }).then((value) => print(value));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  elevation: 3,
                  color: color ?? TodoColor.getColor(-1),
                  shape: CircleBorder(),
                  child: Container(
                    height: 30,
                    width: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(FontAwesomeIcons.palette),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
