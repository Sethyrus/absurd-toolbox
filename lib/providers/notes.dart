import 'package:absurd_toolbox/providers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/note.dart';

class Notes with ChangeNotifier {
  final Auth _authProvider;
  List<Note> _items = [];
  bool _loading = false;
  bool _loaded = false;
  CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Notes(this._authProvider);

  List<Note> get items {
    return [..._items];
  }

  void addNote(Note note) async {
    _items.add(note);

    if (_authProvider.userData != null) {
      _notesCollection.doc(_authProvider.userData).collection("items").add({
        'title': note.title,
        'content': note.content,
        'tags': note.tags,
        'pinned': note.pinned,
        'archived': note.archived,
        'createdAt': note.createdAt.toIso8601String(),
        'updatedAt': note.createdAt.toIso8601String(),
      }).catchError((error) {
        print("Failed to add note: $error");
      });
    }
  }

  void updateNote(Note note) async {
    _notesCollection
        .doc(_authProvider.userData)
        .collection("items")
        .doc(note.id)
        .update(note.toJson()..remove("id"))
        .catchError((error) {
      print("Failed to update note: $error");
    });
  }

  void deleteNote(Note note) async {
    _notesCollection
        .doc(_authProvider.userData)
        .collection("items")
        .doc(note.id)
        .delete()
        .catchError((error) {
      print("Failed to delete note: $error");
    });
  }

  void deleteNotes(List<String> noteIds) async {
    noteIds.forEach((id) {
      _notesCollection
          .doc(_authProvider.userData)
          .collection("items")
          .doc(id)
          .delete()
          .catchError((error) {
        print("Failed to delete note: $error");
      });
    });
  }

  void reloadNotes() {
    if (!_loaded && !_loading) {
      _loading = true;

      List<Note> notes = [];

      _notesCollection
          .doc(_authProvider.userData)
          .collection('items')
          .snapshots()
          .listen((value) {
        notes = value.docs
            .map((doc) => Note.fromJson({'id': doc.id, ...doc.data()}))
            .toList();

        _items = notes;
        _loaded = true;
        _loading = false;

        notifyListeners();
      });
    }
  }

  Note findById(String id) => _items.firstWhere((element) => element.id == id);
}
