import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DisputesScreen extends StatelessWidget {
  const DisputesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resolution & Disputes'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gavel, size: 80, color: Colors.red[300]),
            const SizedBox(height: 16),
            const Text(
              'Manage and resolve platform conflicts.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dispute flow pending')));
              },
              icon: const Icon(Icons.add_alert),
              label: const Text('Log New Dispute'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
