import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  bool _isSignIn = true;

  bool get isSignIn => _isSignIn;

  void toggleAuth() {
    _isSignIn = !_isSignIn;
    notifyListeners();
  }
}
