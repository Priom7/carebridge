import 'package:flutter/material.dart';

import 'carebridge_tokens.dart';

abstract final class CareBridgeTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: CareColors.blue,
      brightness: brightness,
      primary: isDark ? const Color(0xFF8FC0FF) : CareColors.blue,
      secondary: isDark ? const Color(0xFF6DDBD4) : CareColors.teal,
      error: isDark ? const Color(0xFFFFB4BA) : CareColors.red,
      surface: isDark ? CareColors.darkSurface : CareColors.white,
    );
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark
          ? CareColors.darkCanvas
          : CareColors.canvas,
      fontFamily: 'Arial',
    );

    final text = base.textTheme.copyWith(
      displaySmall: base.textTheme.displaySmall?.copyWith(
        fontSize: 36,
        height: 1.1,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      ),
      headlineMedium: base.textTheme.headlineMedium?.copyWith(
        fontSize: 28,
        height: 1.2,
        fontWeight: FontWeight.w800,
        letterSpacing: -.5,
      ),
      titleLarge: base.textTheme.titleLarge?.copyWith(
        fontSize: 20,
        height: 1.25,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: base.textTheme.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: base.textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(
        fontSize: 14,
        height: 1.45,
      ),
      labelLarge: base.textTheme.labelLarge?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );

    final outline = isDark ? const Color(0xFF34465E) : CareColors.line;
    return base.copyWith(
      textTheme: text,
      dividerColor: outline,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        titleTextStyle: text.titleLarge?.copyWith(color: scheme.onSurface),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CareRadius.md),
          side: BorderSide(color: outline),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: CareSpacing.md,
          vertical: CareSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CareRadius.sm),
          borderSide: BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CareRadius.sm),
          borderSide: BorderSide(color: outline),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? scheme.primary : outline,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: scheme.surface,
        indicatorColor: isDark ? const Color(0xFF153B66) : CareColors.blueSoft,
        labelTextStyle: WidgetStatePropertyAll(text.labelSmall),
      ),
    );
  }
}
