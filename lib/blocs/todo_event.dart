import 'package:equatable/equatable.dart';
import 'package:timato/constants/sort_options.dart';
import 'package:timato/models/todo.dart';

abstract class TodoEvent extends Equatable {}

class TodoAdded extends TodoEvent {
  TodoAdded({required this.todo});
  final Todo todo;
  @override
  List<Object?> get props => [todo];
}

class TodoRemoved extends TodoEvent {
  TodoRemoved({required this.todo});
  final Todo todo;
  @override
  List<Object?> get props => [todo];
}

// class TodoChecked extends TodoEvent {
//   TodoChecked({required this.todo});
//   final Todo todo;
//   @override
//   List<Object?> get props => [todo];
// }

// class TodosFiltered extends TodoEvent {
//   TodosFiltered({required this.filterOption});
//   final FilterOption filterOption;

//   @override
//   List<Object?> get props => [filterOption];
// }

class TodoSorted extends TodoEvent {
  TodoSorted({required this.sortOption});
  final SortOption sortOption;

  @override
  List<Object?> get props => [sortOption];
}

class TodoSearched extends TodoEvent {
  TodoSearched({required this.keyword});
  final String keyword;

  @override
  List<Object?> get props => [keyword];
}
