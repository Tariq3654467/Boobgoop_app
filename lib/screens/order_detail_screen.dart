import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';

class OrderDetailScreen extends StatefulWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late Map<String, dynamic> _order;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _order = widget.order;
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
        return 'Pending — Waiting for seller';
      case 'accepted':
        return 'Accepted by seller';
      case 'processing':
        return 'Processing';
      case 'shipped':
        return 'Shipped — On the way';
      case 'delivered':
        return 'Delivered';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'rejected':
        return 'Rejected by seller';
      default:
        return status ?? 'Unknown';
    }
  }

  Future<void> _updateStatus(String newStatus, {String? reason}) async {
    setState(() => _isLoading = true);
    try {
      final token = context.read<AppState>().authToken;
      final api = ApiService(authToken: token);
      Map<String, dynamic> updated;
      if (newStatus == 'accepted') {
        updated = await api.acceptOrder(_order['id']);
      } else if (newStatus == 'rejected') {
        updated = await api.rejectOrder(_order['id'], reason ?? '');
      } else {
        updated = await api.updateOrderStatus(_order['id'], newStatus);
      }
      setState(() {
        _order = {..._order, ...updated};
        _isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order updated to: ${_getStatusLabel(newStatus)}'),
          backgroundColor: _getStatusColor(newStatus),
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _showRejectDialog() async {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reject Order'),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Reason for rejection (optional)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _updateStatus('rejected', reason: controller.text.trim());
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final statuses = ['pending', 'accepted', 'processing', 'shipped', 'delivered'];
    final currentStatus = _order['status']?.toString().toLowerCase() ?? '';
    final isCancelledOrRejected =
        currentStatus == 'cancelled' || currentStatus == 'rejected';

    final labels = {
      'pending': 'Pending',
      'accepted': 'Accepted',
      'processing': 'Processing',
      'shipped': 'Shipped',
      'delivered': 'Delivered',
    };

    final icons = {
      'pending': Icons.hourglass_empty,
      'accepted': Icons.check_circle_outline,
      'processing': Icons.settings,
      'shipped': Icons.local_shipping,
      'delivered': Icons.home,
    };

    if (isCancelledOrRejected) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentStatus == 'cancelled'
                        ? 'Order Cancelled'
                        : 'Order Rejected',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (_order['cancellation_reason'] != null ||
                      _order['rejection_reason'] != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      _order['cancellation_reason'] ??
                          _order['rejection_reason'] ??
                          '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    }

    final currentIndex = statuses.indexOf(currentStatus);

    return Row(
      children: List.generate(statuses.length, (index) {
        final status = statuses[index];
        final isCompleted = index <= currentIndex;
        final isCurrent = index == currentIndex;
        final color = isCompleted ? AppColors.secondaryGreen : Colors.grey.shade300;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (index != 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: index <= currentIndex
                            ? AppColors.secondaryGreen
                            : Colors.grey.shade300,
                      ),
                    ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isCurrent
                          ? Border.all(color: AppColors.secondaryGreen, width: 3)
                          : null,
                    ),
                    child: Icon(
                      icons[status],
                      size: 16,
                      color: isCompleted ? Colors.white : Colors.grey,
                    ),
                  ),
                  if (index != statuses.length - 1) const SizedBox(width: 0),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                labels[status] ?? status,
                style: TextStyle(
                  fontSize: 9,
                  color: isCompleted ? AppColors.secondaryGreen : Colors.grey,
                  fontWeight:
                      isCurrent ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.textMedium,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final isSeller = appState.currentRole == UserRole.seller;
    final orderId = _order['id']?.toString().substring(0, 8) ?? '';
    final status = _order['status']?.toString().toLowerCase() ?? 'unknown';
    final totalAmount = _order['total_amount']?.toString() ?? '0.00';
    final createdAt = _order['created_at']?.toString() ?? '';
    final notes = _order['notes']?.toString() ?? '';
    final orderItems = _order['order_items'] as List? ?? [];

    // Buyer info (for seller view)
    final buyerProfile = _order['profiles'] as Map<String, dynamic>?;
    final buyerName = buyerProfile != null
        ? '${buyerProfile['first_name'] ?? ''} ${buyerProfile['last_name'] ?? ''}'.trim()
        : 'Buyer';
    final buyerPhone = buyerProfile?['phone']?.toString() ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: Text('Order #$orderId'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _getStatusLabel(status),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(status),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(status).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color:
                                          _getStatusColor(status).withOpacity(0.3)),
                                ),
                                child: Text(
                                  status.toUpperCase(),
                                  style: TextStyle(
                                    color: _getStatusColor(status),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildTimeline(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Order Info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Details',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Divider(),
                          _buildInfoRow('Order ID:', '#$orderId'),
                          _buildInfoRow('Total:', 'SOS $totalAmount'),
                          _buildInfoRow(
                              'Placed:',
                              createdAt.isNotEmpty
                                  ? createdAt.substring(0, 10)
                                  : 'N/A'),
                          if (notes.isNotEmpty)
                            _buildInfoRow('Notes:', notes),
                          if (isSeller && buyerProfile != null) ...[
                            const Divider(),
                            Text(
                              'Buyer Info',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow('Name:', buyerName),
                            _buildInfoRow('Phone:', buyerPhone),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Order Items
                  if (orderItems.isNotEmpty) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Items (${orderItems.length})',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                            ...orderItems.map((item) {
                              final product =
                                  item['products'] as Map<String, dynamic>? ?? {};
                              final productName = product['name']?.toString() ??
                                  'Product';
                              final quantity =
                                  item['quantity']?.toString() ?? '?';
                              final unitPrice =
                                  item['unit_price']?.toString() ?? '0';
                              final subtotal =
                                  item['subtotal']?.toString() ?? '0';
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryBlue
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                      child: Icon(Icons.agriculture,
                                          color: AppColors.primaryBlue,
                                          size: 20),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(productName,
                                              style: const TextStyle(
                                                  fontWeight:
                                                      FontWeight.w600)),
                                          Text(
                                            'Qty: $quantity × SOS $unitPrice',
                                            style: TextStyle(
                                                color: AppColors.textMedium,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'SOS $subtotal',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondaryGreen,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'SOS $totalAmount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.secondaryGreen,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Actions (role-specific)
                  if (isSeller) ...[
                    if (status == 'pending') ...[
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.check),
                              label: const Text('Accept Order'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryGreen,
                                minimumSize: const Size.fromHeight(52),
                              ),
                              onPressed: () => _updateStatus('accepted'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.close),
                              label: const Text('Reject'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                minimumSize: const Size.fromHeight(52),
                              ),
                              onPressed: _showRejectDialog,
                            ),
                          ),
                        ],
                      ),
                    ] else if (status == 'accepted') ...[
                      ElevatedButton.icon(
                        icon: const Icon(Icons.settings),
                        label: const Text('Mark as Processing'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          backgroundColor: Colors.indigo,
                        ),
                        onPressed: () => _updateStatus('processing'),
                      ),
                    ] else if (status == 'processing') ...[
                      ElevatedButton.icon(
                        icon: const Icon(Icons.local_shipping),
                        label: const Text('Mark as Shipped'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          backgroundColor: Colors.purple,
                        ),
                        onPressed: () => _updateStatus('shipped'),
                      ),
                    ] else if (status == 'shipped') ...[
                      ElevatedButton.icon(
                        icon: const Icon(Icons.home),
                        label: const Text('Mark as Delivered'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          backgroundColor: AppColors.secondaryGreen,
                        ),
                        onPressed: () => _updateStatus('delivered'),
                      ),
                    ],
                  ] else ...[
                    // Buyer actions
                    if (status == 'pending') ...[
                      OutlinedButton.icon(
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel Order'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          minimumSize: const Size.fromHeight(52),
                        ),
                        onPressed: () async {
                          final reasonCtrl = TextEditingController();
                          showDialog(
                            context: context,
                            builder: (dc) => AlertDialog(
                              title: const Text('Cancel Order'),
                              content: TextField(
                                controller: reasonCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'Reason (optional)',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.of(dc).pop(),
                                    child: const Text('Back')),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () async {
                                    Navigator.of(dc).pop();
                                    try {
                                      final token = context
                                          .read<AppState>()
                                          .authToken;
                                      final api =
                                          ApiService(authToken: token);
                                      await api.cancelOrder(
                                          _order['id'],
                                          reasonCtrl.text.trim());
                                      if (!mounted) return;
                                      setState(() {
                                        _order = {
                                          ..._order,
                                          'status': 'cancelled',
                                        };
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Order cancelled successfully'),
                                            backgroundColor: Colors.red),
                                      );
                                    } catch (e) {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text('Error: $e'),
                                            backgroundColor: Colors.red),
                                      );
                                    }
                                  },
                                  child: const Text('Cancel Order'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }
}
