import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/screens/todo/todo_list.dart';
import 'package:timato/utils.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final ScrollController scrollController = ScrollController();
  bool _displayEndOfListText = false;
  List<List<double>> cordinates = [];
  final icons = [
    Icons.access_alarm,
    Icons.work,
    Icons.lock_clock,
    Icons.schedule,
    Icons.tour_outlined,
    Icons.account_circle,
    Icons.link,
    Icons.call,
    Icons.place,
    Icons.book,
    Icons.inbox,
    Icons.sports,
    Icons.ramen_dining,
    Icons.checklist,
    Icons.drafts,
    Icons.security,
    Icons.workspaces,
  ];

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        _displayEndOfListText = scrollController.position.maxScrollExtent > 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (cordinates.isEmpty) {
      cordinates = getRandomEvenCordinates(
        icons.length,
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height * 0.12,
        50,
      );
    }
    return Scrollbar(
      controller: scrollController,
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        controller: scrollController,
        slivers: [
          SliverAppBar(
            forceElevated: true,
            expandedHeight: MediaQuery.of(context).size.longestSide * 0.10,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  ...[for (var i = 0; i < min(icons.length, cordinates[0].length); i++) i].map(
                    (i) => Positioned(
                      left: cordinates[0][i],
                      top: cordinates[1][i],
                      child: Icon(
                        icons[i],
                        color: Colors.black.withOpacity(1 -
                            max(
                              cordinates[1][i] / MediaQuery.of(context).size.height / 0.12,
                              0.5,
                            )),
                      ),
                    ),
                  )
                ],
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi there!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  BlocBuilder<TodoBloc, TodoState>(
                    buildWhen: (_, current) => current is TodosLoaded,
                    builder: (context, state) {
                      if (state is TodosLoaded) {
                        return Text(
                          "You have ${state.uncompletedCount} uncompleted todos.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          ToDoList(),
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
    );
  }
}
