import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;
  String? _email;
  String? _profileImage;

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;
  String? get email => _email;
  String? get profileImage => _profileImage;

  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    if (email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _email = email;
      _username = email.split('@')[0];
      _profileImage = 'https://via.placeholder.com/150';
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _username = null;
    _email = null;
    _profileImage = null;
    notifyListeners();
  }

  Future<void> updateProfile({String? username, String? profileImage}) async {
    if (username != null) _username = username;
    if (profileImage != null) _profileImage = profileImage;
    notifyListeners();
  }
}
