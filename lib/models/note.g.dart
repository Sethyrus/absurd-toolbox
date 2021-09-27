// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomColorAdapter extends TypeAdapter<CustomColor> {
  @override
  final int typeId = 0;

  @override
  CustomColor read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CustomColor.yellow;
      case 1:
        return CustomColor.red;
      default:
        return CustomColor.yellow;
    }
  }

  @override
  void write(BinaryWriter writer, CustomColor obj) {
    switch (obj) {
      case CustomColor.yellow:
        writer.writeByte(0);
        break;
      case CustomColor.red:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 1;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      title: fields[0] as String,
      content: fields[1] as String,
      color: fields[2] as CustomColor,
      tags: (fields[3] as List).cast<String>(),
      pinned: fields[4] as bool,
      archived: fields[5] as bool,
      createdAt: fields[6] as DateTime,
      updatedAt: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.pinned)
      ..writeByte(5)
      ..write(obj.archived)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
