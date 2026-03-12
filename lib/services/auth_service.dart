import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Get auth token from session
  Future<String?> getToken() async {
    return _supabase.auth.currentSession?.accessToken;
  }

  // Get refresh token from session
  Future<String?> getRefreshToken() async {
    return _supabase.auth.currentSession?.refreshToken;
  }

  // Clear auth data is handled by Supabase
  Future<void> clearAuthData() async {
    await _supabase.auth.signOut();
  }

  // Get stored user data (from current session/user)
  Future<Map<String, dynamic>?> getStoredUser() async {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      // Fetch profile data from the profiles table
      try {
        final profile = await _supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();
        return profile;
      } catch (e) {
        // Fallback to user metadata if profile fetch fails
        return {
          'id': user.id,
          'email': user.email,
          ...user.userMetadata ?? {},
        };
      }
    }
    return null;
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    return _supabase.auth.currentSession != null;
  }

  // Login user
  Future<AuthResult> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final profile = await getStoredUser();
        return AuthResult(
          success: true,
          user: profile,
          token: response.session?.accessToken,
          message: 'Login successful',
        );
      }

      return AuthResult(
        success: false,
        message: 'Login failed',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: e.toString(),
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
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
          'role': role,
        },
      );

      if (response.user != null) {
        // The trigger on the backend handles profile creation.
        // We might need to wait a moment or just return the data we have.
        final userData = {
          'id': response.user!.id,
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
          'role': role,
          'phone': phone,
        };

        return AuthResult(
          success: true,
          user: userData,
          token: response.session?.accessToken,
          message: 'Registration successful. Please check your email for verification.',
        );
      }

      return AuthResult(
        success: false,
        message: 'Registration failed',
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: e.toString(),
      );
    }
  }

  // Logout user
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // Refresh token is handled automatically by Supabase client
  Future<bool> refreshToken() async {
    try {
      final session = await _supabase.auth.refreshSession();
      return session.session != null;
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
