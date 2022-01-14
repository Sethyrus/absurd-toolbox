import 'dart:async';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityBloc {
  final _connectivityFetcher = BehaviorSubject<ConnectivityResult>()
    ..startWith(ConnectivityResult.wifi);
  StreamSubscription<ConnectivityResult>? _firebaseConnectivitySub;

  Stream<bool> get hasNetwork => _connectivityFetcher.stream.map(
        (network) => network != ConnectivityResult.none,
      );

  void initConnectivitySubscription() {
    log(
      key: "Trying to init connectivity subscription",
      value: "Already started: ${_firebaseConnectivitySub != null}",
    );

    if (_firebaseConnectivitySub == null) {
      Connectivity().checkConnectivity().then((result) {
        log(key: "First connectivity check", value: result);

        if (result != ConnectivityResult.none) {
          _connectivityFetcher.sink.add(result);
        }
      });

      Connectivity().onConnectivityChanged.listen((result) {
        log(key: "Connectivity change", value: result);
        _connectivityFetcher.sink.add(result);
      });
    }
  }

  void dispose() {
    _firebaseConnectivitySub?.cancel();
    _firebaseConnectivitySub = null;
    _connectivityFetcher.close();
  }
}

final connectivityBloc = ConnectivityBloc();
