import 'package:absurd_toolbox/src/helpers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GeneralState with ChangeNotifier {
  User? _user;
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;

  bool get isAuth {
    return _user != null;
  }

  String? get userID {
    return _user?.uid;
  }

  User? get userData {
    return _user;
  }

  bool get hasNetwork {
    return _connectivityStatus != ConnectivityResult.none;
  }

  ConnectivityResult get connectivityStatus {
    return _connectivityStatus;
  }

  void setAuth(User? user) async {
    log(key: "Set auth", value: user);
    this._user = user;
    notifyListeners();
  }

  void setConnectivityStatus(ConnectivityResult newConnectivityStatus) {
    log(key: "Set connectivity", value: newConnectivityStatus);
    _connectivityStatus = newConnectivityStatus;
    notifyListeners();
  }
}
