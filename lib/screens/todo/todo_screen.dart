// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/screens/timer/timer_screen.dart';
import 'package:timato/screens/todo/todo_edit_screen.dart';
import 'package:timato/widgets/safe_padding.dart';
import 'package:uuid/uuid.dart';
import 'todo_item_tile.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

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
  late final ColorTween fabColorTween;
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
      body: Scrollbar(
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
              title: Icon(FontAwesomeIcons.accusoft),
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: FlexibleSpaceBar(
                      background: ShaderMask(
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Theme.of(context).backgroundColor.withAlpha(120),
                              Theme.of(context).backgroundColor,
                              Theme.of(context).backgroundColor,
                            ],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.xor,
                        child: Image.asset(
                          "assets/images/working_male.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      collapseMode: CollapseMode.pin,
                      //centerTitle: true,
                      title: Opacity(
                          opacity: _textOpacity,
                          child: Text(
                            "Good morning :)",
                            style: Theme.of(context).textTheme.headline6,
                          )),
                    ),
                  ),
                ],
              ),
              onStretchTrigger: () async {
                print("Hey");
              },
              actions: [
                Padding(
                  padding: EdgeInsets.all(_fabPadding),
                  child: OpenContainer(
                    closedShape: CircleBorder(),
                    transitionDuration: Duration(
                      milliseconds: 700,
                    ),
                    transitionType: ContainerTransitionType.fadeThrough,
                    closedColor: Colors.transparent,
                    openColor: Colors.transparent,
                    closedElevation: 0,
                    closedBuilder: (context, open) => FloatingActionButton(
                      heroTag: "timerFab",
                      backgroundColor: _fabColor,
                      elevation: 0,
                      child: Icon(Icons.timelapse_outlined),
                      onPressed: open,
                    ),
                    openBuilder: (context, close) => TimerScreen(close: close),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_fabPadding),
                  child: OpenContainer(
                    closedShape: CircleBorder(),
                    transitionDuration: Duration(
                      milliseconds: 700,
                    ),
                    transitionType: ContainerTransitionType.fadeThrough,
                    closedColor: Colors.transparent,
                    openColor: Colors.transparent,
                    closedElevation: 0,
                    closedBuilder: (context, open) => FloatingActionButton(
                      heroTag: "addFab",
                      elevation: 0,
                      backgroundColor: _fabColor,
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: open,
                    ),
                    openBuilder: (context, close) => TodoEditScreen(
                        todo: Todo(
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
                        close: close),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_fabPadding),
                  child: PopupMenuButton<WhyFarther>(
                    child: FloatingActionButton(
                      heroTag: "sortFab",
                      backgroundColor: _fabColor,
                      elevation: 0,
                      onPressed: null,
                      child: Icon(Icons.sort),
                    ),
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
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: TodoSearchDelegate(), useRootNavigator: true);
                  },
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

class TodoSearchDelegate extends SearchDelegate {
  TodoSearchDelegate() : super();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => this.showResults(context),
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super.appBarTheme(context).appBarTheme.copyWith(
                elevation: 0,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
        );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, query), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Text("Hihihaha");
  }
}
