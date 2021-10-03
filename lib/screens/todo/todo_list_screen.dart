import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/todo.dart';
import 'package:timato/constants/sort_options.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/widgets/add_fab.dart';
import 'package:timato/widgets/filter_fab.dart';
import 'package:timato/widgets/shaded_background.dart';
import 'package:timato/widgets/sort_fab.dart';
import 'package:timato/widgets/timer_fab.dart';
import 'package:timato/widgets/todo_item_tile.dart';

class TodoListScreen extends StatefulWidget {
  TodoListScreen({
    Key? key,
    this.todos = const [],
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
    _fabColor = Theme.of(context).primaryColor;
    _appbarColor = Theme.of(context).colorScheme.background;
    fabColorTween = ColorTween(begin: Theme.of(context).primaryColor, end: Theme.of(context).backgroundColor);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _textOpacity = 1;
    scrollController = ScrollController()
      ..addListener(() {
        double t = min(scrollController.offset / (MediaQuery.of(context).size.height * 0.25 - kToolbarHeight - 20), 1);
        setState(() {
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
      body: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (noti) {
          if (scrollController.position.maxScrollExtent == 0) {
            WidgetsBinding.instance?.addPostFrameCallback(
              (_) => setState(() {
                _appbarColor = fabColorTween.transform(1) ?? _appbarColor;
                _fabPadding = fabPaddingTween.transform(0);
                _textOpacity = 1;
              }),
            );
          }
          return false;
        },
        child: Scrollbar(
          controller: scrollController,
          child: CustomScrollView(
            controller: scrollController,
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.25,
                toolbarHeight: kToolbarHeight + 20,
                pinned: true,
                backgroundColor: _appbarColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: ShadedBackground(),
                  centerTitle: true,
                  title: Opacity(
                      opacity: _textOpacity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Hi there!",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BlocBuilder<TodoBloc, TodoState>(
                              buildWhen: (_, current) => current is TodosLoaded,
                              builder: (context, state) {
                                if (state is TodosLoaded) {
                                  return Text(
                                    "You have ${state.todos.takeWhile((todo) => !todo.completed).length} uncompleted todos.",
                                    style: TextStyle(fontSize: 14),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 34,
                              ),
                              Spacer(),
                              // Expanded(
                              //   child: Text(
                              //     "My todos",
                              //     textAlign: TextAlign.center,
                              //   ),
                              // ),

                              SortFab(fabPadding: 10),
                              FilterFab(fabPadding: 10)
                            ],
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
              BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
                if (state is TodosLoaded) {
                  return SliverList(
                      delegate: SliverChildListDelegate([...state.todos.map((e) => TodoItemTile(todo: e))]));
                } else {
                  return SliverPadding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                  );
                }
              }),
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
      ),
    );
  }
}
