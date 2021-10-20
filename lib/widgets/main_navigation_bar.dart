import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timato/constants/app_theme.dart';

class MainNavigationBar extends StatefulWidget {
  MainNavigationBar({
    Key? key,
    required this.onTabChanged,
    required this.activeIndex,
  }) : super(key: key);
  final void Function(int index) onTabChanged;
  final int activeIndex;

  @override
  _MainNavigationBarState createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> with SingleTickerProviderStateMixin {
  late int _activeIndex;
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    _activeIndex = widget.activeIndex;
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    animation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(_animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
        backgroundColor: AppTheme.appbar.bgColor,
        activeColor: AppTheme.appbar.fgColor,
        splashRadius: 0,
        icons: [
          Icons.list_alt_rounded,
          Icons.timelapse_rounded,
          Icons.search_rounded,
          Icons.info_outline,
        ],
        activeIndex: _activeIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        notchAndCornersAnimation: animation,
        onTap: (index) {
          if (index == 0) {
            _animationController.reverse();
          } else {
            _animationController.forward();
          }
          if (index != 2) {
            FocusScope.of(context).unfocus();
          }
          setState(() {
            _activeIndex = index;
          });

          widget.onTabChanged(index);
        });
  }
}
