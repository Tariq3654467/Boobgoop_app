import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

/// Tracks global application state, such as the currently-selected user role.
class AppState extends ChangeNotifier {
  UserRole _currentRole = UserRole.unknown;
  
  // Auth state
  bool _isLoggedIn = false;
  Map<String, dynamic>? _currentUser;
  String? _authToken;
  final AuthService _authService = AuthService();

  UserRole get currentRole => _currentRole;

  bool get hasRole => _currentRole != UserRole.unknown;
  
  bool get isLoggedIn => _isLoggedIn;
  Map<String, dynamic>? get currentUser => _currentUser;
  String? get authToken => _authToken;
  AuthService get authService => _authService;

  void setRole(UserRole role) {
    if (_currentRole == role) return;
    _currentRole = role;
    notifyListeners();
  }
  
  // Update auth state after login/register
  void updateAuthState({
    required bool isLoggedIn,
    Map<String, dynamic>? user,
    String? token,
  }) {
    _isLoggedIn = isLoggedIn;
    _currentUser = user;
    _authToken = token;
    notifyListeners();
  }
  
  // Clear auth state on logout
  void clearAuthState() {
    _isLoggedIn = false;
    _currentUser = null;
    _authToken = null;
    notifyListeners();
  }

  // Initialize auth state from stored data
  Future<void> initializeAuth() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (isLoggedIn) {
      final user = await _authService.getStoredUser();
      final token = await _authService.getToken();
      _isLoggedIn = true;
      _currentUser = user;
      _authToken = token;
      notifyListeners();
    }
  }
}

enum UserRole {
  unknown,
  buyer,
  seller,
  opsAgent,
  driver,
  admin,
  finance,
  hub,
  partner,
  expert,
}
