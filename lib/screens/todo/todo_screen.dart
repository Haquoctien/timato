// ignore_for_file: invalid_use_of_protected_member
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/add_fab.dart';
import 'package:timato/widgets/shaded_background.dart';
import 'package:timato/widgets/sort_fab.dart';
import 'package:timato/widgets/timer_fab.dart';
import 'todo_item_tile.dart';

class TodoListScreen extends StatefulWidget {
  TodoListScreen({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late final ScrollController scrollController;
  late ColorTween fabColorTween;
  final Tween<double> fabPaddingTween = Tween(begin: 3, end: 0);
  late Color _fabColor;
  late double _fabPadding;
  late double _textOpacity;

  @override
  void didChangeDependencies() {
    _fabColor = Theme.of(context).primaryColor.withAlpha(230);
    fabColorTween =
        ColorTween(begin: Theme.of(context).primaryColor.withAlpha(230), end: Theme.of(context).backgroundColor);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _textOpacity = 1;
    _fabPadding = 3;
    scrollController = ScrollController()
      ..addListener(() {
        double t = min(scrollController.offset / 80, 1);
        setState(() {
          _fabColor = fabColorTween.transform(t) ?? Theme.of(context).primaryColor.withAlpha(230);
          _fabPadding = fabPaddingTween.transform(t);
          _textOpacity = 1 - t;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Scrollbar(
        controller: scrollController,
        child: CustomScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              toolbarHeight: kToolbarHeight + 20,
              pinned: false,
              snap: false,
              floating: true,
              backgroundColor: Theme.of(context).backgroundColor,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              flexibleSpace: FlexibleSpaceBar(
                background: ShadedBackground(),
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Opacity(
                    opacity: _textOpacity,
                    child: Text(
                      "Your todos",
                    )),
              ),
              title: Opacity(
                  opacity: 1 - _textOpacity,
                  child: Text(
                    "Timato",
                  )),
              actions: [
                TimerFab(fabPadding: _fabPadding, fabColor: _fabColor),
                AddFab(fabPadding: _fabPadding, fabColor: _fabColor),
                SortFab(fabPadding: _fabPadding, fabColor: _fabColor),
                SearchFab(fabPadding: _fabPadding, fabColor: _fabColor),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SliverAnimatedList(
              initialItemCount: widget.todos.length,
              itemBuilder: (context, index, animation) {
                var todo = widget.todos[index];
                return TodoItemTile(todo: todo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
