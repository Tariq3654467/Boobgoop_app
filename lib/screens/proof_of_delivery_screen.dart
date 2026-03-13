import 'package:baadigoob_agrolink/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProofOfDeliveryScreen extends StatefulWidget {
  const ProofOfDeliveryScreen({super.key});

  @override
  State<ProofOfDeliveryScreen> createState() => _ProofOfDeliveryScreenState();
}

class _ProofOfDeliveryScreenState extends State<ProofOfDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.pod),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt, size: 80, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                translations.uploadPODDesc,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(translations.cameraPending)));
                },
                icon: const Icon(Icons.add_a_photo),
                label: Text(translations.capturePOD),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
