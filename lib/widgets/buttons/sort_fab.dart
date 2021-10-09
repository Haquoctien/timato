import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/constants/sort_options.dart';

class SortFab extends StatelessWidget {
  const SortFab({
    Key? key,
    required double fabPadding,
  })  : _fabPadding = fabPadding,
        super(key: key);

  final double _fabPadding;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (_, current) => current is TodosLoaded,
      builder: (context, state) {
        if (state is TodosLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: _fabPadding),
            child: PopupMenuButton<SortOption>(
              initialValue: (state as TodosLoaded).sortOption,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Icon(
                Icons.sort,
              ),
              onSelected: (result) {
                BlocProvider.of<TodoBloc>(context).add(TodoSorted(sortOption: result));
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
      },
    );
  }
}
