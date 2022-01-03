import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool _auth = false;

  bool get isAuth {
    return _auth;
  }

  void setAuth() async {
    _auth = !_auth;

    notifyListeners();
  }
}
