import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speedx_driver_122283/utils/sharedPref.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationNotifier with ChangeNotifier {
  AuthenticationState _state;

  AuthenticationState get getAuthenticationState => _state;
  BuildContext context;

  // DG code

  void notifyStateChange(AuthenticationEvent event) async {
    if (event is AppStarted) {
      _state = AuthenticationLoading();
      notifyListeners();
     // print('App is started');
      new Future.delayed(const Duration(seconds: 3), () {
        if (sharePrefereceInstance.getIsLogin() != null &&
            sharePrefereceInstance.getIsLogin()) {
             // print('App is login');
          _state = AuthenticationAuthenticated();
          notifyListeners();
        } else
          _state = AuthenticationUnauthenticated();
        notifyListeners();
      });
    } else if (event is GotoDashboardEvent) {
      //print('App is dashboard');
      _state = AuthenticationAuthenticated();
      notifyListeners();
    } else if (event is LoggedOut) {
      sharePrefereceInstance.clear();
     // print('App is logout');
      _state = AuthenticationUnauthenticated();
      notifyListeners();
    } else if (event is LoggedIn) {
      //print('App is login');
      _state = AuthenticationAuthenticated();
      notifyListeners();
    }
  }
}
