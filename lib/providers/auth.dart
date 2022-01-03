import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  User? user;

  bool get isAuth {
    return user != null;
  }

  void setAuth(User? user) async {
    this.user = user;
    notifyListeners();
  }
}
