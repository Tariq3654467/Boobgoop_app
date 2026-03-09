import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SortingPackagingScreen extends StatelessWidget {
  const SortingPackagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sorting & Packaging'),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory, size: 80, color: Colors.blueGrey),
            const SizedBox(height: 16),
            const Text(
              'Manage incoming inventory sorting\nand outbound packaging processes.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barcode scanner placeholder')));
              },
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scan Package Barcode'),
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
