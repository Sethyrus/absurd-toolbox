import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:starter/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];
  bool _loading = false;
  bool _loaded = false;

  List<Note> get items {
    return [..._items];
  }

  void addNote(
      {
      // required String title,
      // required String content,
      required Note note}) async {
    _items.add(
        // Note(
        //   id: Uuid().v4(),
        //   title: title,
        //   content: content,
        //   tags: [],
        //   pinned: false,
        //   archived: false,
        //   createdAt: DateTime.now(),
        //   updatedAt: DateTime.now(),
        // ),
        note);

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

  void updateNote(
      {
      // required String id,
      // required String title,
      // required String content,
      required Note note}) async {
    print(2222222);
    print(note.title);
    // print(title);
    _items.asMap().forEach(
      (i, n) {
        if (note.id == n.id) {
          // if (id == n.id) {
          // _items[i] = Note(
          //   id: id,
          //   title: title,
          //   content: content,
          //   tags: n.tags,
          //   pinned: n.pinned,
          //   archived: n.archived,
          //   createdAt: n.createdAt,
          //   updatedAt: DateTime.now(),
          // );
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
}
