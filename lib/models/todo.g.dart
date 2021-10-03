// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      id: fields[0] as String,
      created: fields[1] as DateTime,
      due: fields[2] as DateTime,
      title: fields[3] as String,
      content: fields[4] as String,
      groupId: fields[5] as String,
      colorCode: fields[6] as int,
      starred: fields[7] as bool,
      recur: fields[8] as bool,
      recurUntil: fields[9] as DateTime,
      recurCode: fields[10] as int,
      completed: fields[11] as bool,
      timeSpent: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.due)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.content)
      ..writeByte(5)
      ..write(obj.groupId)
      ..writeByte(6)
      ..write(obj.colorCode)
      ..writeByte(7)
      ..write(obj.starred)
      ..writeByte(8)
      ..write(obj.recur)
      ..writeByte(9)
      ..write(obj.recurUntil)
      ..writeByte(10)
      ..write(obj.recurCode)
      ..writeByte(11)
      ..write(obj.completed)
      ..writeByte(12)
      ..write(obj.timeSpent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
