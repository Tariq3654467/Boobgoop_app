import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class DeliveriesScreen extends StatefulWidget {
  const DeliveriesScreen({super.key});

  @override
  State<DeliveriesScreen> createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic> _pendingDeliveries = [];
  List<dynamic> _activeDeliveries = [];
  List<dynamic> _completedDeliveries = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchDeliveries();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchDeliveries() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final appState = context.read<AppState>();
      final token = appState.authToken;

      if (token == null || token.isEmpty) {
        setState(() {
          _error = 'Please log in to view deliveries.';
          _isLoading = false;
        });
        return;
      }

      final api = ApiService(authToken: token);
      final allDeliveries = await api.getEndpoint('/logistics');

      if (allDeliveries['success'] == true) {
        final logistics = allDeliveries['data'] ?? [];
        
        setState(() {
          _pendingDeliveries = logistics.where((d) => d['status'] == 'assigned').toList();
          _activeDeliveries = logistics.where((d) => 
            d['status'] == 'accepted' || 
            d['status'] == 'picked_up' || 
            d['status'] == 'in_transit'
          ).toList();
          _completedDeliveries = logistics.where((d) => 
            d['status'] == 'delivered' || 
            d['status'] == 'completed'
          ).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _updateDeliveryStatus(int deliveryId, String newStatus) async {
    try {
      final appState = context.read<AppState>();
      final api = ApiService(authToken: appState.authToken);
      
      await api.putEndpoint('/logistics/$deliveryId/status', {'status': newStatus});

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Delivery status updated to $newStatus'),
            backgroundColor: AppColors.secondaryGreen,
          ),
        );
        _fetchDeliveries();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deliveries'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Pending (${_pendingDeliveries.length})'),
            Tab(text: 'Active (${_activeDeliveries.length})'),
            Tab(text: 'Completed (${_completedDeliveries.length})'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchDeliveries,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(_error!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchDeliveries,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildDeliveryList(_pendingDeliveries, 'pending'),
        _buildDeliveryList(_activeDeliveries, 'active'),
        _buildDeliveryList(_completedDeliveries, 'completed'),
      ],
    );
  }

  Widget _buildDeliveryList(List<dynamic> deliveries, String type) {
    if (deliveries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              type == 'pending' ? Icons.pending_actions :
              type == 'active' ? Icons.local_shipping : Icons.check_circle,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              type == 'pending' ? 'No pending deliveries' :
              type == 'active' ? 'No active deliveries' : 'No completed deliveries',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchDeliveries,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          final delivery = deliveries[index];
          return _DeliveryCard(
            delivery: delivery,
            type: type,
            onStatusUpdate: _updateDeliveryStatus,
          );
        },
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  final Map<String, dynamic> delivery;
  final String type;
  final Function(int, String) onStatusUpdate;

  const _DeliveryCard({
    required this.delivery,
    required this.type,
    required this.onStatusUpdate,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'assigned':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'picked_up':
        return Colors.purple;
      case 'in_transit':
        return Colors.amber;
      case 'delivered':
      case 'completed':
        return AppColors.secondaryGreen;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = delivery['order'] ?? {};
    final status = delivery['status'] ?? 'assigned';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with order info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order['orderNumber']?.toString().substring(0, 8) ?? delivery['id']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SOS ${order['total']?.toStringAsFixed(0) ?? '0'}',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Chip(
                  label: Text(
                    status.toUpperCase().replaceAll('_', ' '),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: _getStatusColor(status),
                ),
              ],
            ),
            const Divider(height: 24),
            // Delivery details
            if (delivery['pickupAddress'] != null) ...[
              _InfoRow(
                icon: Icons.location_on,
                label: 'Pickup',
                value: delivery['pickupAddress'],
              ),
              const SizedBox(height: 8),
            ],
            if (delivery['deliveryAddress'] != null) ...[
              _InfoRow(
                icon: Icons.flag,
                label: 'Delivery',
                value: delivery['deliveryAddress'],
              ),
              const SizedBox(height: 8),
            ],
            if (delivery['deliveryRegion'] != null)
              _InfoRow(
                icon: Icons.map,
                label: 'Region',
                value: delivery['deliveryRegion'],
              ),
            // Action buttons based on status
            if (type == 'pending') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => onStatusUpdate(delivery['id'], 'cancelled'),
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text('Decline'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => onStatusUpdate(delivery['id'], 'accepted'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryGreen,
                      ),
                      child: const Text('Accept'),
                    ),
                  ),
                ],
              ),
            ],
            if (type == 'active') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  if (status == 'accepted')
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => onStatusUpdate(delivery['id'], 'picked_up'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        child: const Text('Mark Picked Up'),
                      ),
                    ),
                  if (status == 'picked_up' || status == 'in_transit')
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => onStatusUpdate(delivery['id'], 'delivered'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGreen,
                        ),
                        child: const Text('Mark Delivered'),
                      ),
                    ),
                ],
              ),
            ],
            if (type == 'completed' && delivery['proofOfDelivery'] != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.secondaryGreen, size: 16),
                  const SizedBox(width: 8),
                  Text('Proof of delivery submitted'),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // View proof of delivery
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Proof of Delivery'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (delivery['proofOfDelivery'] != null)
                                Text('Image: ${delivery['proofOfDelivery']}'),
                              if (delivery['deliveryNotes'] != null)
                                Text('Notes: ${delivery['deliveryNotes']}'),
                              if (delivery['actualDelivery'] != null)
                                Text('Delivered at: ${delivery['actualDelivery']}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('View'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}

