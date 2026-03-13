import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';
import '../l10n/app_localizations.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    return BaseScreen(
      title: translations.howItWorks,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: translations.howItWorksFooter),
            
            SectionHeader(title: translations.howItWorksForBuyers, color: AppColors.accentOrange),
            _stepRow('1', translations.buyerStep1Title, translations.buyerStep1Desc),
            _stepRow('2', translations.buyerStep2Title, translations.buyerStep2Desc),
            _stepRow('3', translations.buyerStep3Title, translations.buyerStep3Desc),
            _stepRow('4', translations.buyerStep4Title, translations.buyerStep4Desc),
            
            const SizedBox(height: 24),
            
            SectionHeader(title: translations.howItWorksForSellers, color: AppColors.secondaryGreen),
            _stepRow('1', translations.sellerStep1Title, translations.sellerStep1Desc),
            _stepRow('2', translations.sellerStep2Title, translations.sellerStep2Desc),
            _stepRow('3', translations.sellerStep3Title, translations.sellerStep3Desc),
            _stepRow('4', translations.sellerStep4Title, translations.sellerStep4Desc),
            
            SectionHeader(title: translations.whatBaadiGoobCoordinates),
            BulletPoint(text: translations.orderConfirmation),
            BulletPoint(text: translations.aggregationPlanning),
            BulletPoint(text: translations.packingCoordination),
            BulletPoint(text: translations.deliveryScheduling),
            BulletPoint(text: translations.customerSupport),
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
