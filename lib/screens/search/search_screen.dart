import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/barrel.dart';
import 'package:timato/constants/app_theme.dart';
import 'package:timato/widgets/todo_item_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            autofocus: true,
            style: TextStyle(color: AppTheme.appbar.fgColor),
            decoration: InputDecoration(hintText: "Search your todos"),
            textInputAction: TextInputAction.search,
            cursorColor: AppTheme.appbar.fgColor,
            onChanged: (text) {
              BlocProvider.of<TodoBloc>(context).add(TodoSearched(keyword: text));
            },
          ),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
            buildWhen: (_, current) => current is TodosSearchLoaded,
            builder: (context, state) {
              if (state is TodosSearchLoaded)
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  children: [
                    ...state.todos.map(
                      (e) => TodoItemTile(
                        todo: e,
                        key: Key(e.id),
                      ),
                    ),
                  ],
                );
              else
                return Container();
            }));
  }
}
