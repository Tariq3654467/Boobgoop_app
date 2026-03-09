import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings, size: 80, color: AppColors.primaryBlue.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              'System Overview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Text('Welcome to the BaadiGoob Admin Panel.\nOverview metrics will load here.'),
          ],
        ),
      ),
    );
  }
}
