import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';

class QualityScreen extends StatelessWidget {
  const QualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Quality & Trust',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Trust through simple standards.'),
            Text(
              'Visual grading. Coordinated handling. Reliable packaging.',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryGreen),
            ),
            const SizedBox(height: 16),
            Text(
              'We use simple grading (Standard/Premium) and handling standards to reduce disputes and waste. Buyers receive clear expectations, and sellers establish a performance record.',
              style: TextStyle(color: AppColors.textMedium),
            ),
            const SectionHeader(title: 'Quality checks include'),
            const BulletPoint(text: 'Visual grading (freshness, size, damage)'),
            const BulletPoint(text: 'Packaging checks (crates/sacks/bundles)'),
            const BulletPoint(text: 'Order confirmation before dispatch'),
            
            const SectionHeader(title: 'Quality & claims'),
            const Text(
              'If there’s a quality issue, report it promptly with photos/video and your order number. Our team will review and respond based on the agreed grade and delivery condition.',
              style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
