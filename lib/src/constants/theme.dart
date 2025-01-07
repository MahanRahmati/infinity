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
    final Color? colorSchemeSeed,
  }) {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: colorSchemeSeed,
      scaffoldBackgroundColor: InfinityColors.windowLightBackground,
      splashFactory: NoSplash.splashFactory,
      textTheme: _textTheme(InfinityColors.foregroundLightColor),
      pageTransitionsTheme: _pageTransitionsTheme(),
      appBarTheme: const AppBarTheme(
        color: InfinityColors.headerbarLightBackground,
        elevation: 0,
        shadowColor: InfinityColors.transparent,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        WoltModalSheetThemeData(
          backgroundColor: InfinityColors.windowLightBackground,
          topBarShadowColor: InfinityColors.transparent,
          topBarElevation: 0,
          surfaceTintColor: InfinityColors.transparent,
        ),
      ],
    );
  }

  /// Creates a dark theme for the application.
  static ThemeData dark({
    final Color? colorSchemeSeed,
  }) {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorSchemeSeed: colorSchemeSeed,
      scaffoldBackgroundColor: InfinityColors.windowDarkBackground,
      splashFactory: NoSplash.splashFactory,
      textTheme: _textTheme(InfinityColors.foregroundDarkColor),
      pageTransitionsTheme: _pageTransitionsTheme(),
      appBarTheme: const AppBarTheme(
        color: InfinityColors.headerbarDarkBackground,
        elevation: 0,
        shadowColor: InfinityColors.transparent,
      ),
      extensions: const <ThemeExtension<dynamic>>[
        WoltModalSheetThemeData(
          backgroundColor: InfinityColors.windowDarkBackground,
          topBarShadowColor: InfinityColors.transparent,
          topBarElevation: 0,
          surfaceTintColor: InfinityColors.transparent,
        ),
      ],
    );
  }

  /// Configures the text theme for both light and dark modes.
  static TextTheme? _textTheme(final Color color) {
    return TextTheme(
      displayLarge: InfinityTypography.title1.copyWith(color: color),
      displayMedium: InfinityTypography.title2.copyWith(color: color),
      displaySmall: InfinityTypography.title2.copyWith(color: color),
      headlineLarge: InfinityTypography.title3.copyWith(color: color),
      headlineMedium: InfinityTypography.heading.copyWith(color: color),
      bodyLarge: InfinityTypography.body.copyWith(color: color),
      bodyMedium: InfinityTypography.body.copyWith(color: color),
      labelLarge: InfinityTypography.captionHeading.copyWith(color: color),
      labelMedium: InfinityTypography.caption.copyWith(color: color),
      labelSmall: InfinityTypography.caption.copyWith(color: color),
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
