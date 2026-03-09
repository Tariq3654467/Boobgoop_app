import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const BaadiGoobApp());
}

class BaadiGoobApp extends StatelessWidget {
  const BaadiGoobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLocalizations()),
        ChangeNotifierProvider(create: (_) => AppState()..initializeAuth()),
      ],
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

