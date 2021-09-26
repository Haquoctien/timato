import 'package:flutter/material.dart';
import 'package:timato/enums/sort_options.dart';
import 'package:timato/screens/todo/search_delegate.dart';

class SearchFab extends StatelessWidget {
  const SearchFab({
    Key? key,
    required double fabPadding,
    required Color fabColor,
  })  : _fabPadding = fabPadding,
        _fabColor = fabColor,
        super(key: key);

  final double _fabPadding;
  final Color _fabColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_fabPadding),
      child: FloatingActionButton(
        heroTag: "searchFab",
        backgroundColor: _fabColor,
        elevation: 0,
        child: Icon(
          Icons.search,
        ),
        onPressed: () {
          showSearch(
            context: context,
            delegate: TodoSearchDelegate(),
            useRootNavigator: true,
          );
        },
      ),
    );
  }
}

class SortFab extends StatelessWidget {
  const SortFab({
    Key? key,
    required double fabPadding,
    required Color fabColor,
  })  : _fabPadding = fabPadding,
        _fabColor = fabColor,
        super(key: key);

  final double _fabPadding;
  final Color _fabColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_fabPadding),
      child: PopupMenuButton<SortOption>(
        child: FloatingActionButton(
          heroTag: "sortFab",
          backgroundColor: _fabColor,
          elevation: 0,
          onPressed: null,
          child: Icon(Icons.sort),
        ),
        onSelected: (result) {
          // var selection = result;
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOption>>[
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
    );
  }
}