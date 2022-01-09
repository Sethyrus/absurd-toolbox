import 'dart:core';

class Note {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final bool pinned;
  final bool archived;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.pinned,
    required this.archived,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        title = json['title'] ?? '',
        content = json['content'] ?? '',
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
        'tags': tags,
        'pinned': pinned,
        'archived': archived,
        'order': order,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String()
      };
}
