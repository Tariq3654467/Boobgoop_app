import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';

class SellersInfoScreen extends StatelessWidget {
  const SellersInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'For Sellers',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Get consistent buyers and faster sales.'),
            Text(
              'Sellers get market access. Reach serious buyers, receive clear orders, and sell faster—without chasing customers. BaadiGoob increases income and market access for women farmers.',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryGreen),
            ),
            const SizedBox(height: 16),
            const SectionHeader(title: 'What sellers get'),
            const BulletPoint(text: 'Access to active business buyers'),
            const BulletPoint(text: 'Simple product listing + availability updates'),
            const BulletPoint(text: 'Clear orders with quantities and delivery timing'),
            const BulletPoint(text: 'Support with aggregation and fulfilment coordination'),
            const BulletPoint(text: 'A performance record that builds trust and repeat orders'),
            
            const SectionHeader(title: 'Seller requirements'),
            const BulletPoint(text: 'Accurate product details (type, unit, price range)'),
            const BulletPoint(text: 'Ability to supply agreed volumes'),
            const BulletPoint(text: 'Basic packaging readiness (crates/sacks/bundles)'),
            const BulletPoint(text: 'Commitment to quality and honest grading'),
            
            const SectionHeader(title: 'How to become a seller'),
            _howToStep('1', 'Register'),
            _howToStep('2', 'Verification & onboarding'),
            _howToStep('3', 'List products + availability'),
            _howToStep('4', 'Receive orders and fulfil'),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryGreen,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Become a Seller'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _howToStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          CircleAvatar(radius: 12, child: Text(number)),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
