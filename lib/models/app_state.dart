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
    // Keep currentRole or reset it? 
    // Usually, reset to unknown or keep if they want to browse as guests.
    // Given the app's structure, reset to unknown is safer.
    _currentRole = UserRole.unknown;
    notifyListeners();
  }

  // Unified logout
  Future<void> logout() async {
    await _authService.logout();
    clearAuthState();
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
      
      // Set role from profile
      final roleStr = user?['role']?.toString();
      if (roleStr != null) {
        _currentRole = _stringToRole(roleStr);
      }
      
      notifyListeners();
    }
  }

  UserRole _stringToRole(String role) {
    switch (role.toLowerCase()) {
      case 'seller':
      case 'farmer':
        return UserRole.seller;
      case 'buyer':
        return UserRole.buyer;
      case 'driver':
      case 'transporter':
        return UserRole.driver;
      case 'ops_agent':
      case 'ops':
        return UserRole.opsAgent;
      case 'admin':
        return UserRole.admin;
      case 'finance':
        return UserRole.finance;
      case 'hub':
        return UserRole.hub;
      case 'partner':
        return UserRole.partner;
      case 'expert':
        return UserRole.expert;
      default:
        return UserRole.unknown;
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
