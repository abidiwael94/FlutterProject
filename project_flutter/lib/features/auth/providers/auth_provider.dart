import 'package:flutter/material.dart';
import 'package:project_flutter/Models/user.dart';
import 'package:project_flutter/features/auth/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<User?> loginUser({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.login(email: email, password: password);
      return user;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  Future<User?> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );
      return user;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
