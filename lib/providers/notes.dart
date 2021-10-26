import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/note.dart';
import 'package:path_provider/path_provider.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];
  bool _loading = false;
  bool _loaded = false;

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
          _items[i] = note;
        }
      },
    );

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

  void deleteNote(Note note) async {
    _items.removeWhere((originalNote) => originalNote.id == note.id);

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

  void reloadNotesFromStorage() async {
    if (!_loaded && !_loading) {
      _loading = true;

      List<Note> notes = [];

      final storedNotes = File(
        '${(await getApplicationDocumentsDirectory()).path}/notes.json',
      );

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

  Note findById(String id) => _items.firstWhere((element) => element.id == id);
}
