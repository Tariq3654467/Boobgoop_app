import '../widgets/common_ui.dart';
import '../theme/app_colors.dart';
import '../l10n/app_localizations.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    final faqs = [
      {
        'q': translations.faqQ1,
        'a': translations.faqA1
      },
      {
        'q': translations.faqQ2,
        'a': translations.faqA2
      },
      {
        'q': translations.faqQ3,
        'a': translations.faqA3
      },
      {
        'q': translations.faqQ4,
        'a': translations.faqA4
      },
      {
        'q': translations.faqQ5,
        'a': translations.faqA5
      },
      {
        'q': translations.faqQ6,
        'a': translations.faqA6
      },
      {
        'q': translations.faqQ7,
        'a': translations.faqA7
      },
    ];

    return BaseScreen(
      title: translations.faqTitle,
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
