import 'package:flutter/material.dart';
import 'package:timato/models/todo.dart';
import 'package:uuid/uuid.dart';

import 'todo_item_tile.dart';

class TodoSearchDelegate extends SearchDelegate {
  TodoSearchDelegate() : super();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => this.showResults(context),
      ),
      SizedBox(
        width: 10,
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
                toolbarHeight: 75,
                elevation: 0,
              ),
        );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, query),
      // color: Theme.of(context).colorScheme.secondary,
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Todo> todos = List.filled(
      12,
      Todo(
        id: Uuid().v4(),
        created: DateTime.now(),
        due: DateTime.now(),
        title: "title",
        content: "content",
        groupId: Uuid().v4(),
        colorCode: 0,
        starred: false,
        recur: false,
        recurUntil: DateTime.now(),
        recurCode: 0,
        completed: false,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          primary: true,
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverPadding(
                padding: EdgeInsets.only(
              top: 20,
            )),
            SliverAnimatedList(
              initialItemCount: todos.length,
              itemBuilder: (context, index, animation) {
                var todo = todos[index];
                return TodoItemTile(todo: todo);
              },
            ),
            SliverPadding(
                padding: EdgeInsets.only(
              top: 50,
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
        //TODO
        // backgroundColor: Theme.of(context).backgroundColor,
        );
  }
}