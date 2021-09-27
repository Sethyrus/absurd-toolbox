import 'dart:core';
import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
enum CustomColor {
  @HiveField(0)
  yellow,
  @HiveField(1)
  red,
}

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String content;
  @HiveField(2)
  final CustomColor color;
  @HiveField(3)
  final List<String> tags;
  @HiveField(4)
  final bool pinned;
  @HiveField(5)
  final bool archived;
  @HiveField(6)
  final DateTime createdAt;
  @HiveField(7)
  final DateTime updatedAt;

  Note({
    required this.title,
    required this.content,
    required this.color,
    required this.tags,
    required this.pinned,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });
}
