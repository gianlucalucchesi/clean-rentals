import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

class Auth0 with ChangeNotifier {
  bool _isBusy = false;
  bool _isLoggedIn = false;
  String _errorMessage = '';
  String _name = '';
  String _picture = '';

  bool get isBusy {
    return _isBusy;
  }

  bool get isLoggedIn {
    return _isLoggedIn;
  }

  String get errorMessage {
    return _errorMessage;
  }

  String get name {
    return _name;
  }

  String get picture {
    return _picture;
  }

  setIsBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  setIsLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  setErrorMessage(String errorMessage) {
    _errorMessage = errorMessage;
  }

  setName(String name) {
    _name = name;
  }

  setPicture(String picture) {
    _picture = picture;
  }

  logout() async {
    await secureStorage.delete(key: 'refresh_token');
    _isBusy = false;
    _isLoggedIn = false;
    notifyListeners();
  }
}
