import 'package:flutter/widgets.dart';

import 'colors.dart';

/// This class provides a typography system for Infinity.
/// This class is not meant to be instantiated.
class AppTypography {
  AppTypography._();

  /// Default text style that serves as the foundation for all other styles
  static const TextStyle _default = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: InfinityColors.black,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );

  /// Largest display text style
  static TextStyle display1 = _default.copyWith(
    fontSize: 72,
    fontWeight: FontWeight.w300,
  );

  /// Large display text style
  static TextStyle display2 = _default.copyWith(
    fontSize: 54,
    fontWeight: FontWeight.w300,
  );

  /// Medium display text style
  static TextStyle display3 = _default.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  /// Primary title text style
  static TextStyle title1 = _default.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );

  /// Secondary title text style
  static TextStyle title2 = _default.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  /// Tertiary title text style
  static TextStyle title3 = _default.copyWith(
    fontSize: 21,
    fontWeight: FontWeight.w500,
  );

  /// Heading text style
  static TextStyle heading = _default.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  /// Standard body text style
  static TextStyle body = _default.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  /// Small heading text style - 14.76px
  static TextStyle captionHeading = _default.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// Caption text style
  static TextStyle caption = _default.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  /// Numeric text style with tabular figures for consistent number width
  static TextStyle numeric = _default.copyWith(
    fontFeatures: <FontFeature>[const FontFeature.tabularFigures()],
  );
}
