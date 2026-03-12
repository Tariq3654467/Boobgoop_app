import 'package:flutter/material.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Contact Us',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Get in Touch'),
            const Text(
              'We’d love to hear from you. Whether you’re a buyer looking to source fresh produce, a farmer/supplier interested in selling through BaadiGoob AgroLink, or a partner who wants to collaborate—reach out anytime.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _contactItem(
              Icons.web,
              'Website',
              'www.baadigoobagrolink.com',
              url: 'https://www.baadigoobagrolink.com',
            ),
            _contactItem(
              Icons.email,
              'Email',
              'info@baadigoobagrolink.com',
              url: 'mailto:info@baadigoobagrolink.com',
            ),
            _contactItem(
              Icons.phone,
              'Phone / WhatsApp',
              '+252 (0) 614195304',
              url: 'https://wa.me/252614195304',
            ),
            _contactItem(
              Icons.call,
              'Call Center',
              '2434',
              url: 'tel:+2522434',
            ),
            _contactItem(
              Icons.location_on,
              'Location',
              'KM5, Hodan District, Mogadishu, Somalia',
            ),

            const SectionHeader(title: 'Social Media'),
            const Text('Follow us and stay updated: @baadigoobonline'),
            Text(
              '#baadigoobagrolink',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 48),
            Center(
              child: Text(
                'Ready to partner with us?',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.primaryBlue),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Let’s connect farmers to markets—transparently and sustainably',
                textAlign: TextAlign.center,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactItem(
    IconData icon,
    String label,
    String value, {
    String? url,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: url != null ? () => _launchUrl(url) : null,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.textLight,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (url != null)
              Icon(Icons.open_in_new, color: AppColors.primaryBlue, size: 18),
          ],
        ),
      ),
    );
  }
}
