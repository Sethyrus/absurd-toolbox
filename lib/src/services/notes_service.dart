import 'dart:async';
import 'package:absurd_toolbox/src/services/auth_service.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

class NotesService {
  final _notesFetcher = BehaviorSubject<List<Note>>()..startWith([]);
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _firebaseNotesSub;
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Stream<List<Note>> get notesStream => _notesFetcher.stream;

  List<Note> get notesSync => _notesFetcher.value;

  void dispose() {
    _firebaseNotesSub?.cancel();
    _firebaseNotesSub = null;
    _notesFetcher.close();
  }

  Note? findById(String id) => notesSync.firstWhereOrNull((n) => n.id == id);

  void addNote(Note note) async {
    log("Add note", note.title);

    final String? userId = authService.userIdSync;

    _notesCollection
        .doc(userId)
        .collection("items")
        .add(note.toJson()..remove("id"))
        .catchError((error) {
      log("Failed to add note", error);
    });
  }

  void updateNote(Note note) async {
    log("Update note", note.id);

    final String? userId = authService.userIdSync;

    _notesCollection
        .doc(userId)
        .collection("items")
        .doc(note.id)
        .update(note.toJson()..remove("id"))
        .catchError((error) {
      log("Failed to update note", error);
    });
  }

  void deleteNote(Note note) async {
    log("Delete note", note.id);

    final String? userId = authService.userIdSync;

    _notesCollection
        .doc(userId)
        .collection("items")
        .doc(note.id)
        .delete()
        .catchError((error) {
      log("Failed to delete note", error);
    });
  }

  void deleteNotes(List<Note> notes) async {
    log("Delete notes", notes);

    final String? userId = authService.userIdSync;

    notes.forEach((note) {
      _notesCollection
          .doc(userId)
          .collection("items")
          .doc(note.id)
          .delete()
          .catchError((error) {
        log("Failed to delete note", error);
      });
    });
  }

  void reorderNote({
    required Note note,
    required int newPosition,
  }) {
    log("Reorder note: ${note.id} to position: $newPosition");

    /// El orden es independiente en notas archivadas las no archivadas, por lo
    /// que primero clonamos un listado con las notas del tipo que la que se va
    /// a reubicar
    final List<Note> notes = [
      ...notesSync.where((n) => n.archived == note.archived),
    ];

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
    log("Reset notes order");
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
      "Trying to init notes subscription",
      "Already started: ${_firebaseNotesSub != null}",
    );

    if (_firebaseNotesSub == null) {
      _firebaseNotesSub = _notesCollection
          .doc(authService.userIdSync)
          .collection('items')
          .snapshots()
          .listen((valueChanges) {
        log("Notes changed", valueChanges.docs);
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
  }

  void cancelSubscriptions() {
    log("Cancel notes subscriptions");
    _firebaseNotesSub?.cancel();
    _firebaseNotesSub = null;
  }
}

final notesService = NotesService();
