import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:starter/models/note.dart';
import 'package:path_provider/path_provider.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];
  bool _loaded = false;
  bool _loading = false;

  List<Note> get items {
    return [..._items];
  }

  void addNote(Note note) async {
    _items.add(note);

    final storedNotes = File(
      '${(await getApplicationDocumentsDirectory()).path}/notes.json',
    );

    if (storedNotes.existsSync())
      storedNotes.writeAsString(
        json.encode(
          _items.map((e) => e.toJson()).toList(),
        ),
      );

    notifyListeners();
  }

  void updateNote(Note note) async {
    _items.asMap().forEach(
      (i, n) {
        if (note.id == n.id) {
          _items[i] = n;
        }
      },
    );

    notifyListeners();
  }

  void reloadNotesFromStorage() async {
    if (!_loaded && !_loading) {
      _loading = true;

      List<Note> notes = [];

      final storedNotes =
          File('${(await getApplicationDocumentsDirectory()).path}/notes.json');

      if (storedNotes.existsSync()) {
        json.decode(storedNotes.readAsStringSync()).forEach((storedNote) {
          notes.add(Note.fromJson(storedNote));
        });
      } else {
        storedNotes.writeAsString(json.encode([]));
      }

      _items = notes;
      _loaded = true;
      notifyListeners();
    }
  }
}
