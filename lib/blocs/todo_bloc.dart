import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timato/blocs/todo_event.dart';
import 'package:timato/blocs/todo_state.dart';
import 'package:timato/constants/filter_options.dart';
import 'package:timato/constants/hive_boxes.dart';
import 'package:timato/constants/sort_options.dart';
import 'package:timato/models/todo.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> todos = HiveBox.box.values.toList();
  List<Todo> currentTodos = HiveBox.box.values.toList();
  SortOption sortOption = SortOption.ByDate;
  FilterOption filterOption = FilterOption.None;
  int get uncompletedCount => currentTodos.where((todo) => !todo.completed).length;

  TodoBloc() : super(TodosLoading()) {
    on<TodoRemoved>(
      (event, emit) {
        emit(TodosLoading());

        todos.remove(event.todo);
        currentTodos.remove(event.todo);

        HiveBox.box.delete(event.todo.id);

        add(TodoFiltered(filterOption: filterOption));
      },
      transformer: sequential(),
    );

    on<TodoAdded>(
      (event, emit) {
        emit(TodosLoading());

        todos.remove(event.todo);
        todos.add(event.todo);

        currentTodos.remove(event.todo);
        currentTodos.add(event.todo);

        HiveBox.box.put(event.todo.id, event.todo);

        add(TodoFiltered(filterOption: filterOption));
      },
      transformer: sequential(),
    );

    on<TodoFiltered>(
      (event, emit) {
        emit(TodosLoading());
        filterOption = event.filterOption;

        List<Todo> filteredTodos;

        switch (event.filterOption) {
          case FilterOption.Starred:
            filteredTodos = todos.where((todo) => todo.starred).toList();
            break;
          case FilterOption.Unstarred:
            filteredTodos = todos.where((todo) => !todo.starred).toList();
            break;
          case FilterOption.Done:
            filteredTodos = todos.where((todo) => todo.completed).toList();
            break;
          case FilterOption.Undone:
            filteredTodos = todos.where((todo) => !todo.completed).toList();
            break;
          case FilterOption.None:
            filteredTodos = todos;
            break;
        }

        currentTodos = filteredTodos;

        add(TodoSorted(
          sortOption: sortOption,
        ));
      },
      transformer: sequential(),
    );

    on<TodoSorted>(
      (event, emit) {
        emit(TodosLoading());
        sortOption = event.sortOption;

        var sortedTodos = List<Todo>.from(currentTodos, growable: false)
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
          sortOption: sortOption,
          filterOption: filterOption,
          uncompletedCount: uncompletedCount,
        ));
      },
      transformer: sequential(),
    );

    on<TodoSearched>(
      (event, emit) {
        emit(TodosLoading());

        var searchedTodos = List<Todo>.from(todos)
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

    add(TodoSorted(sortOption: sortOption));
  }
}
