import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import 'order_detail_screen.dart';

class SellerOrdersScreen extends StatefulWidget {
  const SellerOrdersScreen({super.key});

  @override
  State<SellerOrdersScreen> createState() => _SellerOrdersScreenState();
}

class _SellerOrdersScreenState extends State<SellerOrdersScreen>
    with SingleTickerProviderStateMixin {
  List<dynamic> _allOrders = [];
  bool _isLoading = true;
  String? _error;
  late TabController _tabController;

  final _tabs = ['All', 'Pending', 'Accepted', 'Shipped', 'Delivered'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _fetchOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final token = context.read<AppState>().authToken;
      final api = ApiService(authToken: token);
      final orders = await api.getSellerOrders();
      setState(() {
        _allOrders = orders;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  List<dynamic> _filteredOrders(int tabIndex) {
    if (tabIndex == 0) return _allOrders;
    final filter = _tabs[tabIndex].toLowerCase();
    return _allOrders
        .where((o) => o['status']?.toString().toLowerCase() == filter)
        .toList();
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'accepted':
        return Colors.blue;
      case 'processing':
        return Colors.indigo;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
      case 'completed':
        return Colors.green;
      case 'cancelled':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'accepted':
        return 'Accepted';
      case 'processing':
        return 'Processing';
      case 'shipped':
        return 'Shipped';
      case 'delivered':
        return 'Delivered';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'rejected':
        return 'Rejected';
      default:
        return status ?? 'Unknown';
    }
  }

  Future<void> _quickAccept(String orderId) async {
    try {
      final token = context.read<AppState>().authToken;
      final api = ApiService(authToken: token);
      await api.acceptOrder(orderId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order accepted!'),
          backgroundColor: Colors.green,
        ),
      );
      _fetchOrders();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _quickReject(String orderId) async {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dc) => AlertDialog(
        title: const Text('Reject Order'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Reason (optional)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(dc).pop(),
              child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.of(dc).pop();
              try {
                final token = context.read<AppState>().authToken;
                final api = ApiService(authToken: token);
                await api.rejectOrder(orderId, controller.text.trim());
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order rejected'),
                    backgroundColor: Colors.red,
                  ),
                );
                _fetchOrders();
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red),
                );
              }
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final orderId = order['id']?.toString().substring(0, 8) ?? '';
    final status = order['status']?.toString().toLowerCase() ?? 'unknown';
    final totalAmount = order['total_amount']?.toString() ?? '0.00';
    final createdAt = order['created_at']?.toString() ?? '';
    final orderItems = order['order_items'] as List? ?? [];
    final buyerProfile = order['profiles'] as Map<String, dynamic>?;
    final buyerName = buyerProfile != null
        ? '${buyerProfile['first_name'] ?? ''} ${buyerProfile['last_name'] ?? ''}'
            .trim()
        : 'Buyer';
    final buyerPhone = buyerProfile?['phone']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (_) => OrderDetailScreen(order: order),
                ),
              )
              .then((_) => _fetchOrders());
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('#$orderId',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      if (buyerName.isNotEmpty)
                        Text(buyerName,
                            style: TextStyle(
                                color: AppColors.textMedium, fontSize: 13)),
                      if (buyerPhone.isNotEmpty)
                        Text(buyerPhone,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: _getStatusColor(status).withOpacity(0.4)),
                    ),
                    child: Text(
                      _getStatusLabel(status),
                      style: TextStyle(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.shopping_basket,
                      size: 14, color: AppColors.textMedium),
                  const SizedBox(width: 4),
                  Text(
                    '${orderItems.length} item${orderItems.length != 1 ? 's' : ''}',
                    style:
                        TextStyle(color: AppColors.textMedium, fontSize: 13),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.attach_money,
                      size: 14, color: AppColors.secondaryGreen),
                  Text(
                    'SOS $totalAmount',
                    style: TextStyle(
                        color: AppColors.secondaryGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ],
              ),
              if (createdAt.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  'Received: ${createdAt.substring(0, 10)}',
                  style:
                      const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
              // Quick accept/reject for pending orders
              if (status == 'pending') ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.check, size: 16),
                        label: const Text('Accept'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGreen,
                          minimumSize: const Size.fromHeight(40),
                          textStyle: const TextStyle(fontSize: 13),
                        ),
                        onPressed: () => _quickAccept(order['id']),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.close, size: 16),
                        label: const Text('Reject'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          minimumSize: const Size.fromHeight(40),
                          textStyle: const TextStyle(fontSize: 13),
                        ),
                        onPressed: () => _quickReject(order['id']),
                      ),
                    ),
                  ],
                ),
              ],
              // Update status for accepted/processing/shipped
              if (status == 'accepted' ||
                  status == 'processing' ||
                  status == 'shipped') ...[
                const SizedBox(height: 12),
                _buildNextStepButton(order['id'], status),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextStepButton(String orderId, String status) {
    String label;
    String nextStatus;
    Color color;
    IconData icon;

    switch (status) {
      case 'accepted':
        label = 'Start Processing';
        nextStatus = 'processing';
        color = Colors.indigo;
        icon = Icons.settings;
        break;
      case 'processing':
        label = 'Mark as Shipped';
        nextStatus = 'shipped';
        color = Colors.purple;
        icon = Icons.local_shipping;
        break;
      case 'shipped':
        label = 'Confirm Delivered';
        nextStatus = 'delivered';
        color = Colors.green;
        icon = Icons.home;
        break;
      default:
        return const SizedBox.shrink();
    }

    return ElevatedButton.icon(
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size.fromHeight(40),
        textStyle: const TextStyle(fontSize: 13),
      ),
      onPressed: () async {
        try {
          final token = context.read<AppState>().authToken;
          final api = ApiService(authToken: token);
          await api.updateOrderStatus(orderId, nextStatus);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order updated to $nextStatus'),
              backgroundColor: color,
            ),
          );
          _fetchOrders();
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Inbox'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.white,
          tabs: _tabs
              .asMap()
              .entries
              .map(
                (e) => Tab(
                  text: e.value == 'All'
                      ? 'All (${_allOrders.length})'
                      : e.value == 'Pending'
                          ? 'Pending (${_filteredOrders(1).length})'
                          : e.value,
                ),
              )
              .toList(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchOrders,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      const Text('Error loading orders'),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _fetchOrders,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : TabBarView(
                  controller: _tabController,
                  children: List.generate(_tabs.length, (i) {
                    final orders = _filteredOrders(i);
                    if (orders.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 64,
                              color: AppColors.primaryBlue.withOpacity(0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              i == 0
                                  ? 'No orders yet'
                                  : 'No ${_tabs[i].toLowerCase()} orders',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              i == 1
                                  ? 'New orders will appear here'
                                  : 'Nothing to show here',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: _fetchOrders,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: orders.length,
                        itemBuilder: (context, index) =>
                            _buildOrderCard(orders[index]),
                      ),
                    );
                  }),
                ),
    );
  }
}
