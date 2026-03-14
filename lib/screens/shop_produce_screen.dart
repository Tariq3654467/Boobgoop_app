import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';
import '../widgets/main_drawer.dart';
import '../l10n/app_localizations.dart';
import '../l10n/app_translations.dart';
import '../models/app_state.dart';

class ShopProduceScreen extends StatelessWidget {
  const ShopProduceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.shopProduce),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: translations.browseFreshProduce),
            Text(
              translations.browseProduceDesc,
              style: TextStyle(color: AppColors.textMedium),
            ),
            const SizedBox(height: 24),
            
            // Search & Filter Bar (Visual Placeholder)
            _searchBar(translations),
            const SizedBox(height: 16),
            _filterChips(translations),
            const SizedBox(height: 24),
            
            SectionHeader(title: translations.featuredCategories),
            _categoryGrid(translations),
            const SizedBox(height: 32),
            
            SectionHeader(title: translations.freshArrivals),
            _productItem(translations.productTomatoes, 'Standard', '10kg', translations.inStock, 'assets/images/tomatoes.png', translations),
            _productItem(translations.productMangoes, 'Premium', '5kg', translations.limited, 'assets/images/fresh-produce.jpg', translations),
            _productItem(translations.productPotatoes, 'Standard', '50kg', translations.inStock, 'assets/images/yellow_maize.png', translations),
            _productItem(translations.productWatermelon, 'Premium', '20kg', translations.limited, 'assets/images/fresh-produce.jpg', translations),
            _productItem(translations.productLemonLime, 'Standard', '5kg', translations.inStock, 'assets/images/vegetables.png', translations),
            _productItem(translations.productBanana, 'Standard', '20kg', translations.inStock, 'assets/images/Fresh_banana_gradeA.png', translations),
            
            const SizedBox(height: 24),
            Text(
              translations.finalConfirmationNote,
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.textLight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar(AppTranslations translations) {
    return TextField(
      decoration: InputDecoration(
        hintText: translations.searchProducts,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
      ),
    );
  }

  Widget _filterChips(AppTranslations translations) {
    final filters = [
      translations.filterCategory,
      translations.filterLocation,
      translations.filterPrice,
      translations.filterAvailability
    ];
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

  Widget _categoryGrid(AppTranslations translations) {
    final cats = [
      {'name': translations.categoryVegetables, 'icon': Icons.eco},
      {'name': translations.categoryFruits, 'icon': Icons.apple},
      {'name': translations.categoryGrains, 'icon': Icons.grain},
      {'name': translations.categoryHerbs, 'icon': Icons.spa},
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

  Widget _productItem(String name, String grade, String minOrder, String status, String image, AppTranslations translations) {
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
                  Text('${translations.gradeLabel}: $grade • Min: $minOrder', style: TextStyle(color: AppColors.textMedium)),
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
                          child: Text(translations.addToCart),
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
                          child: Text(translations.requestQuote, style: const TextStyle(fontSize: 12)),
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
      color: (status == 'In Stock' || status == AppLocalizations.of(context).translations.inStock) ? AppColors.secondary : AppColors.accent,
      borderRadius: BorderRadius.circular(AppColors.borderRadiusSmall),
      ),
      child: Text(
        status,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
