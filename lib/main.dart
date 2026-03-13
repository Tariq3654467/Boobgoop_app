import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/app_state.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://dhuktfedfhcunhqajken.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRodWt0ZmVkZmhjdW5ocWFqa2VuIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzMxMTgyOTEsImV4cCI6MjA4ODY5NDI5MX0.Bg4mOdSSx9mjxBBMCQSp9pMub90OzNsTaB0mCd8qYbY',
  );

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
            localizationsDelegates: [
              SomaliMaterialLocalizations.delegate,
              SomaliCupertinoLocalizations.delegate,
              SomaliWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
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

// Fallback delegates for Somali ('so') locale to reuse English localizations
class SomaliMaterialLocalizations extends DefaultMaterialLocalizations {
  const SomaliMaterialLocalizations();

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _SomaliMaterialLocalizationsDelegate();
}

class _SomaliMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _SomaliMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'so';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return const SomaliMaterialLocalizations();
  }

  @override
  bool shouldReload(_SomaliMaterialLocalizationsDelegate old) => false;
}

class SomaliCupertinoLocalizations extends DefaultCupertinoLocalizations {
  const SomaliCupertinoLocalizations();

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _SomaliCupertinoLocalizationsDelegate();
}

class _SomaliCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _SomaliCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'so';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    return const SomaliCupertinoLocalizations();
  }

  @override
  bool shouldReload(_SomaliCupertinoLocalizationsDelegate old) => false;
}

class SomaliWidgetsLocalizations extends DefaultWidgetsLocalizations {
  const SomaliWidgetsLocalizations();

  static const LocalizationsDelegate<WidgetsLocalizations> delegate =
      _SomaliWidgetsLocalizationsDelegate();
}

class _SomaliWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const _SomaliWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'so';

  @override
  Future<WidgetsLocalizations> load(Locale locale) async {
    return const SomaliWidgetsLocalizations();
  }

  @override
  bool shouldReload(_SomaliWidgetsLocalizationsDelegate old) => false;
}

