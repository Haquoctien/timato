import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/models/todo.dart';
import 'package:timato/screens/todo/todo_screen.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late final TabController tabController;
  int activeTab = 0;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          activeTab = tabController.index;
        });
      })
      ..offset;
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   color: Colors.transparent,
      //   child: SafePadding(
      //       padding: EdgeInsets.all(20),
      //       child: Row(
      //         children: [
      //           Expanded(
      //             child: Container(
      //               decoration: activeTab == 0
      //                   ? BoxDecoration(
      //                       color: Colors.green.shade300,
      //                       shape: BoxShape.circle,
      //                     )
      //                   : null,
      //               child: IconButton(
      //                 icon: Icon(
      //                   Icons.timelapse,
      //                 ),
      //                 onPressed: () => tabController.animateTo(0),
      //               ),
      //             ),
      //           ),
      //           Expanded(
      //             child: AnimatedContainer(
      //               duration: Duration(milliseconds: 300),
      //               decoration: activeTab == 1
      //                   ? BoxDecoration(
      //                       color: Colors.green.shade300,
      //                       shape: BoxShape.circle,
      //                     )
      //                   : null,
      //               child: IconButton(
      //                 icon: Icon(
      //                   Icons.list,
      //                   color: Colors.amber,
      //                 ),
      //                 onPressed: () => tabController.animateTo(1),
      //               ),
      //             ),
      //           )
      //         ],
      //       )),
      // ),
      // body: TabBarView(
      //   controller: tabController,
      //   children: [
      //     TimerBody(),
      //     TodoListScreen(todos: todos),
      //   ],
      // ),
      body: TodoListScreen(
        todos: todos,
      ),
    );
  }
}
