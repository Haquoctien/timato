import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/todo_event.dart';
import 'package:timato/blocs/todo_state.dart';
import 'package:timato/constants/hive_boxes.dart';
import 'package:timato/constants/sort_options.dart';
import 'package:timato/models/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> cachedTodos = HiveBox.box.values.toList();
  TodoBloc() : super(TodosLoaded(todos: HiveBox.box.values.toList())) {
    on<TodoAdded>(
      (event, emit) {
        emit(TodosLoading());

        cachedTodos.remove(event.todo);
        cachedTodos.add(event.todo);

        HiveBox.box.add(event.todo);

        emit(TodosLoaded(todos: cachedTodos));
      },
      transformer: sequential(),
    );

    on<TodoSorted>(
      (event, emit) {
        emit(TodosLoading());

        var sortedTodos = List<Todo>.from(cachedTodos, growable: false)
          ..sort((one, another) {
            switch (event.sortOption) {
              case SortOption.ByDate:
                return one.due.compareTo(another.due);
              case SortOption.ByColor:
                return one.colorCode.compareTo(another.colorCode);
            }
          });

        emit(TodosLoaded(
          todos: sortedTodos,
          sortOption: event.sortOption,
        ));
      },
      transformer: sequential(),
    );

    on<TodoSearched>(
      (event, emit) {
        emit(TodosLoading());

        var searchedTodos = List<Todo>.from(cachedTodos)
          ..retainWhere(
            (todo) =>
                event.keyword.trim() != "" &&
                (todo.content.toLowerCase().contains(event.keyword.toLowerCase()) ||
                    todo.title.toLowerCase().contains(event.keyword.toLowerCase())),
          );

        emit(TodosSearchLoaded(
          todos: searchedTodos,
        ));
      },
      transformer: sequential(),
    );
  }
}
