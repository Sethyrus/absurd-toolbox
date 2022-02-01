import 'dart:async';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final _authFetcher = BehaviorSubject<User?>();
  StreamSubscription<User?>? _firebaseAuthSub;

  bool get isAuthSync => _authFetcher.value != null;
  String? get userIdSync => _authFetcher.value!.uid;
  User? get userDataSync => _authFetcher.value;

  Stream<bool> get isAuth => _authFetcher.stream.map((auth) => auth != null);
  Stream<String?> get userId => _authFetcher.stream.map((auth) => auth!.uid);
  Stream<User?> get userData => _authFetcher.stream;

  void initAuthSubscription() {
    log(
      "Trying to init auth subscription",
      "Already started: ${_firebaseAuthSub != null}",
    );

    _firebaseAuthSub ??= FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        log("Auth changed", user);
        _authFetcher.sink.add(user);
      },
    );
  }

  void dispose() {
    _firebaseAuthSub?.cancel();
    _firebaseAuthSub = null;
    _authFetcher.close();
  }
}

final authService = AuthService();
