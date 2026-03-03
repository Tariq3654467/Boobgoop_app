import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';

class LogisticsScreen extends StatelessWidget {
  const LogisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Logistics',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Delivery you can plan around.'),
            Text(
              'Simple ordering. Coordinated fulfilment. Reliable delivery routines.',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 16),
            Text(
              'BaadiGoob AgroLink coordinates aggregation and delivery so buyers receive produce on agreed days and time windows.',
              style: TextStyle(color: AppColors.textMedium),
            ),
            const SectionHeader(title: 'Delivery features'),
            const BulletPoint(text: 'Delivery scheduling (time windows)'),
            const BulletPoint(text: 'Dispatch updates + proof of delivery'),
            const BulletPoint(text: 'Better handling through coordinated packing'),
            const BulletPoint(text: 'Support for bulk and institutional orders'),
            
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryBlue),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primaryBlue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Delivery fees, timing, and routes are confirmed during order confirmation.',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
