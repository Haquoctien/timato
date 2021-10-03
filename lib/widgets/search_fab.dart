import 'package:flutter/material.dart';
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
