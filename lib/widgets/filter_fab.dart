import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timato/constants/filter_options.dart';

class FilterFab extends StatelessWidget {
  const FilterFab({
    Key? key,
    required double fabPadding,
  })  : _fabPadding = fabPadding,
        super(key: key);

  final double _fabPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _fabPadding),
      child: PopupMenuButton<FilterOption>(
        child: Icon(
          Icons.filter_alt_outlined,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        onSelected: (result) {
          var selection = result;
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterOption>>[
          const PopupMenuItem<FilterOption>(
            value: FilterOption.Starred,
            child: Text('Starred'),
          ),
          const PopupMenuItem<FilterOption>(
            value: FilterOption.Unstarred,
            child: Text('Unstarred'),
          ),
          const PopupMenuItem<FilterOption>(
            value: FilterOption.Done,
            child: Text('Done'),
          ),
          const PopupMenuItem<FilterOption>(
            value: FilterOption.Undone,
            child: Text('Not done'),
          ),
        ],
      ),
    );
  }
}
