import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/constants/app_theme.dart';
import 'package:timato/widgets/buttons.dart';
import 'package:timato/widgets/shaded_background.dart';

class FlexibleAppBar extends StatelessWidget {
  const FlexibleAppBar({
    Key? key,
    required Color appbarColor,
    required double textOpacity,
    required double? fabPadding,
    required this.maxPadding,
    required Color fabColor,
  })  : _appbarColor = appbarColor,
        _textOpacity = textOpacity,
        super(key: key);

  final Color _appbarColor;
  final double _textOpacity;
  final double maxPadding;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.275.scale(context),
      toolbarHeight: kToolbarHeight + 20,
      pinned: true,
      backgroundColor: _appbarColor,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppTheme.bg,
        ),
        centerTitle: true,
        title: Opacity(
            opacity: _textOpacity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Hi there!",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.text.fgColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: BlocBuilder<TodoBloc, TodoState>(
                    buildWhen: (_, current) => current is TodosLoaded,
                    builder: (context, state) {
                      if (state is TodosLoaded) {
                        return Text(
                          "You have ${state.uncompletedCount} uncompleted todos.",
                          style: TextStyle(fontSize: 14, color: AppTheme.text.fgColor),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
      title: Opacity(
        opacity: 1 - _textOpacity,
        child: Text(
          "Timato",
          style: TextStyle(
            color: AppTheme.text.fgColor,
          ),
        ),
      ),
      actions: [SortFab(fabPadding: 10), FilterFab(fabPadding: 10)],
    );
  }
}

extension on double {
  double scale(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor * this;
  }
}
