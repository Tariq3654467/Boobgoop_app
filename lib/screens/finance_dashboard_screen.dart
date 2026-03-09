import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class FinanceDashboardScreen extends StatelessWidget {
  const FinanceDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Dashboard'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance, size: 80, color: AppColors.primaryBlue.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              'Financial Overview',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            const Text('Track invoices, buyer payments,\nand seller payouts here.'),
          ],
        ),
      ),
    );
  }
}
