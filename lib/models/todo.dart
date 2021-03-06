import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'todo.g.dart';

Todo todoFromMap(String str) => Todo.fromMap(json.decode(str));

String todoToMap(Todo data) => json.encode(data.toMap());

@HiveType(typeId: 0)
class Todo extends HiveObject with EquatableMixin {
  Todo({
    required this.id,
    required this.created,
    required this.due,
    required this.title,
    required this.content,
    required this.groupId,
    required this.colorCode,
    required this.starred,
    required this.recur,
    required this.recurUntil,
    required this.recurCode,
    required this.completed,
    required this.timeSpent,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime created;
  @HiveField(2)
  final DateTime due;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String content;
  @HiveField(5)
  final String groupId;
  @HiveField(6)
  final int colorCode;
  @HiveField(7)
  final bool starred;
  @HiveField(8)
  final bool recur;
  @HiveField(9)
  final DateTime recurUntil;
  @HiveField(10)
  final int recurCode;
  @HiveField(11)
  final bool completed;
  @HiveField(12)
  final int timeSpent;

  factory Todo.empty() => Todo(
        id: Uuid().v4(),
        created: DateTime.now(),
        due: DateTime.fromMillisecondsSinceEpoch(0),
        title: "",
        content: "",
        groupId: Uuid().v4(),
        colorCode: -1,
        starred: false,
        recur: false,
        recurUntil: DateTime.fromMillisecondsSinceEpoch(0),
        recurCode: 0,
        completed: false,
        timeSpent: 0,
      );

  Todo copyWith({
    String? id,
    DateTime? created,
    DateTime? due,
    String? title,
    String? content,
    String? groupId,
    int? colorCode,
    bool? starred,
    bool? recur,
    DateTime? recurUntil,
    int? recurCode,
    bool? completed,
    int? timeSpent,
  }) =>
      Todo(
        id: id ?? this.id,
        created: created ?? this.created,
        due: due ?? this.due,
        title: title ?? this.title,
        content: content ?? this.content,
        groupId: groupId ?? this.groupId,
        colorCode: colorCode ?? this.colorCode,
        starred: starred ?? this.starred,
        recur: recur ?? this.recur,
        recurUntil: recurUntil ?? this.recurUntil,
        recurCode: recurCode ?? this.recurCode,
        completed: completed ?? this.completed,
        timeSpent: timeSpent ?? this.timeSpent,
      );

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
      id: json["id"],
      created: DateTime.parse(json["created"]),
      due: DateTime.parse(json["due"]),
      title: json["title"],
      content: json["content"],
      groupId: json["groupId"],
      colorCode: json["colorCode"],
      starred: json["starred"],
      recur: json["recur"],
      recurUntil: DateTime.parse(json["recurUntil"]),
      recurCode: json["recurCode"],
      completed: json["completed"],
      timeSpent: json["timeSpent"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "created": created.toIso8601String(),
        "due": due.toIso8601String(),
        "title": title,
        "content": content,
        "groupId": groupId,
        "colorCode": colorCode,
        "starred": starred,
        "recur": recur,
        "recurUntil": recurUntil.toIso8601String(),
        "recurCode": recurCode,
        "completed": completed,
        "timeSpent": timeSpent,
      };

  @override
  List<Object?> get props => [id];
}
