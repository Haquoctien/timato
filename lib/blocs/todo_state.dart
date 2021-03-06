import 'package:equatable/equatable.dart';
import 'package:timato/constants/filter_options.dart';
import 'package:timato/constants/sort_options.dart';
import 'package:timato/models/todo.dart';

abstract class TodoState extends Equatable {}

class TodosLoaded extends TodoState {
  TodosLoaded({
    required this.todos,
    this.sortOption,
    this.filterOption = FilterOption.None,
    required this.uncompletedCount,
  });
  final List<Todo> todos;
  final SortOption? sortOption;
  final FilterOption filterOption;
  final int uncompletedCount;

  @override
  List<Object?> get props => [todos, sortOption, filterOption, uncompletedCount];
}

class TodosSearchLoaded extends TodoState {
  TodosSearchLoaded({required this.todos});
  final List<Todo> todos;
  @override
  List<Object?> get props => [todos];
}

class TodosLoading extends TodoState {
  TodosLoading();
  @override
  List<Object?> get props => [];
}
