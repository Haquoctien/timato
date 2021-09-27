// ignore_for_file: invalid_use_of_protected_member
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/constants/sort_options.dart';
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
  late Tween<double> fabPaddingTween;
  double? maxPadding;
  late Color _fabColor;
  late Color _appbarColor;
  double? _fabPadding;
  late double _textOpacity;
  bool _displayEndOfListText = false;

  @override
  void didChangeDependencies() {
    maxPadding = (MediaQuery.of(context).size.width - 60 * 3) / 6;
    fabPaddingTween = Tween(begin: maxPadding, end: 0);
    _fabColor = Theme.of(context).primaryColor; //.withAlpha(230);
    _appbarColor = Theme.of(context).colorScheme.background;
    fabColorTween = ColorTween(begin: Theme.of(context).primaryColor, end: Theme.of(context).backgroundColor);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _textOpacity = 1;
    scrollController = ScrollController()
      ..addListener(() {
        double t = min(scrollController.offset / 80, 1);
        setState(() {
          //_fabColor = fabColorTween.transform(t) ?? _fabColor;
          _appbarColor = fabColorTween.transform(1 - t) ?? _appbarColor;
          _fabPadding = fabPaddingTween.transform(t);
          _textOpacity = 1 - t;
        });
      });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        _displayEndOfListText = scrollController.position.maxScrollExtent > 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var maxPadding = (MediaQuery.of(context).size.width - 60 * 3) / 6;
    var scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Scrollbar(
        controller: scrollController,
        child: CustomScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              toolbarHeight: kToolbarHeight + 20,
              pinned: true,
              backgroundColor: _appbarColor,
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              flexibleSpace: FlexibleSpaceBar(
                background: ShadedBackground(),
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Opacity(
                    opacity: _textOpacity,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 34,
                        ),
                        Expanded(
                          child: Text(
                            "My todos",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: PopupMenuButton<SortOption>(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            child: Icon(
                              Icons.sort,
                            ),
                            onSelected: (result) {
                              // var selection = result;
                            },
                            itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<SortOption>(
                                value: SortOption.ByDate,
                                child: Text('By due date'),
                              ),
                              const PopupMenuItem<SortOption>(
                                value: SortOption.ByColor,
                                child: Text('By color'),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              title: Opacity(
                  opacity: 1 - _textOpacity,
                  child: Text(
                    "Timato",
                  )),
              actions: [
                TimerFab(fabPadding: _fabPadding ?? maxPadding, fabColor: _fabColor),
                AddFab(fabPadding: _fabPadding ?? maxPadding, fabColor: _fabColor),
                SearchFab(fabPadding: _fabPadding ?? maxPadding, fabColor: _fabColor),
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
            SliverPadding(
                padding: EdgeInsets.only(
              top: 20,
            )),
            if (_displayEndOfListText)
              SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "End of list",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            SliverPadding(
                padding: EdgeInsets.only(
              top: 20,
            )),
          ],
        ),
      ),
    );
  }
}
