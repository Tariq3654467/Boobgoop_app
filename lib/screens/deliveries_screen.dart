import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class DeliveriesScreen extends StatefulWidget {
  const DeliveriesScreen({super.key});

  @override
  State<DeliveriesScreen> createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _deliveries = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchDeliveries();
  }

  Future<void> _fetchDeliveries() async {
    try {
      final res = await _apiService.getEndpoint('/logistics');
      if (res['success'] == true) {
        setState(() {
          _deliveries = res['data'] ?? [];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deliveries'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            const Text('Error loading deliveries'),
            ElevatedButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _fetchDeliveries();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_deliveries.isEmpty) return const Center(child: Text('No active deliveries.'));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _deliveries.length,
      itemBuilder: (context, index) {
        final d = _deliveries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.accentOrange.withOpacity(0.2),
              child: Icon(Icons.local_shipping, color: AppColors.accentOrange),
            ),
            title: Text('Order #${d['orderId']?.toString().substring(0,8) ?? 'Unknown'}'),
            subtitle: Text('${d['shippingAddress'] ?? 'No Address'}'),
            trailing: Chip(
              label: Text(
                d['status']?.toString().toUpperCase() ?? 'PENDING',
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delivery Details stub')));
            },
          ),
        );
      },
    );
  }
}
