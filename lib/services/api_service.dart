import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final String? authToken;

  ApiService({this.authToken});

  /// Generic fetcher for Supabase tables
  Future<Map<String, dynamic>> getEndpoint(String path) async {
    try {
      final tableName = path.startsWith('/') ? path.substring(1) : path;
      final response = await _supabase.from(tableName).select();
      
      final List<dynamic> list = response as List<dynamic>;
      return {
        'success': true,
        'data': list,
      };
    } catch (e) {
      print('Error in getEndpoint ($path): $e');
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Generic update for Supabase tables
  Future<Map<String, dynamic>> putEndpoint(String path, Map<String, dynamic> data) async {
    try {
      // Expecting path like /table/id or /table/id/status
      final parts = path.split('/').where((p) => p.isNotEmpty).toList();
      if (parts.isEmpty) throw Exception('Invalid path');
      
      final tableName = parts[0];
      final id = parts.length > 1 ? parts[1] : null;

      if (id == null) throw Exception('ID missing in path');

      final response = await _supabase
          .from(tableName)
          .update(data)
          .eq('id', id)
          .select()
          .single();
      
      return {'success': true, 'data': response};
    } catch (e) {
      print('Error in putEndpoint ($path): $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Generic insert for Supabase tables
  Future<Map<String, dynamic>> postEndpoint(String path, Map<String, dynamic> data) async {
    try {
      final tableName = path.startsWith('/') ? path.substring(1) : path;
      final response = await _supabase.from(tableName).insert(data).select().single();
      return {'success': true, 'data': response};
    } catch (e) {
      print('Error in postEndpoint ($path): $e');
      return {'success': false, 'error': e.toString()};
    }
  }

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

  /// Fetches live product listings from Supabase
  Future<List<dynamic>> getProducts() async {
    try {
      final response = await _supabase
          .from('products')
          .select('*, profiles(first_name, last_name, phone, region)')
          .order('created_at', ascending: false)
          .limit(100);
      return response as List<dynamic>;
    } catch (e) {
      print('Error fetching products: $e');
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
  Future<void> deleteProduct(dynamic productId) async {
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

  // ============ ORDER MANAGEMENT METHODS ============

  /// Creates a new order (buyer places order)
  Future<Map<String, dynamic>> createOrder({
    required String productId,
    required double quantity,
    required double totalPrice,
    String? notes,
  }) async {
    try {
      final buyerId = _supabase.auth.currentUser?.id;
      if (buyerId == null) throw Exception('User not authenticated');

      // First get the product to find the seller
      final product = await _supabase
          .from('products')
          .select('seller_id, name, price_per_unit')
          .eq('id', productId)
          .single();

      final sellerId = product['seller_id'];
      if (sellerId == null) throw Exception('Product seller not found');

      // Create the order
      final orderData = {
        'buyer_id': buyerId,
        'seller_id': sellerId,
        'status': 'pending',
        'total_amount': totalPrice,
        'notes': notes,
        'created_at': DateTime.now().toIso8601String(),
      };

      final order = await _supabase
          .from('orders')
          .insert(orderData)
          .select()
          .single();

      // Create order item
      await _supabase.from('order_items').insert({
        'order_id': order['id'],
        'product_id': productId,
        'quantity': quantity,
        'unit_price': product['price_per_unit'],
        'subtotal': quantity * product['price_per_unit'],
      });

      return order;
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  /// Gets all orders for the current buyer
  Future<List<dynamic>> getBuyerOrders() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final response = await _supabase
          .from('orders')
          .select('*, profiles!inner(first_name, last_name), order_items(*, products(name, price_per_unit))')
          .eq('buyer_id', userId)
          .order('created_at', ascending: false);

      return response as List<dynamic>;
    } catch (e) {
      print('Error fetching buyer orders: $e');
      return [];
    }
  }

  /// Gets all orders for the current seller
  Future<List<dynamic>> getSellerOrders() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return [];

      final response = await _supabase
          .from('orders')
          .select('*, profiles!buyer_id(first_name, last_name, phone), order_items(*, products(name, price_per_unit))')
          .eq('seller_id', userId)
          .order('created_at', ascending: false);

      return response as List<dynamic>;
    } catch (e) {
      print('Error fetching seller orders: $e');
      return [];
    }
  }

  /// Gets detailed information about a specific order
  Future<Map<String, dynamic>> getOrderDetails(String orderId) async {
    try {
      final response = await _supabase
          .from('orders')
          .select('*, profiles!buyer_id(first_name, last_name, phone, region), order_items(*, products(*))')
          .eq('id', orderId)
          .single();

      return response;
    } catch (e) {
      throw Exception('Failed to fetch order details: $e');
    }
  }

  /// Seller accepts an order
  Future<Map<String, dynamic>> acceptOrder(String orderId) async {
    try {
      final response = await _supabase
          .from('orders')
          .update({
            'status': 'accepted',
            'accepted_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId)
          .select()
          .single();

      return response;
    } catch (e) {
      throw Exception('Failed to accept order: $e');
    }
  }

  /// Seller rejects an order
  Future<Map<String, dynamic>> rejectOrder(String orderId, String reason) async {
    try {
      final response = await _supabase
          .from('orders')
          .update({
            'status': 'rejected',
            'rejection_reason': reason,
            'rejected_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId)
          .select()
          .single();

      return response;
    } catch (e) {
      throw Exception('Failed to reject order: $e');
    }
  }

  /// Updates order status (can be called by seller or system)
  Future<Map<String, dynamic>> updateOrderStatus(String orderId, String status) async {
    try {
      final updateData = {'status': status};

      // Add timestamp based on status
      switch (status) {
        case 'processing':
          updateData['processing_at'] = DateTime.now().toIso8601String();
          break;
        case 'shipped':
          updateData['shipped_at'] = DateTime.now().toIso8601String();
          break;
        case 'delivered':
          updateData['delivered_at'] = DateTime.now().toIso8601String();
          break;
        case 'completed':
          updateData['completed_at'] = DateTime.now().toIso8601String();
          break;
      }

      final response = await _supabase
          .from('orders')
          .update(updateData)
          .eq('id', orderId)
          .select()
          .single();

      return response;
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  /// Buyer cancels an order
  Future<Map<String, dynamic>> cancelOrder(String orderId, String reason) async {
    try {
      // Can only cancel pending or accepted orders
      final order = await _supabase
          .from('orders')
          .select('status')
          .eq('id', orderId)
          .single();

      final status = order['status'];
      if (status != 'pending' && status != 'accepted') {
        throw Exception('Cannot cancel order with status: $status');
      }

      final response = await _supabase
          .from('orders')
          .update({
            'status': 'cancelled',
            'cancellation_reason': reason,
            'cancelled_at': DateTime.now().toIso8601String(),
          })
          .eq('id', orderId)
          .select()
          .single();

      return response;
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }
}
