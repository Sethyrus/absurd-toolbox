import 'dart:async';

import 'package:absurd_toolbox/helpers.dart';
import 'package:absurd_toolbox/providers/general_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/note.dart';

class Notes with ChangeNotifier {
  final GeneralState _authProvider;
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
    log(key: "Add note", value: note.title);
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
    log(key: "Update note", value: note.id);
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
    log(key: "Delete note", value: note.id);
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
    log(key: "Delete notes", value: noteIds);
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
    log(key: "Start listening for notes changes");
    if (!_loaded && !_loading) {
      _loading = true;

      _sub = _notesCollection
          .doc(_authProvider.userID)
          .collection('items')
          .snapshots()
          .listen((valueChanges) {
        log(key: "Notes changed", value: valueChanges.docs);
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

  void reorderNote({
    required Note note,
    required int newPosition,
  }) {
    log(key: "Reorder note: ${note.id} to position: $newPosition");
    _items.removeAt(
      _items.indexWhere((item) => item.id == note.id),
    );

    _items.insert(
      newPosition,
      note,
    );

    resetNotesOrder();
  }

  void resetNotesOrder() {
    log(key: "Reset notes order");
    items.asMap().forEach((index, note) {
      if (note.order != index) {
        updateNote(
          Note(
            id: note.id,
            title: note.title,
            content: note.content,
            tags: note.tags,
            pinned: note.pinned,
            archived: note.archived,
            order: index,
            createdAt: note.createdAt,
            updatedAt: note.updatedAt,
          ),
        );
      }
    });
  }

  void cancelSubscriptions() {
    log(key: "Cancel notes subscriptions");
    _sub?.cancel();
  }

  Note findById(String id) => _items.firstWhere((element) => element.id == id);
}
