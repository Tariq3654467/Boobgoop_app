import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'q': 'Is BaadiGoob AgroLink a delivery company?',
        'a': 'We are a marketplace that coordinates aggregation and delivery through our operations team and partners.'
      },
      {
        'q': 'Can I buy small quantities?',
        'a': 'We focus on bulk and business orders. Minimum order varies by product.'
      },
      {
        'q': 'How do prices work?',
        'a': 'Prices can change based on season and supply. Your order is confirmed before dispatch.'
      },
      {
        'q': 'How do I request a bulk quote (RFQ)?',
        'a': 'Use “Request a Quote,” share product, quantity, delivery location, and preferred date—our team will respond with options.'
      },
      {
        'q': 'How do I become a seller?',
        'a': 'Register, share your products and location, and our team will verify and guide you through listing. Remember this platform is women farmers.'
      },
      {
        'q': 'What payment methods are supported?',
        'a': 'Options depend on location and order type. You’ll see available methods at checkout or during confirmation.'
      },
      {
        'q': 'How do I track my order?',
        'a': 'You receive status updates from confirmation to delivery.'
      },
    ];

    return BaseScreen(
      title: 'FAQ',
      body: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: faqs.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqs[index]['q']!,
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faqs[index]['a']!, style: const TextStyle(fontSize: 16)),
              ),
            ],
          );
        },
      ),
    );
  }
}
