import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/landing_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const BaadiGoobApp());
}

class BaadiGoobApp extends StatelessWidget {
  const BaadiGoobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppLocalizations(),
      child: Consumer<AppLocalizations>(
        builder: (context, localizations, child) {
          return MaterialApp(
            title: 'BaadiGoob AgroLink',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale: localizations.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('so'),
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.agriculture, size: 80, color: Color(0xFF1B4332)),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text('From Farm to Fork — Powered by Women'),
          ],
        ),
      ),
    );
  }
}
