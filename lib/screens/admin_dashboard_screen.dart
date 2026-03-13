import 'package:baadigoob_agrolink/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.adminDashboard),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.admin_panel_settings, size: 80, color: AppColors.primaryBlue.withOpacity(0.5)),
            const SizedBox(height: 20),
            Text(
              translations.systemOverview,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              translations.welcomeAdmin,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
