import 'package:flutter/material.dart';
import 'package:shaparak/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
    authChangeNotifire.value = token;
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logout() {
    _sharedPref.clear();
    authChangeNotifire.value = null;
  }

  static bool isLogin() {
    String token = readAuth();
    return token.isNotEmpty;
  }

  static void saveUserId(String id) async {
    _sharedPref.setString('user_id', id);
  }

  static String getUserId() {
    return _sharedPref.getString('user_id') ?? '';
  }

  static void saveUsername(String username) async {
    _sharedPref.setString('username', username);
  }

  static String getUsername() {
    return _sharedPref.getString('username') ?? '';
  }
}
