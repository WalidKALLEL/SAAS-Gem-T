import 'package:flutter/material.dart';

class BizPulseDesignSystem {
  const BizPulseDesignSystem._();

  static const Color bizBlack = Color(0xFF071829);
  static const Color bizInk = Color(0xFF101828);
  static const Color bizGold = Color(0xFFD4A84B);
  static const Color goldSoft = Color(0xFFFFF8EC);
  static const Color trustBlue = Color(0xFF2878D0);
  static const Color blueSoft = Color(0xFFEEF4FB);
  static const Color progressGreen = Color(0xFF21A366);
  static const Color greenSoft = Color(0xFFEEF7F1);
  static const Color warningOrange = Color(0xFFF28C28);
  static const Color criticalRed = Color(0xFFD64545);
  static const Color innovationViolet = Color(0xFF7657D5);
  static const Color violetSoft = Color(0xFFF0EEF7);
  static const Color turquoise = Color(0xFF1FA6A1);
  static const Color turquoiseSoft = Color(0xFFEAF6F6);
  static const Color muted = Color(0xFF667085);
  static const Color line = Color(0xFFDDE5EF);
  static const Color lightBackground = Color(0xFFF5F8FC);
  static const Color lightWarmBackground = Color(0xFFFFF8EC);
  static const Color darkBackground = Color(0xFF08111F);
  static const Color darkSurface = Color(0xFF101B2D);
  static const Color darkSurfaceSoft = Color(0xFF182844);

  static const double radius = 8;
  static const double cardRadius = 12;
  static const double inputHeight = 46;
  static const double compactButtonHeight = 46;

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: trustBlue,
      brightness: Brightness.light,
      primary: trustBlue,
      secondary: bizGold,
      tertiary: innovationViolet,
      surface: Colors.white,
      background: lightBackground,
      onSurface: bizInk,
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: lightBackground,
      textTheme: _textTheme(bizInk, muted),
    );
  }

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7FA4D6),
      brightness: Brightness.dark,
      primary: const Color(0xFF7FA4D6),
      secondary: bizGold,
      tertiary: const Color(0xFFA89BD0),
      surface: darkSurface,
      background: darkBackground,
      onSurface: const Color(0xFFF3F7FF),
    );

    return _baseTheme(colorScheme).copyWith(
      scaffoldBackgroundColor: darkBackground,
      textTheme: _textTheme(const Color(0xFFF3F7FF), const Color(0xFFB9C6DD)),
    );
  }

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    final isDark = colorScheme.brightness == Brightness.dark;
    final outline = isDark ? const Color(0xFF2D426C) : line;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Roboto',
      splashFactory: InkSparkle.splashFactory,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? darkSurfaceSoft : Colors.white,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: TextStyle(
          color: isDark ? const Color(0xFF8394B6) : const Color(0xFF8A9AB3),
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(compactButtonHeight),
          backgroundColor: bizGold,
          foregroundColor: bizBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: 0,
          textStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(compactButtonHeight),
          side: BorderSide(color: outline),
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: colorScheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: BorderSide(color: outline),
        ),
      ),
    );
  }

  static TextTheme _textTheme(Color inkColor, Color mutedColor) {
    return TextTheme(
      headlineLarge: TextStyle(
        color: inkColor,
        fontSize: 30,
        height: 1.08,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: TextStyle(
        color: inkColor,
        fontSize: 24,
        height: 1.12,
        fontWeight: FontWeight.w800,
      ),
      titleLarge: TextStyle(
        color: inkColor,
        fontSize: 20,
        height: 1.18,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: TextStyle(
        color: inkColor,
        fontSize: 18,
        height: 1.20,
        fontWeight: FontWeight.w800,
      ),
      bodyLarge: TextStyle(
        color: inkColor,
        fontSize: 16,
        height: 1.38,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: mutedColor,
        fontSize: 14.5,
        height: 1.35,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        color: inkColor,
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
      labelMedium: TextStyle(
        color: mutedColor,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      labelSmall: TextStyle(
        color: mutedColor,
        fontSize: 12.5,
        letterSpacing: 0,
        fontWeight: FontWeight.w800,
      ),
    ).apply(fontFamily: 'Roboto');
  }

  static BoxDecoration pageBackground(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? const [
                Color(0xFF08111F),
                Color(0xFF0B1829),
                Color(0xFF101829),
              ]
            : const [
                Color(0xFFF2F6FB),
                Color(0xFFFBF7EF),
                Color(0xFFF3F5F8),
              ],
      ),
    );
  }

  static Color panelColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? darkSurface.withOpacity(0.96)
        : Colors.white.withOpacity(0.9);
  }

  static Color softPanelColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkSurfaceSoft : blueSoft;
  }

  static Color outlineColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF2D426C) : line;
  }

  static Color elevatedSurface(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkSurfaceSoft : Colors.white;
  }

  static List<Color> accentGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? const [Color(0xFF12243E), Color(0xFF252640), Color(0xFF113238)]
        : const [Color(0xFFEEF4FB), Color(0xFFF5EBD5), Color(0xFFEAF6F6)];
  }
}
