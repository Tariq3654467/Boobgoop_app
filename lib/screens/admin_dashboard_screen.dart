import 'package:baadigoob_agrolink/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'market_prices_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.adminDashboard),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translations.systemOverview,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              translations.welcomeAdmin,
              style: TextStyle(color: AppColors.textMedium),
            ),
            const SizedBox(height: 32),
            
            // Price Management Section
            _buildSectionHeader(translations.marketPrices, Icons.price_change),
            Text(translations.manageDailyPrices),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MarketPricesScreen()),
                      );
                    },
                    icon: const Icon(Icons.visibility),
                    label: Text(translations.viewPrices),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to price update screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(translations.notImplemented)),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: Text(translations.updatePrices),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentOrange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // User Management Section
            _buildSectionHeader(translations.usersRoles, Icons.people),
            Text(translations.manageUsers),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(translations.notImplemented)),
                );
              },
              icon: const Icon(Icons.group),
              label: Text(translations.viewUsers),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Product Management Section
            _buildSectionHeader(translations.products, Icons.inventory),
            Text(translations.manageProducts),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(translations.notImplemented)),
                );
              },
              icon: const Icon(Icons.add_box),
              label: Text(translations.addProduct),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryBlue, size: 24),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
      ],
    );
  }
}
