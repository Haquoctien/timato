import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/safe_padding.dart';
import 'todo_item_tile.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class TodoListBody extends StatelessWidget {
  const TodoListBody({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello",
          style: Theme.of(context).textTheme.headline3,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
              ),
              onPressed: () {}),
          PopupMenuButton<WhyFarther>(
            icon: Icon(Icons.sort),
            onSelected: (result) {
              var selection = result;
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
              const PopupMenuItem<WhyFarther>(
                value: WhyFarther.harder,
                child: Text('By due date'),
              ),
              const PopupMenuItem<WhyFarther>(
                value: WhyFarther.smarter,
                child: Text('By color'),
              ),
            ],
          )
        ],
      ),
      body: SafePadding(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Scrollbar(
          child: AnimatedList(
            initialItemCount: todos.length,
            itemBuilder: (context, index, animation) {
              var todo = todos[index];
              if (index == 0) {
                return Column(children: [TodoItemTile(todo: todo)]);
              }
              return TodoItemTile(todo: todo);
            },
          ),
        ),
      ),
    );
  }
}
