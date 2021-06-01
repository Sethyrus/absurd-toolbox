import 'dart:core';
import 'package:flutter/material.dart';

class Note {
  final String title;
  final String content;
  final Color color;
  final List<String> tags;
  final bool pinned;
  final bool archived;
  final DateTime createdAt;
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
