import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
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
    final translations = AppLocalizations.of(context).translations;
    return BaseScreen(
      title: translations.contactUs,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: translations.getInTouch),
            Text(
              translations.contactDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            _contactItem(
              Icons.web,
              translations.website,
              'www.baadigoobagrolink.com',
              url: 'https://www.baadigoobagrolink.com',
            ),
            _contactItem(
              Icons.email,
              translations.email,
              'info@baadigoob.so',
              url: 'mailto:info@baadigoob.so',
            ),
            _contactItem(
              Icons.phone,
              translations.phoneWhatsApp,
              '+252 (0) 614195304',
              url: 'https://wa.me/252614195304',
            ),
            _contactItem(
              Icons.call,
              translations.callCenter,
              '2434',
              url: 'tel:+2522434',
            ),
            _contactItem(
              Icons.location_on,
              translations.location,
              '1st Floor, Hano Connect, TikTok Street, KM5, Hodan District, Mogadishu, Somalia',
            ),

            SectionHeader(title: translations.socialMedia),
            Text(translations.followUs),
            Text(
              '@baadigoobagrolink',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _socialMediaIcon(Icons.facebook, 'Facebook', 'https://www.facebook.com/share/1B5bgAwgtZ/'),
                _socialMediaIcon(Icons.camera_alt, 'Instagram', 'https://www.instagram.com/baadigoobagrolink'),
                _socialMediaIcon(Icons.chat, 'Twitter', 'https://x.com/baadigoobonline'),
                _socialMediaIcon(Icons.business, 'LinkedIn', 'https://www.linkedin.com/posts/baadigoobagrolink_yaanyada-iyo-faaiidooyinkeeda-yaanyadu-activity-7446889243743911936-XbvQ'),
                _socialMediaIcon(Icons.play_circle_fill, 'YouTube', 'https://youtube.com/@baadigoobonline2990?si=0v5_zl0p-UP7rmww'),
                _socialMediaIcon(Icons.music_note, 'TikTok', 'https://www.tiktok.com/@baadigoobagrolink'),
              ],
            ),

            const SizedBox(height: 48),
            Center(
              child: Text(
                translations.readyToPartner,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppColors.primaryBlue),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                translations.letConnectFarmers,
                textAlign: TextAlign.center,
                style: const TextStyle(fontStyle: FontStyle.italic),
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

  Widget _socialMediaIcon(IconData icon, String platform, String url) {
    return InkWell(
      onTap: () => _launchUrl(url),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primaryBlue, size: 24),
      ),
    );
  }
}
