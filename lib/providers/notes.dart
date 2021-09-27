import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starter/models/note.dart';

class Notes with ChangeNotifier {
  List<Note> _items = [];
  bool _loaded = false;

  List<Note> get items {
    return [..._items];
  }

  void addNote(Note note) async {
    _items.add(note);
    final box = await Hive.openBox<List<dynamic>>('mainBox');
    box.put('notes', _items);
    notifyListeners();
  }

  // En la línea List<Note>? storedNotes = box.get('notes'); hay que buscar una
  // forma de que devuelva tipo List<Note> y no List<dynamic> cuando hay almace-
  // nado [].
  void reloadNotesFromStorage() async {
    // print('_loaded: $_loaded');

    if (!_loaded) {
      List<Note> notes = [];
      final box = await Hive.openBox<List<dynamic>>('mainBox');
      List<dynamic>? storedNotes = box.get('notes');

      print('Notes 1');
      print(storedNotes);

      if (storedNotes == null) {
        box.put('notes', notes);
      } else {
        notes = storedNotes.map((e) => e as Note).toList();
      }

      print('Notes 2');
      print(notes);

      _items = notes;
      _loaded = true;
      notifyListeners();
    }
  }
}
