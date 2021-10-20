import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/constants/app_theme.dart';
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
      child: BlocBuilder<TodoBloc, TodoState>(
        buildWhen: (_, current) => current is TodosLoaded,
        builder: (context, state) {
          if (state is! TodosLoaded) {
            return Container();
          } else
            return SizedBox(
              height: 36,
              child: state.filterOption == FilterOption.None
                  ? PopupMenuButton<FilterOption>(
                      initialValue: state.filterOption,
                      child: const Icon(
                        Icons.filter_alt_outlined,
                      ),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      onSelected: (result) {
                        BlocProvider.of<TodoBloc>(context).add(TodoFiltered(filterOption: result));
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
                    )
                  : Chip(
                      side: BorderSide(width: 2),
                      onDeleted: () {
                        BlocProvider.of<TodoBloc>(context).add(TodoFiltered(filterOption: FilterOption.None));
                      },
                      avatar: CircleAvatar(
                        backgroundColor: AppTheme.fab.bgColor,
                        child: Icon(
                          Icons.filter_alt_outlined,
                          size: 14,
                          color: AppTheme.fab.fgColor,
                        ),
                      ),
                      label: Row(
                        children: [
                          Text(
                            state.filterOption.toString().split(".").last,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
            );
        },
      ),
    );
  }
}
