import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class OpsDashboardScreen extends StatelessWidget {
  const OpsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations Dashboard'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/fresh-produce.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
                const Positioned(
                  bottom: 24,
                  left: 24,
                  child: Text(
                    'Agent Operations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Operational Management',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Monitor active farmers, manage outstanding orders, and coordinate regional logistics.',
                    style: TextStyle(color: AppColors.textMedium),
                  ),
                  const SizedBox(height: 32),
                  _buildDashboardOption(
                    context,
                    'Farmer Directory',
                    'Manage verified regional producers',
                    Icons.people_outline,
                  ),
                  const SizedBox(height: 16),
                  _buildDashboardOption(
                    context,
                    'Active Deliveries',
                    'Real-time tracking of logistics',
                    Icons.map_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildDashboardOption(
                    context,
                    'Regional Pricing',
                    'Set local market price benchmarks',
                    Icons.monetization_on_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardOption(BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
          child: Icon(icon, color: AppColors.primaryBlue, size: 28),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle, style: TextStyle(color: AppColors.textMedium, fontSize: 13)),
        ),
        trailing: Icon(Icons.chevron_right, color: AppColors.textLight),
        onTap: () {},
      ),
    );
  }
}
