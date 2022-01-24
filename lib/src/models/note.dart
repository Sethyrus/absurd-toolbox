import 'dart:core';

import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String content;
  // final Color color;
  final List<String> tags;
  // TODO buscar utilidad o eliminar propiedad
  final bool pinned;
  final bool archived;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    // required this.color,
    required this.tags,
    required this.pinned,
    required this.archived,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  Note clone() {
    return Note(
      id: id,
      title: title,
      content: content,
      // color: color,
      tags: tags,
      pinned: pinned,
      archived: archived,
      order: order,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  bool isSameAs(Note note) {
    bool valid = true;

    if (note.id != id ||
        note.title != title ||
        note.content != content ||
        // note.color != color ||
        note.pinned != pinned ||
        note.archived != archived ||
        note.order != order ||
        note.createdAt != createdAt ||
        note.updatedAt != updatedAt) valid = false;

    if (valid) {
      note.tags.asMap().forEach((i, n) {
        if (tags[i] != n) valid = false;
      });
    }

    return valid;
  }

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        title = json['title'] ?? '',
        content = json['content'] ?? '',
        // color = json['color'] != null
        //     ? Color(int.parse(json['color']))
        //     : Colors.yellow,
        tags = json['tags'].cast<String>() ?? [],
        pinned = json['pinned'] ?? false,
        archived = json['archived'] ?? false,
        order = json['order'] ?? 0,
        createdAt = DateTime.parse(
          json['createdAt'] ?? DateTime.now().toIso8601String(),
        ),
        updatedAt = DateTime.parse(
          json['updatedAt'] ?? DateTime.now().toIso8601String(),
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        // 'color': color.value,
        'tags': tags,
        'pinned': pinned,
        'archived': archived,
        'order': order,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
