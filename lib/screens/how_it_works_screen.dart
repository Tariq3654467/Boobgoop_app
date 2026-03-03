import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'How It Works',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Simple ordering. Coordinated fulfilment. Reliable delivery.'),
            
            SectionHeader(title: 'For Buyers', color: AppColors.accentOrange),
            _stepRow('1', 'Shop or Request a Quote', 'Choose products or send an RFQ for bulk volumes and repeat routines.'),
            _stepRow('2', 'Order Confirmation', 'We confirm availability, grade, quantity, and delivery window before dispatch.'),
            _stepRow('3', 'Aggregation & Packing Coordination', 'Our team coordinates aggregation and packing to reduce spoilage and delays.'),
            _stepRow('4', 'Delivery & Proof of Delivery', 'Receive updates and confirmation when the order is delivered.'),
            
            const SizedBox(height: 24),
            
            SectionHeader(title: 'For Sellers', color: AppColors.secondaryGreen),
            _stepRow('1', 'Register & Share Your Supply', 'Products, location, volume, and availability schedule.'),
            _stepRow('2', 'Verification & Onboarding', 'We verify details to build buyer trust.'),
            _stepRow('3', 'Receive Orders', 'Clear quantities, timing, and fulfilment instructions.'),
            _stepRow('4', 'Grow with Consistency', 'Reliable performance increases buyer confidence and repeat orders.'),
            
            const SectionHeader(title: 'What BaadiGoob Coordinates'),
            const BulletPoint(text: 'Order confirmation'),
            const BulletPoint(text: 'Aggregation planning'),
            const BulletPoint(text: 'Packing coordination'),
            const BulletPoint(text: 'Delivery scheduling'),
            const BulletPoint(text: 'Customer support'),
          ],
        ),
      ),
    );
  }

  Widget _stepRow(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryBlue,
            radius: 14,
            child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description, style: TextStyle(fontSize: 15, color: AppColors.textMedium)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
