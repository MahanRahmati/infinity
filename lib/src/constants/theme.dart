import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'colors.dart';
import 'typography.dart';

/// This class provides a theme system for the Infinity.
/// This class is not meant to be instantiated.
class InfinityTheme {
  InfinityTheme._();

  /// Creates a light theme for the application.
  static ThemeData light({
    Color? colorSchemeSeed,
  }) {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: colorSchemeSeed,
      scaffoldBackgroundColor: InfinityColors.windowLightBackground,
      splashFactory: NoSplash.splashFactory,
      textTheme: _textTheme(),
      pageTransitionsTheme: _pageTransitionsTheme(),
      appBarTheme: const AppBarTheme(
        color: InfinityColors.headerbarLightBackground,
        elevation: 0,
        shadowColor: InfinityColors.transparent,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        WoltModalSheetThemeData(
          topBarShadowColor: InfinityColors.transparent,
          topBarElevation: 0,
        ),
      ],
    );
  }

  /// Creates a dark theme for the application.
  static ThemeData dark({
    Color? colorSchemeSeed,
  }) {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorSchemeSeed: colorSchemeSeed,
      scaffoldBackgroundColor: InfinityColors.windowDarkBackground,
      splashFactory: NoSplash.splashFactory,
      textTheme: _textTheme(),
      pageTransitionsTheme: _pageTransitionsTheme(),
      appBarTheme: const AppBarTheme(
        color: InfinityColors.headerbarDarkBackground,
        elevation: 0,
        shadowColor: InfinityColors.transparent,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        WoltModalSheetThemeData(
          topBarShadowColor: InfinityColors.transparent,
          topBarElevation: 0,
        ),
      ],
    );
  }

  /// Configures the text theme for both light and dark modes.
  static TextTheme? _textTheme() {
    return TextTheme(
      displayLarge: AppTypography.title1,
      displayMedium: AppTypography.title2,
      displaySmall: AppTypography.title2,
      headlineLarge: AppTypography.title3,
      headlineMedium: AppTypography.heading,
      bodyLarge: AppTypography.body,
      bodyMedium: AppTypography.body,
      labelLarge: AppTypography.captionHeading,
      labelMedium: AppTypography.caption,
      labelSmall: AppTypography.caption.copyWith(fontSize: 12),
    );
  }

  /// Configures the page transitions for all supported platforms.
  static PageTransitionsTheme _pageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    );
  }
}
