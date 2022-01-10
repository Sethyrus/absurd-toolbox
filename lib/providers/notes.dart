import 'dart:async';

import 'package:absurd_toolbox/helpers.dart';
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
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _sub;

  Notes(this._authProvider);

  List<Note> get items {
    return [..._items];
  }

  void addNote(Note note) async {
    _items.add(note);

    if (_authProvider.userID != null) {
      _notesCollection
          .doc(_authProvider.userID)
          .collection("items")
          .add(note.toJson()..remove("id"))
          .catchError((error) {
        log(key: "Failed to add note", value: error);
      });
    }
  }

  void updateNote(Note note) async {
    _notesCollection
        .doc(_authProvider.userID)
        .collection("items")
        .doc(note.id)
        .update(note.toJson()..remove("id"))
        .catchError((error) {
      log(key: "Failed to update note", value: error);
    });
  }

  void deleteNote(Note note) async {
    _notesCollection
        .doc(_authProvider.userID)
        .collection("items")
        .doc(note.id)
        .delete()
        .catchError((error) {
      log(key: "Failed to delete note", value: error);
    });
  }

  void deleteNotes(List<String> noteIds) async {
    noteIds.forEach((id) {
      _notesCollection
          .doc(_authProvider.userID)
          .collection("items")
          .doc(id)
          .delete()
          .catchError((error) {
        log(key: "Failed to delete note", value: error);
      });
    });
  }

  void reloadNotes() {
    if (!_loaded && !_loading) {
      _loading = true;

      _sub = _notesCollection
          .doc(_authProvider.userID)
          .collection('items')
          .snapshots()
          .listen((valueChanges) {
        _items = valueChanges.docs
            .map((doc) => Note.fromJson({'id': doc.id, ...doc.data()}))
            .toList()
          ..sort((Note a, Note b) {
            if (a.order == b.order) return 0;

            if (a.order > b.order) {
              return 1;
            } else {
              return -1;
            }
          });

        _loaded = true;
        _loading = false;

        notifyListeners();
      });
    }
  }

  void cancelSubscriptions() {
    _sub?.cancel();
  }

  Note findById(String id) => _items.firstWhere((element) => element.id == id);
}
