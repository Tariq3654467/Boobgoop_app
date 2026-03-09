import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HubDashboardScreen extends StatelessWidget {
  const HubDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hub Dashboard'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2, size: 80, color: AppColors.primaryBlue.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              'Warehouse Management',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Text('Manage incoming sorting, packaging,\nand dispatch schedules here.'),
          ],
        ),
      ),
    );
  }
}
