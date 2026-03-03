import 'package:flutter/material.dart';

/// Colors for the mobile app.  
///
/// Values are kept in sync with the web version by mirroring the
/// HSL tokens defined in `shared/theme_colors.json` and the
/// corresponding CSS variables in the web project (see
/// `somali-harvest(web)/src/index.css`).  Changing a value here
/// should be reflected in the shared JSON and the CSS file so the
/// two platforms stay connected.
///
/// We use [HSLColor] so that developers can copy the HSL tokens
/// directly from the web theme and avoid manual hex conversions.
class AppColors {
  // ---- Centralized Border Radius ----
  /// Border radius value matching web: 0.75rem = 12px
  static const double borderRadius = 12.0;
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusLarge = 16.0;

  // ---- Light Mode Colors ----
  
  // Primary/Secondary Colors
  static final Color primary =
      HSLColor.fromAHSL(1, 142, 0.40, 0.32).toColor();
  static final Color primaryForeground =
      HSLColor.fromAHSL(1, 40, 0.33, 0.96).toColor();
  static final Color secondary =
      HSLColor.fromAHSL(1, 36, 0.60, 0.52).toColor();
  static final Color secondaryForeground =
      HSLColor.fromAHSL(1, 40, 0.33, 0.96).toColor();
  static final Color accent =
      HSLColor.fromAHSL(1, 142, 0.30, 0.90).toColor();
  static final Color accentForeground =
      HSLColor.fromAHSL(1, 142, 0.40, 0.20).toColor();
  static final Color success =
      HSLColor.fromAHSL(1, 142, 0.50, 0.40).toColor();
  static final Color successForeground =
      HSLColor.fromAHSL(1, 0, 0, 1.0).toColor();

  // Card/Popover Colors
  static final Color card =
      HSLColor.fromAHSL(1, 40, 0.30, 0.98).toColor();
  static final Color cardForeground =
      HSLColor.fromAHSL(1, 30, 0.10, 0.15).toColor();
  static final Color popover =
      HSLColor.fromAHSL(1, 40, 0.30, 0.98).toColor();
  static final Color popoverForeground =
      HSLColor.fromAHSL(1, 30, 0.10, 0.15).toColor();

  // Muted Colors
  static final Color muted =
      HSLColor.fromAHSL(1, 40, 0.20, 0.90).toColor();
  static final Color mutedForeground =
      HSLColor.fromAHSL(1, 30, 0.08, 0.45).toColor();

  // Destructive/Error Colors
  static final Color destructive =
      HSLColor.fromAHSL(1, 0, 0.842, 0.602).toColor();
  static final Color destructiveForeground =
      HSLColor.fromAHSL(1, 210, 0.40, 0.98).toColor();

  // Border/Input/Ring Colors
  static final Color border =
      HSLColor.fromAHSL(1, 36, 0.20, 0.85).toColor();
  static final Color input =
      HSLColor.fromAHSL(1, 36, 0.20, 0.85).toColor();
  static final Color ring =
      HSLColor.fromAHSL(1, 142, 0.40, 0.32).toColor();

  // Neutral / background colors
  static final Color background =
      HSLColor.fromAHSL(1, 40, 0.33, 0.96).toColor();
  static final Color foreground =
      HSLColor.fromAHSL(1, 30, 0.10, 0.15).toColor();
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F9FA);
  static final Color lightGray =
      HSLColor.fromAHSL(1, 36, 0.20, 0.90).toColor();
  static final Color textDark =
      HSLColor.fromAHSL(1, 30, 10/100, 21/100).toColor();
  static final Color textMedium =
      HSLColor.fromAHSL(1, 30, 10/100, 45/100).toColor();
  static final Color textLight =
      HSLColor.fromAHSL(1, 30, 10/100, 70/100).toColor();

  // ---- Custom Tokens (from web) ----
  /// Earth color: 24 30% 30%
  static final Color earth =
      HSLColor.fromAHSL(1, 24, 0.30, 0.30).toColor();
  /// Earth light: 30 25% 70%
  static final Color earthLight =
      HSLColor.fromAHSL(1, 30, 0.25, 0.70).toColor();
  /// Harvest color: 42 85% 55%
  static final Color harvest =
      HSLColor.fromAHSL(1, 42, 0.85, 0.55).toColor();
  /// Sky color: 200 50% 55%
  static final Color sky =
      HSLColor.fromAHSL(1, 200, 0.50, 0.55).toColor();
  static const Color skyForeground = white;

  // ---- Gradients (from web) ----
  /// Gradient hero: linear-gradient(135deg, hsl(142 40% 32% / 0.9), hsl(142 25% 18% / 0.95))
  static const LinearGradient gradientHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xE61E4F52), // primary with opacity
      Color(0xF2243A2E), // dark green with opacity
    ],
  );
  
  /// Gradient warm: linear-gradient(135deg, hsl(36 60% 52%), hsl(42 85% 55%))
  static const LinearGradient gradientWarm = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE08A52), // secondary
      Color(0xFFE8C24D), // harvest
    ],
  );
  
  /// Gradient earth: linear-gradient(180deg, hsl(40 33% 96%), hsl(36 20% 90%))
  static const LinearGradient gradientEarth = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF5F3EF), // light background
      Color(0xFFE6E2DB), // muted
    ],
  );

  // ---- Shadows (from web) ----
  /// Shadow card: 0 4px 20px -4px hsl(30 10% 15% / 0.08)
  static List<BoxShadow> get shadowCard => [
    BoxShadow(
      color: HSLColor.fromAHSL(0.08, 30, 0.10, 0.15).toColor(),
      blurRadius: 20,
      offset: const Offset(0, 4),
      spreadRadius: -4,
    ),
  ];

  /// Shadow elevated: 0 12px 40px -8px hsl(30 10% 15% / 0.12)
  static List<BoxShadow> get shadowElevated => [
    BoxShadow(
      color: HSLColor.fromAHSL(0.12, 30, 0.10, 0.15).toColor(),
      blurRadius: 40,
      offset: const Offset(0, 12),
      spreadRadius: -8,
    ),
  ];

  // ---- Interaction colors ----
  static final Color hoverGray =
      HSLColor.fromAHSL(1, 36, 20/100, 85/100).toColor();
  static final Color error = destructive;
  static final Color warning =
      HSLColor.fromAHSL(1, 0, 0, 0).toColor(); // placeholder, web has no warning token

  // legacy aliases (kept for backward compatibility)
  static Color get primaryBlue => primary;
  static Color get accentOrange => accent;
  static Color get secondaryGreen => secondary;

  // ---- Dark mode token equivalents ----
  static final Color darkBackground =
      HSLColor.fromAHSL(1, 142, 0.15, 0.08).toColor();
  static final Color darkForeground =
      HSLColor.fromAHSL(1, 40, 0.20, 0.92).toColor();
  static final Color darkCard =
      HSLColor.fromAHSL(1, 142, 0.15, 0.12).toColor();
  static final Color darkCardForeground =
      HSLColor.fromAHSL(1, 40, 0.20, 0.92).toColor();
  static final Color darkPopover =
      HSLColor.fromAHSL(1, 142, 0.15, 0.12).toColor();
  static final Color darkPopoverForeground =
      HSLColor.fromAHSL(1, 40, 0.20, 0.92).toColor();
  static final Color darkPrimary =
      HSLColor.fromAHSL(1, 142, 0.40, 0.45).toColor();
  static final Color darkPrimaryForeground =
      HSLColor.fromAHSL(1, 142, 0.15, 0.08).toColor();
  static final Color darkSecondary =
      HSLColor.fromAHSL(1, 36, 0.50, 0.45).toColor();
  static final Color darkSecondaryForeground =
      HSLColor.fromAHSL(1, 40, 0.20, 0.92).toColor();
  static final Color darkMuted =
      HSLColor.fromAHSL(1, 142, 0.10, 0.18).toColor();
  static final Color darkMutedForeground =
      HSLColor.fromAHSL(1, 40, 0.10, 0.60).toColor();
  static final Color darkAccent =
      HSLColor.fromAHSL(1, 142, 0.20, 0.20).toColor();
  static final Color darkAccentForeground =
      HSLColor.fromAHSL(1, 142, 0.40, 0.70).toColor();
  static final Color darkDestructive =
      HSLColor.fromAHSL(1, 0, 0.628, 0.306).toColor();
  static final Color darkDestructiveForeground =
      HSLColor.fromAHSL(1, 210, 0.40, 0.98).toColor();
  static final Color darkBorder =
      HSLColor.fromAHSL(1, 142, 0.10, 0.22).toColor();
  static final Color darkInput =
      HSLColor.fromAHSL(1, 142, 0.10, 0.22).toColor();
  static final Color darkRing =
      HSLColor.fromAHSL(1, 142, 0.40, 0.45).toColor();
  static final Color darkSuccess = success;
  static final Color darkSuccessForeground = successForeground;
}
