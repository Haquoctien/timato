import 'package:flutter/material.dart';
import 'package:timato/constants/sort_options.dart';
import 'package:timato/widgets/search_delegate.dart';

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
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _fabPadding),
      child: FloatingActionButton(
        foregroundColor: scheme.secondary,
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
  })  : _fabPadding = fabPadding,
        super(key: key);

  final double _fabPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _fabPadding),
      child: PopupMenuButton<SortOption>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Icon(
          Icons.sort,
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
