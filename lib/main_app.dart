import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/screens/info/info_screen.dart';
import 'package:timato/screens/search/search_screen.dart';
import 'package:timato/screens/timer/timer_screen.dart';
import 'package:timato/screens/todo/todo_screen.dart';
import 'package:timato/widgets/buttons.dart';
import 'package:timato/widgets/main_navigation_bar.dart';

class MainApp extends StatefulWidget {
  MainApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  bool _showFab = true;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this)
      ..addListener(() {
        setState(() {
          _showFab = tabController.index == 0;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
          extendBody: true,
          backgroundColor: Color(0xFFDCDCDC),
          floatingActionButton: _showFab ? AddFab() : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: MainNavigationBar(
            activeIndex: tabController.index,
            onTabChanged: (index) {
              tabController.animateTo(index);
            },
          ),
          body: TabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              TodoScreen(),
              TimerScreen(close: () => Navigator.pop(context)),
              SearchScreen(),
              InfoScreen(),
            ],
          )),
    );
  }
}
