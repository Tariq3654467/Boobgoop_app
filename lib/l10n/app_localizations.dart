import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_translations.dart';

class AppLocalizations extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  
  AppTranslations get translations => AppTranslations(_locale.languageCode);

  void setLocale(Locale locale) {
    if (locale.languageCode != 'en' && locale.languageCode != 'so') {
      return;
    }
    _locale = locale;
    notifyListeners();
  }

  void toggleLanguage() {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('so');
    } else {
      _locale = const Locale('en');
    }
    notifyListeners();
  }

  bool get isEnglish => _locale.languageCode == 'en';
  bool get isSomali => _locale.languageCode == 'so';

  // Static method to access localizations from context
  static AppLocalizations of(BuildContext context) {
    return Provider.of<AppLocalizations>(context, listen: false);
  }
}

// Helper function to get translations from context
AppTranslations getTranslations(BuildContext context) {
  return AppLocalizations.of(context).translations;
}

// Helper function to get localizations from context
AppLocalizations getLocalizations(BuildContext context) {
  return AppLocalizations.of(context);
}
