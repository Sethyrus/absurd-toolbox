import 'dart:async';
import 'package:absurd_toolbox/src/blocs/auth_bloc.dart';
import 'package:absurd_toolbox/src/blocs/connectivity_bloc.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class NotesBloc {
  final _notesFetcher = BehaviorSubject<List<Note>>()..startWith([]);
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _firebaseNotesSub;
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  List<Note> get notesSync => _notesFetcher.value;
  Stream<List<Note>> get notes => _notesFetcher.stream;

  void addNote(Note note) async {
    log(key: "Add note", value: note.title);

    final String? userId = authBloc.userIdSync;

    _notesCollection
        .doc(userId)
        .collection("items")
        .add(note.toJson()..remove("id"))
        .catchError((error) {
      log(key: "Failed to add note", value: error);
    });
  }

  void updateNote(Note note) async {
    log(key: "Update note", value: note.id);

    final String? userId = authBloc.userIdSync;

    _notesCollection
        .doc(userId)
        .collection("items")
        .doc(note.id)
        .update(note.toJson()..remove("id"))
        .catchError((error) {
      log(key: "Failed to update note", value: error);
    });
  }

  void deleteNote(Note note) async {
    log(key: "Delete note", value: note.id);

    final String? userId = authBloc.userIdSync;

    _notesCollection
        .doc(userId)
        .collection("items")
        .doc(note.id)
        .delete()
        .catchError((error) {
      log(key: "Failed to delete note", value: error);
    });
  }

  void deleteNotes(List<String> noteIds) async {
    log(key: "Delete notes", value: noteIds);

    final String? userId = authBloc.userIdSync;

    noteIds.forEach((id) {
      _notesCollection
          .doc(userId)
          .collection("items")
          .doc(id)
          .delete()
          .catchError((error) {
        log(key: "Failed to delete note", value: error);
      });
    });
  }

  void reorderNote({
    required Note note,
    required int newPosition,
  }) {
    log(key: "Reorder note: ${note.id} to position: $newPosition");

    final List<Note> notes = [...notesSync];

    notes.removeAt(
      notes.indexWhere((item) => item.id == note.id),
    );

    notes.insert(
      newPosition,
      note,
    );

    resetNotesOrder(notes: notes);
  }

  void resetNotesOrder({List<Note>? notes}) {
    log(key: "Reset notes order");
    (notes ?? notesSync).asMap().forEach((index, note) {
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

  void initNotesSubscription() {
    log(
      key: "Trying to init notes subscription",
      value: "Already started: ${_firebaseNotesSub != null}",
    );

    connectivityBloc.hasNetwork.listen((hasNetwork) {
      if (hasNetwork) {
        if (_firebaseNotesSub == null) {
          _firebaseNotesSub = _notesCollection
              .doc(authBloc.userIdSync)
              .collection('items')
              .snapshots()
              .listen((valueChanges) {
            log(key: "Notes changed", value: valueChanges.docs);
            List<Note> notes = valueChanges.docs
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
            _notesFetcher.sink.add(notes);
          });
        }
      } else {
        cancelSubscriptions();
      }
    });
  }

  Note findById(String id) => notesSync.firstWhere((note) => note.id == id);

  void cancelSubscriptions() {
    _firebaseNotesSub?.cancel();
    _firebaseNotesSub = null;
  }

  void dispose() {
    _firebaseNotesSub?.cancel();
    _firebaseNotesSub = null;
    _notesFetcher.close();
  }
}

final notesBloc = NotesBloc();
