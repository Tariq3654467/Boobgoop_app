import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use 10.0.2.2 for Android Emulator, or localhost/your IP for iOS/Web/Physical Device
  static const String baseUrl = 'http://10.0.2.2:3000/api'; 
  
  // Future placeholder for auth tokens
  String? authToken;

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

  // Helper method for generic GET requests
  Future<dynamic> getEndpoint(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: _headers);
      return _processResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Helper method for generic POST requests
  Future<dynamic> postEndpoint(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Helper method for generic PUT requests
  Future<dynamic> putEndpoint(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _headers,
        body: json.encode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      throw Exception('API Error (${response.statusCode}): ${response.body}');
    }
  }

  // Example Specific Calls 
  
  /// Fetches market prices from the backend
  Future<List<dynamic>> getMarketPrices() async {
    final response = await getEndpoint('/prices');
    if (response['success'] == true) {
      return response['data'] ?? [];
    }
    return [];
  }

  /// Fetches community forum posts
  Future<List<dynamic>> getCommunityPosts() async {
    final response = await getEndpoint('/community/posts');
    if (response['success'] == true) {
      return response['data']['posts'] ?? [];
    }
    return [];
  }

  /// Fetches analytics for Partner dashboard
  Future<Map<String, dynamic>> getImpactReport() async {
    final response = await getEndpoint('/reports/impact');
    if (response['success'] == true) {
      return response['data'] ?? {};
    }
    return {};
  }

  /// Fetches orders from the backend
  Future<List<dynamic>> getOrders() async {
    final response = await getEndpoint('/orders');
    if (response['success'] == true) {
      return response['data'] ?? [];
    }
    return [];
  }

  /// Fetches current weather
  Future<Map<String, dynamic>> getWeather(double lat, double lng) async {
    final response = await getEndpoint('/weather?lat=$lat&lon=$lng');
    if (response['success'] == true) {
      return response['data'] ?? {};
    }
    return {};
  }
}
