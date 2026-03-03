import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'About Us',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'About BaadiGoob AgroLink'),
            const Text(
              'BaadiGoob AgroLink is a produce marketplace built to strengthen Somali market systems, especially by improving market access and income for women farmers. We connect verified farmers and suppliers with serious buyers (restaurants, hotels, supermarkets, caterers, institutions, and families).',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Our operations team supports the full ordering process, from confirming availability and pricing to coordinating aggregation and delivery, so trade becomes more organised, transparent, and reliable.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SectionHeader(title: 'Our Mission'),
            const Text(
              'To expand market access for women farmers, reduce waste, and increase incomes through a trusted, tech-enabled produce marketplace.',
              style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.bold),
            ),
            const SectionHeader(title: 'Core Values'),
            const BulletPoint(text: 'Trust'),
            const BulletPoint(text: 'Coordination'),
            const BulletPoint(text: 'Fair Trade'),
            const BulletPoint(text: 'Reliability'),
            const BulletPoint(text: 'Women’s Economic Empowerment'),
            const BulletPoint(text: 'Local Growth'),
            const SizedBox(height: 40),
            Center(
              child: Image.asset('assets/logo/logo.png', width: 200),
            ),
          ],
        ),
      ),
    );
  }
}
