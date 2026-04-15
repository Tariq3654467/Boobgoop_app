import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Chat request sent to seller.')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        label: const Text('Order'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryGreen,
                          minimumSize: const Size(120, 52),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order request submitted.')),
                          );
                        },
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
