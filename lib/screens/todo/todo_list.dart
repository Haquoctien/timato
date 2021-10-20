import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/constants/app_theme.dart';
import 'package:timato/constants/sort_options.dart';
import 'package:timato/widgets/buttons/filter_fab.dart';
import 'package:timato/widgets/buttons/sort_fab.dart';

import 'dismissible_todo_item_tile.dart';

extension on DateTime {
  bool isSameDayAs(DateTime other) {
    return this.day == other.day && this.month == other.month && this.year == other.year;
  }
}

class ToDoList extends StatelessWidget {
  const ToDoList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (_, current) => current is TodosLoaded,
      builder: (context, state) {
        if (state is TodosLoaded) {
          if (state.sortOption == SortOption.ByDate) {
            var todayTodos = state.todos.where((todo) => todo.due.isSameDayAs(DateTime.now()));
            var otherTodos = state.todos.where((todo) => !todo.due.isSameDayAs(DateTime.now()));
            return SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                  ),
                  Stack(
                    children: [
                      (todayTodos.isNotEmpty)
                          ? Center(
                              child: Chip(
                                backgroundColor: AppTheme.chip.bgColor,
                                label: Text(
                                  "Today",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            )
                          : Container(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Spacer(),
                          SortFab(fabPadding: 10),
                          FilterFab(fabPadding: 20),
                        ],
                      ),
                    ],
                  ),
                  if (todayTodos.isNotEmpty) ...todayTodos.map((e) => DismissibleTodoItemTile(todo: e)),
                  if (todayTodos.isNotEmpty)
                    const SizedBox(
                      height: 20,
                    ),
                  if (otherTodos.isNotEmpty)
                    Chip(
                      backgroundColor: AppTheme.chip.bgColor,
                      label: Text(
                        "Later",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ...otherTodos.map((e) => DismissibleTodoItemTile(todo: e)),
                ],
              ),
            );
          }

          return SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Spacer(),
                    SortFab(fabPadding: 10),
                    FilterFab(fabPadding: 20),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                ),
                ...state.todos.map(
                  (e) => DismissibleTodoItemTile(todo: e),
                ),
              ],
            ),
          );
        } else {
          return const SliverPadding(
            padding: EdgeInsets.only(
              top: 20,
            ),
          );
        }
      },
    );
  }
}
