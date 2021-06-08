import 'package:flutter/material.dart';
import 'package:starter/models/note.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [
    Note(
      title: 'Nota 1',
      content: 'Content',
      color: Colors.yellow,
      tags: [],
      pinned: false,
      archived: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      title: 'Nota 2',
      content: 'Content',
      color: Colors.yellow,
      tags: [],
      pinned: false,
      archived: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      title: 'Prueba',
      content: 'Content',
      color: Colors.yellow,
      tags: [],
      pinned: false,
      archived: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      title: 'Nota d',
      content: 'Content',
      color: Colors.yellow,
      tags: [],
      pinned: false,
      archived: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    Note(
      title: 'Otra prueba',
      content: 'Content',
      color: Colors.yellow,
      tags: [],
      pinned: false,
      archived: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  List<Note> get items {
    return [..._items];
  }

  void addNote(Note note) {
    print(_items);
    _items.add(note);
    print(_items);
    notifyListeners();
  }
}
