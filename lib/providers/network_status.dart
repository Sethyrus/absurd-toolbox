import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkStatus with ChangeNotifier {
  ConnectivityResult _status = ConnectivityResult.none;

  ConnectivityResult get status {
    return _status;
  }

  setStatus(ConnectivityResult newStatus) {
    _status = newStatus;
    notifyListeners();
  }
}
