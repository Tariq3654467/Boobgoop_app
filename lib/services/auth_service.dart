import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Use 10.0.2.2 for Android Emulator, or localhost/your IP for iOS/Web/Physical Device
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  
  // Keys for SharedPreferences
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';

  // Get auth token from storage
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get refresh token from storage
  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  // Save tokens and user data
  Future<void> _saveAuthData(String token, String refreshToken, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_userKey, json.encode(user));
  }

  // Clear auth data on logout
  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_userKey);
  }

  // Get stored user data
  Future<Map<String, dynamic>?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString(_userKey);
    if (userStr != null) {
      return json.decode(userStr) as Map<String, dynamic>;
    }
    return null;
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Login user
  Future<AuthResult> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (data['success'] == true) {
          final userData = data['data']['user'] as Map<String, dynamic>;
          final token = data['data']['token'] as String;
          final refreshToken = data['data']['refreshToken'] as String;

          await _saveAuthData(token, refreshToken, userData);

          return AuthResult(
            success: true,
            user: userData,
            token: token,
            message: data['message'] ?? 'Login successful',
          );
        }
      }

      return AuthResult(
        success: false,
        message: data['message'] ?? 'Login failed',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Register new user
  Future<AuthResult> register({
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'phone': phone,
          'firstName': firstName,
          'lastName': lastName,
          'role': role,
        }),
      );

      final data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (data['success'] == true) {
          final userData = data['data']['user'] as Map<String, dynamic>;
          final token = data['data']['token'] as String;
          final refreshToken = data['data']['refreshToken'] as String;

          await _saveAuthData(token, refreshToken, userData);

          return AuthResult(
            success: true,
            user: userData,
            token: token,
            message: data['message'] ?? 'Registration successful',
          );
        }
      }

      return AuthResult(
        success: false,
        message: data['message'] ?? 'Registration failed',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Get current user data from backend
  Future<AuthResult> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token == null) {
        return AuthResult(success: false, message: 'Not authenticated');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/auth/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (data['success'] == true) {
          final userData = data['data'] as Map<String, dynamic>;
          
          // Update stored user data
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_userKey, json.encode(userData));

          return AuthResult(
            success: true,
            user: userData,
            token: token,
          );
        }
      }

      return AuthResult(
        success: false,
        message: data['message'] ?? 'Failed to get user',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      final token = await getToken();
      if (token != null) {
        // Try to notify backend (but don't wait for response)
        http.post(
          Uri.parse('$baseUrl/auth/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      }
    } catch (_) {
      // Ignore network errors during logout
    } finally {
      await clearAuthData();
    }
  }

  // Refresh token
  Future<bool> refreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) {
        return false;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refreshToken': refreshToken}),
      );

      final data = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300 && data['success'] == true) {
        final newToken = data['data']['token'] as String;
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_tokenKey, newToken);
        
        return true;
      }

      return false;
    } catch (_) {
      return false;
    }
  }
}

// Result class for auth operations
class AuthResult {
  final bool success;
  final Map<String, dynamic>? user;
  final String? token;
  final String message;

  AuthResult({
    required this.success,
    this.user,
    this.token,
    this.message = '',
  });
}

