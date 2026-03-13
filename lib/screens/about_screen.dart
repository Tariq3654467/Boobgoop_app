import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return BaseScreen(
      title: translations.aboutUs,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: translations.aboutBaadigoob),
            Text(
              translations.aboutDescription1,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            Text(
              translations.aboutDescription2,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            SectionHeader(title: translations.ourMission),
            Text(
              translations.missionDescription,
              style: const TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.bold),
            ),
            SectionHeader(title: translations.coreValues),
            BulletPoint(text: translations.trust),
            BulletPoint(text: translations.coordination),
            BulletPoint(text: translations.fairTrade),
            BulletPoint(text: translations.reliability),
            BulletPoint(text: translations.womenEmpowerment),
            BulletPoint(text: translations.localGrowth),
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
