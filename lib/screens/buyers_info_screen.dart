import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';

class BuyersInfoScreen extends StatelessWidget {
  const BuyersInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'For Buyers',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Order smarter, reduce shortages.'),
            Text(
              'Buyers get reliability. Consistent supply routines, bulk pricing support, and one point of contact for ordering and delivery coordination.',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 16),
            Text(
              'Order fruits and vegetables for your business (restaurants, hotels, supermarkets, caterers, and minimarkets) or for family occasions. We confirm availability, coordinate aggregation, and arrange delivery, so you save time and money, reduce waste, and avoid last-minute shortages.',
              style: TextStyle(color: AppColors.textMedium),
            ),
            SectionHeader(title: 'Who this is for', color: AppColors.textMedium),
            const Text('Hotels • Restaurants • Supermarkets • Minimarkets • Caterers • Institutions • Family occasions (weddings, Eid, gatherings, parties)'),
            
            const SectionHeader(title: 'What you get'),
            const BulletPoint(text: 'Reliable ordering routines (daily/weekly)'),
            const BulletPoint(text: 'Confirmed supply through coordinated aggregation'),
            const BulletPoint(text: 'One support channel (call centre + WhatsApp)'),
            const BulletPoint(text: 'Clear order tracking + digital receipts'),
            const BulletPoint(text: 'Bulk quote support for large volumes'),
            const BulletPoint(text: 'Reduced waste through better timing and handling'),
            
            const SectionHeader(title: 'Popular buyer use cases'),
            const BulletPoint(text: 'Weekly supply for restaurants and hotels'),
            const BulletPoint(text: 'Wholesale purchasing for supermarkets/minimarkets'),
            const BulletPoint(text: 'Event catering and seasonal spikes'),
            const BulletPoint(text: 'Institutional procurement routines'),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
              child: const Text('Register as a Buyer'),
            ),
          ],
        ),
      ),
    );
  }
}
