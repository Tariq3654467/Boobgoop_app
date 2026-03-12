import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetches market prices from Supabase
  Future<List<dynamic>> getMarketPrices() async {
    try {
      final response = await _supabase.from('market_prices').select();
      return response as List<dynamic>;
    } catch (e) {
      print('Error fetching market prices: $e');
      return [];
    }
  }

  /// Fetches community forum posts
  Future<List<dynamic>> getCommunityPosts() async {
    try {
      final response = await _supabase
          .from('community_posts')
          .select('*, profiles(first_name, last_name)')
          .order('created_at', ascending: false);
      return response as List<dynamic>;
    } catch (e) {
      print('Error fetching community posts: $e');
      return [];
    }
  }

  /// Fetches analytics for Partner dashboard (Conceptual migration)
  Future<Map<String, dynamic>> getImpactReport() async {
    // This would likely be a complex query or a RPC call in Supabase
    return {}; 
  }

  /// Fetches orders for the current user
  Future<List<dynamic>> getOrders() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final response = await _supabase
          .from('orders')
          .select('*, order_items(*)')
          .or('buyer_id.eq.$userId,seller_id.eq.$userId')
          .order('created_at', ascending: false);
      return response as List<dynamic>;
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }

  /// Creates a new product listing
  Future<Map<String, dynamic>> createProduct(Map<String, dynamic> data) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      final productData = {
        ...data,
        'seller_id': userId,
      };

      final response = await _supabase.from('products').insert(productData).select().single();
      return response;
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  /// Fetches current weather (Conceptual - Supabase doesn't replace external APIs directly, 
  /// but we can store cached weather data)
  Future<Map<String, dynamic>> getWeather(double lat, double lng) async {
    try {
      final response = await _supabase
          .from('weather')
          .select()
          .limit(1)
          .single();
      return response;
    } catch (e) {
      return {};
    }
  }

  /// Fetches seller's own products
  Future<List<dynamic>> getMyProducts({String? status}) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      var query = _supabase.from('products').select().eq('seller_id', userId);
      
      if (status != null) {
        query = query.eq('status', status);
      }

      final response = await query.order('created_at', ascending: false);
      return response as List<dynamic>;
    } catch (e) {
      print('Error fetching my products: $e');
      return [];
    }
  }

  /// Updates a product
  Future<Map<String, dynamic>> updateProduct(String productId, Map<String, dynamic> data) async {
    try {
      final response = await _supabase
          .from('products')
          .update(data)
          .eq('id', productId)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  /// Deletes a product
  Future<void> deleteProduct(String productId) async {
    try {
      await _supabase.from('products').delete().eq('id', productId);
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }

  /// Fetches driver's deliveries
  Future<List<dynamic>> getDriverDeliveries() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final response = await _supabase
          .from('logistics')
          .select('*, orders(*)')
          .eq('driver_id', userId)
          .order('created_at', ascending: false);
      return response as List<dynamic>;
    } catch (e) {
      print('Error fetching driver deliveries: $e');
      return [];
    }
  }

  /// Updates delivery status
  Future<Map<String, dynamic>> updateDeliveryStatus(String deliveryId, String status) async {
    try {
      final response = await _supabase
          .from('logistics')
          .update({'status': status})
          .eq('id', deliveryId)
          .select()
          .single();
      return response;
    } catch (e) {
      throw Exception('Failed to update delivery status: $e');
    }
  }
}
