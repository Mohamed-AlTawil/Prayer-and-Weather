import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectInternet{
  String _connectionStatus = 'Unknown';
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  /*void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }*/


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<String> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    //_updateConnectionStatus(result);
    return updateConnectionStatus(result);
  }

  updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return 'Wifi Connection';

      case ConnectivityResult.mobile:
        return'Internet Connection';

      case ConnectivityResult.none:
        return'Unconnection';

      default:
        return'Failed to get Connectivity.';


    }
  }
}