import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.card,
        onPrimary: AppColors.primaryForeground,
        onSecondary: AppColors.secondaryForeground,
        onSurface: AppColors.cardForeground,
        error: AppColors.destructive,
        onError: AppColors.destructiveForeground,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _buildTextTheme(Brightness.light),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryForeground,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primaryForeground,
          textStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppColors.borderRadius),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.input,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
          borderSide: BorderSide(color: AppColors.ring, width: 2),
        ),
      ),
    );
  }

  /// dark theme using the tokens defined in [AppColors]
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.darkPrimary,
        primary: AppColors.darkPrimary,
        secondary: AppColors.darkSecondary,
        tertiary: AppColors.darkAccent,
        surface: AppColors.darkCard,
        onPrimary: AppColors.darkPrimaryForeground,
        onSecondary: AppColors.darkSecondaryForeground,
        onSurface: AppColors.darkCardForeground,
        error: AppColors.darkDestructive,
        onError: AppColors.darkDestructiveForeground,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _buildTextTheme(Brightness.dark),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkPrimaryForeground,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkPrimaryForeground,
          textStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppColors.borderRadius),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkInput,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppColors.borderRadius),
          borderSide: BorderSide(color: AppColors.darkRing, width: 2),
        ),
      ),
    );
  }

  /// Build text theme with web fonts: Playfair Display for headings, DM Sans for body
  static TextTheme _buildTextTheme(Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color foreground = isDark ? AppColors.darkForeground : AppColors.foreground;
    final Color mutedForeground = isDark ? AppColors.darkMutedForeground : AppColors.mutedForeground;

    return TextTheme(
      // Display styles - Playfair Display (headings)
      displayLarge: GoogleFonts.playfairDisplay(
        fontWeight: FontWeight.bold,
        fontSize: 57,
        color: foreground,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontWeight: FontWeight.bold,
        fontSize: 45,
        color: foreground,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: foreground,
      ),
      // Headline styles - Playfair Display
      headlineLarge: GoogleFonts.playfairDisplay(
        fontWeight: FontWeight.w600,
        fontSize: 32,
        color: foreground,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontWeight: FontWeight.w600,
        fontSize: 28,
        color: foreground,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        color: foreground,
      ),
      // Title styles - DM Sans
      titleLarge: GoogleFonts.dmSans(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        color: foreground,
      ),
      titleMedium: GoogleFonts.dmSans(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: foreground,
      ),
      titleSmall: GoogleFonts.dmSans(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: foreground,
      ),
      // Body styles - DM Sans
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 16,
        color: foreground,
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        color: mutedForeground,
      ),
      bodySmall: GoogleFonts.dmSans(
        fontSize: 12,
        color: mutedForeground,
      ),
      // Label styles - DM Sans
      labelLarge: GoogleFonts.dmSans(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: foreground,
      ),
      labelMedium: GoogleFonts.dmSans(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: foreground,
      ),
      labelSmall: GoogleFonts.dmSans(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        color: mutedForeground,
      ),
    );
  }
}
