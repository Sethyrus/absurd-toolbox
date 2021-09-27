import 'dart:core';

class Note {
  final String title;
  final String content;
  final List<String> tags;
  final bool pinned;
  final bool archived;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.title,
    required this.content,
    required this.tags,
    required this.pinned,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });

  Note.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        tags = json['tags'].cast<String>(),
        pinned = json['pinned'],
        archived = json['archived'],
        createdAt = DateTime.parse(json['createdAt']),
        updatedAt = DateTime.parse(json['updatedAt']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'tags': tags,
        'pinned': pinned,
        'archived': archived,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String()
      };
}
