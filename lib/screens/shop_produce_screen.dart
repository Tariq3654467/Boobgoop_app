import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';
import '../widgets/main_drawer.dart';

class ShopProduceScreen extends StatelessWidget {
  const ShopProduceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Produce'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Browse Fresh Produce'),
            Text(
              'Browse fresh produce from verified suppliers. Prices and availability may change daily—place your order to confirm stock and delivery schedule.',
              style: TextStyle(color: AppColors.textMedium),
            ),
            const SizedBox(height: 24),
            
            // Search & Filter Bar (Visual Placeholder)
            _searchBar(),
            const SizedBox(height: 16),
            _filterChips(),
            const SizedBox(height: 24),
            
            SectionHeader(title: 'Featured Categories'),
            _categoryGrid(),
            const SizedBox(height: 32),
            
            SectionHeader(title: 'Fresh Arrivals'),
            _productItem('Tomatoes', 'Standard', '10kg', 'In Stock', 'assets/images/tomatoes.png'),
            _productItem('Mangoes', 'Premium', '5kg', 'Limited', 'assets/images/fresh-produce.jpg'),
            _productItem('Potatoes', 'Standard', '50kg', 'In Stock', 'assets/images/yellow_maize.png'),
            _productItem('Watermelon', 'Premium', '20kg', 'Limited', 'assets/images/fresh-produce.jpg'),
            _productItem('Lemon/Lime', 'Standard', '5kg', 'In Stock', 'assets/images/vegetables.png'),
            _productItem('Banana', 'Standard', '20kg', 'In Stock', 'assets/images/Fresh_banana_gradeA.png'),
            
            const SizedBox(height: 24),
            Text(
              'Note: Final confirmation (availability, price, and delivery window) is completed before dispatch.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textLight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  Widget _filterChips() {
    final filters = ['Category', 'Location', 'Price', 'Availability'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) => Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Chip(
            label: Text(f),
            backgroundColor: AppColors.lightGray,
          ),
        )).toList(),
      ),
    );
  }

  Widget _categoryGrid() {
    final cats = [
      {'name': 'Vegetables', 'icon': Icons.eco},
      {'name': 'Fruits', 'icon': Icons.apple},
      {'name': 'Grains', 'icon': Icons.grain},
      {'name': 'Herbs', 'icon': Icons.spa},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: cats.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppColors.borderRadius),
            border: Border.all(color: AppColors.lightGray),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(cats[index]['icon'] as IconData, color: AppColors.secondary),
              const SizedBox(width: 8),
              Text(cats[index]['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }

  Widget _productItem(String name, String grade, String minOrder, String status, String image) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      StatusBadge(status),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Grade: $grade • Min: $minOrder', style: TextStyle(color: AppColors.textMedium)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(8),
                            side: BorderSide(color: AppColors.primary),
                          ),
                          child: const Text('Request Quote', style: TextStyle(fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;
  const StatusBadge(this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
      color: status == 'In Stock' ? AppColors.secondary : AppColors.accent,
      borderRadius: BorderRadius.circular(AppColors.borderRadiusSmall),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
