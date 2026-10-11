import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService extends ChangeNotifier {
  ConnectivityService() {
    _connectivity = Connectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      _status = _resolveStatus(results);
      notifyListeners();
    });
  }

  late final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;
  ConnectivityResult _status = ConnectivityResult.none;

  ConnectivityResult get status => _status;

  Future<void> initialize() async {
    _status = _resolveStatus(await _connectivity.checkConnectivity());
    notifyListeners();
  }

  bool get isConnected => _status != ConnectivityResult.none;

  static ConnectivityResult _resolveStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.wifi)) {
      return ConnectivityResult.wifi;
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return ConnectivityResult.mobile;
    }
    if (results.contains(ConnectivityResult.ethernet)) {
      return ConnectivityResult.ethernet;
    }
    if (results.contains(ConnectivityResult.vpn)) {
      return ConnectivityResult.vpn;
    }
    return ConnectivityResult.none;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
