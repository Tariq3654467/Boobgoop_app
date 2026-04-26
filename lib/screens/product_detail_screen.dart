import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../models/app_state.dart';
import '../services/api_service.dart';
import '../l10n/app_localizations.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isOrderLoading = false;
  String? _orderError;

  Future<void> _showOrderDialog() async {
    final quantityController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Place Order'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: quantityController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Quantity (${widget.product['unit'] ?? 'kg'})',
                    hintText: 'e.g., 10',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter quantity';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    final qty = double.parse(value);
                    final minOrder = double.tryParse(
                      widget.product['min_order']?.toString() ?? '1',
                    ) ?? 1;
                    if (qty < minOrder) {
                      return 'Minimum order: $minOrder';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'Estimated total: SOS ${_calculateTotal(quantityController.text)}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryGreen,
              ),
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;

                final quantity = double.parse(quantityController.text.trim());
                final price = double.tryParse(widget.product['price']?.toString() ?? '0') ?? 0;
                final totalPrice = quantity * price;

                Navigator.of(dialogContext).pop();

                await _placeOrder(
                  quantity: quantity,
                  totalPrice: totalPrice,
                );
              },
              child: const Text('Place Order'),
            ),
          ],
        );
      },
    );
  }

  String _calculateTotal(String quantity) {
    if (quantity.isEmpty) return '0.00';
    final qty = double.tryParse(quantity) ?? 0;
    final price = double.tryParse(widget.product['price']?.toString() ?? '0') ?? 0;
    return (qty * price).toStringAsFixed(2);
  }

  Future<void> _placeOrder({
    required double quantity,
    required double totalPrice,
  }) async {
    setState(() {
      _isOrderLoading = true;
      _orderError = null;
    });

    try {
      final appState = context.read<AppState>();
      final token = appState.authToken;

      if (token == null || token.isEmpty) {
        setState(() {
          _orderError = 'Please login to place an order';
          _isOrderLoading = false;
        });
        return;
      }

      final api = ApiService(authToken: token);
      final order = await api.createOrder(
        productId: widget.product['id'],
        quantity: quantity,
        totalPrice: totalPrice,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Order placed successfully!'),
          backgroundColor: AppColors.secondaryGreen,
          duration: const Duration(seconds: 3),
        ),
      );

      setState(() => _isOrderLoading = false);

      // Navigate to orders screen or order detail
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } catch (e) {
      setState(() {
        _orderError = e.toString();
        _isOrderLoading = false;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $_orderError'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final seller = product['profiles'] ?? {};
    final imageUrl = product['image_url'] as String?;
    final unit = product['unit'] as String? ?? 'kg';
    final price = product['price']?.toString() ?? 'N/A';
    final category = product['category'] as String? ?? 'Produce';
    final deliveryOptions = product['delivery_options'] as String? ?? 'Local pickup, farm delivery, or partner logistics';
    final description = product['description'] as String?
        ?? 'Fresh farm produce with quality grading and delivery support available.';
    final location = seller['region'] as String? ?? product['location'] as String? ?? 'Somalia';
    final sellerName = seller['first_name'] != null || seller['last_name'] != null
        ? '${seller['first_name'] ?? ''} ${seller['last_name'] ?? ''}'.trim()
        : product['seller_name'] as String? ?? 'Trusted Seller';
    final rating = product['rating']?.toString() ?? '4.8';
    final reviews = product['reviews']?.toString() ?? '120';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing details'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 260,
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                image: imageUrl != null && imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: imageUrl.startsWith('http')
                            ? NetworkImage(imageUrl)
                            : AssetImage(imageUrl) as ImageProvider,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imageUrl == null || imageUrl.isEmpty
                  ? Center(
                      child: Icon(
                        Icons.agriculture,
                        size: 72,
                        color: AppColors.primaryBlue.withOpacity(0.5),
                      ),
                    )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] as String? ?? 'Fresh product',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$price $unit / unit',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.secondaryGreen),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildBadge('Category: $category'),
                      _buildBadge('Verified seller'),
                      _buildBadge('Rating $rating ⭐ ($reviews reviews)'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('About this listing', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(description, style: const TextStyle(fontSize: 16, height: 1.5)),
                  const SizedBox(height: 24),
                  _buildDetailRow(Icons.location_on, 'Harvest location', location),
                  const SizedBox(height: 12),
                  _buildDetailRow(Icons.inventory, 'Min order', product['min_order'] as String? ?? '1 bag'),
                  const SizedBox(height: 12),
                  _buildDetailRow(Icons.local_shipping, 'Delivery options', deliveryOptions),
                  const SizedBox(height: 24),
                  Text('Seller information', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 26,
                                backgroundColor: AppColors.primaryBlue.withOpacity(0.15),
                              child: Icon(Icons.person, color: AppColors.primaryBlue),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(sellerName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text(location, style: TextStyle(color: AppColors.textMedium)),
                                  ],
                                ),
                              ),
                              Chip(label: const Text('Trusted')), 
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSellerStat('Orders', product['confirmed_orders']?.toString() ?? '85'),
                              _buildSellerStat('Response', product['response_rate']?.toString() ?? '98%'),
                              _buildSellerStat('Member', product['member_months']?.toString() ?? '18m'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.chat_bubble_outline),
                          label: const Text('Contact seller'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            minimumSize: const Size.fromHeight(52),
                          ),
                          onPressed: () async {
                            final sellerPhone = seller['phone'] as String?;
                            if (sellerPhone != null && sellerPhone.isNotEmpty) {
                              final message = Uri.encodeComponent('Hi $sellerName, I am interested in your listing for ${product['name']} on BaadiGoob.');
                              final url = Uri.parse('https://wa.me/$sellerPhone?text=$message');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.externalApplication);
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Could not launch WhatsApp.')),
                                  );
                                }
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('$sellerName has not provided a phone number. Contacting support...')),
                                );
                              }
                              final message = Uri.encodeComponent('Hi BaadiGoob Support, I need help contacting the seller for ${product['name']}.');
                              final url = Uri.parse('https://wa.me/252614195304?text=$message');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url, mode: LaunchMode.externalApplication);
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: _isOrderLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.shopping_cart_outlined),
                        label: const Text('Order'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGreen,
                          minimumSize: const Size(120, 52),
                        ),
                        onPressed: _isOrderLoading ? null : _showOrderDialog,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryBlue, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(value, style: TextStyle(color: AppColors.textMedium)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSellerStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: AppColors.textMedium)),
      ],
    );
  }
}
