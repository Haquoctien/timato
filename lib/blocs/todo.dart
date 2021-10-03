import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

abstract class TodoState extends Equatable {}

class TodosLoaded extends TodoState {
  TodosLoaded({required this.todos});
  final List<Todo> todos;
  @override
  List<Object?> get props => [todos];
}

class TodosLoading extends TodoState {
  TodosLoading();
  @override
  List<Object?> get props => [];
}

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  List<Todo> todos = [];
  TodoBloc() : super(TodosLoaded(todos: const [])) {
    on<TodoAdded>(
      (event, emit) {
        emit(TodosLoading());

        todos.remove(event.todo);
        todos.add(event.todo);

        emit(TodosLoaded(todos: todos));
      },
      transformer: sequential(),
    );
  }
}
