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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dashboard_customize, size: 80, color: AppColors.primaryBlue.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              'Agent Operations',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Text('Monitor active farmers, outstanding orders,\nand active logistics/deliveries.'),
          ],
        ),
      ),
    );
  }
}
