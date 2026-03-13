import '../theme/app_colors.dart';
import '../l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context).translations;
    final appState = Provider.of<AppState>(context);
    final user = appState.currentUser;
    final name = '${user?['first_name'] ?? translations.user} ${user?['last_name'] ?? ''}'.trim();

    return Scaffold(
      appBar: AppBar(
        title: Text(translations.profile),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(translations.accountSettings),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(translations.languagePreferences),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text(translations.privacySecurity),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: Text(translations.logout, style: const TextStyle(color: Colors.red)),
            onTap: () {
              appState.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
