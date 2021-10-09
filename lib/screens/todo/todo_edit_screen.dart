import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/blocs/todo.dart';
import 'package:timato/constants/todo_color.dart';
import 'package:timato/extentions/date_time_ex.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey();

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
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    backgroundColor: scheme.surface,
                    title: Text("Discard changes?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back(result: true);
                        },
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
            if (valid) {
              BlocProvider.of<TodoBloc>(context).add(TodoAdded(todo: todo));
              widget.close();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Todo saved")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Fill the required fields first")));
            }
          },
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget buildTitle() {
    return TextFormField(
        onChanged: (text) => todo = todo.copyWith(title: text),
        controller: titleEditingController,
        maxLength: 128,
        validator: (String? value) {
          if (value?.isEmpty ?? true) {
            return "cannot be empty";
          }
        },
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
        ));
  }

  TextField buildContent() {
    return TextField(
      onChanged: (text) => todo = todo.copyWith(content: text),
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
      onTap: () {
        showDatePicker(
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
        ).then((date) {
          if (date != null) {
            setState(() {
              todo = todo.copyWith(
                  due: todo.due.copyWith(
                year: date.year,
                month: date.month,
                day: date.day,
              ));
            });
          }
        });
      },
      child: Row(
        children: [
          Icon(FontAwesomeIcons.calendarAlt),
          SizedBox(
            width: 10,
          ),
          Text(
            todo.due != DateTime.fromMillisecondsSinceEpoch(0)
                ? DateFormat.yMMMMEEEEd().format(todo.due)
                : "Pick a due date",
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
            onTap: () {
              showTimePicker(
                context: context,
                initialEntryMode: TimePickerEntryMode.input,
                initialTime: TimeOfDay.now(),
              ).then((time) {
                if (time != null) {
                  setState(() {
                    todo = todo.copyWith(
                      due: todo.due.copyWith(hour: time.hour, minute: time.minute),
                    );
                  });
                }
              });
            },
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
              showDialog<int>(
                  context: context,
                  builder: (context) {
                    return TodoColorPicker(pickedColor: todo.colorCode);
                  }).then((value) => setState(() {
                    todo = todo.copyWith(colorCode: value);
                  }));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  elevation: 3,
                  color: TodoColor.getColor(todo.colorCode),
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

  bool get valid => (formKey.currentState?.validate() ?? false) && todo.due != DateTime.fromMillisecondsSinceEpoch(0);
}
