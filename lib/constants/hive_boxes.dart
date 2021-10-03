import 'package:hive_flutter/hive_flutter.dart';
import 'package:timato/models/todo.dart';

class HiveBox {
  static const Todos = "Todos";
  static late Box<Todo> box;
}
