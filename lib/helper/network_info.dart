import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/localization/language_constrants.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    ConnectivityResult _result = await connectivity.checkConnectivity();
    return _result != ConnectivityResult.none;
  }

  static void checkConnectivity(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      bool isNotConnected = result == ConnectivityResult.none;
      isNotConnected ? SizedBox() : Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        backgroundColor: isNotConnected ? Colors.red : Colors.green,
        duration: Duration(seconds: isNotConnected ? 6000 : 3),
        content: Text(
          isNotConnected ? getTranslated('no_connection', context) : getTranslated('connected', context),
          textAlign: TextAlign.center,
        ),
      ));
    });
  }
}
