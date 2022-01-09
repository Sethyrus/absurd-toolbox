import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  User? _user;

  bool get isAuth {
    return _user != null;
  }

  String? get userID {
    return _user?.uid;
  }

  User? get userData {
    return _user;
  }

  void setAuth(User? user) async {
    this._user = user;
    notifyListeners();
  }
}
