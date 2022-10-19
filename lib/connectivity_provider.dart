import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

getIsOnline(BuildContext context) {
  return Provider.of<ConnectivityProvider>(context, listen: false).isOnline;
}

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  var count = 0;
  var isOnline = true;

  void resetCounter() {
    count = 0;
  }

  Future<void> checkIsOnline() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        isOnline = true;
      } else {
        isOnline = false;
      }
    } on SocketException {
      isOnline = false;
    }
  }

  ConnectivityProvider() {
    checkIsOnline();
  }

  Future monitorConnection() async {
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.bluetooth) {
        await checkIsOnline();
      } else {
        isOnline = false;
        navigatorKey.currentState?.pushNamed(
          'connectivityScreen',
        );
        count++;
      }
      notifyListeners();
    });
  }
}
