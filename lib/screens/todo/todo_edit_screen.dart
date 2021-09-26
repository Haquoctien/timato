import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/safe_padding.dart';

class TodoEditScreen extends StatefulWidget {
  final Todo todo;
  final VoidCallback close;
  TodoEditScreen({
    required this.todo,
    required this.close,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends State<TodoEditScreen> {
  late final TextEditingController titleEditingController;
  late final TextEditingController descriptionEditingController;
  @override
  void initState() {
    titleEditingController = TextEditingController(text: widget.todo.title);
    descriptionEditingController = TextEditingController(text: widget.todo.content);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
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
            onPressed: () {
              widget.close();
              Fluttertoast.showToast(
                msg: "Todo saved!",
                backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                gravity: ToastGravity.CENTER,
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafePadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
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
              ),
              TextField(
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
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
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
                    Text(
                      "Due date: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(widget.todo.due),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => showTimePicker(
                  context: context,
                  initialEntryMode: TimePickerEntryMode.input,
                  initialTime: TimeOfDay.now(),
                ),
                child: Row(
                  children: [
                    Text(
                      "Due date: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      DateFormat.jm().format(widget.todo.due),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
