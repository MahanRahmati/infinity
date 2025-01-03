import 'package:flutter/material.dart' show Brightness, Theme;
import 'package:flutter/widgets.dart';

/// The opacity of the border of the dialog.
const double _borderOpacity = 0.15;

/// The opacity of the dim overlay.
const double _dimOpacity = 0.55;

/// The opacity of disabled elements.
const double _disabledOpacity = 0.5;

/// The value of the [InteractionState] that represents a hovered state.
const double _hover = 0.03;

/// The value of the [InteractionState] that represents a pressed state.
const double _pressed = 0.08;

/// This class provides a color system for the Infinity.
/// This class is not meant to be instantiated and contains only static members.
class InfinityColors {
  InfinityColors._();

  /// Pure black color
  static const Color black = Color(0xFF000000);

  /// Pure white color
  static const Color white = Color(0xFFFFFFFF);

  /// Fully transparent color
  static const Color transparent = Color(0x00000000);

  /// Window background color for light theme
  static const Color windowLightBackground = Color(0xFFFAFAFA);

  /// Window background color for dark theme
  static const Color windowDarkBackground = Color(0xFF242424);

  /// Headerbar background color for light theme
  static const Color headerbarLightBackground = white;

  /// Headerbar background color for dark theme
  static const Color headerbarDarkBackground = Color(0xFF363636);

  /// Sidebar background color for light theme
  static const Color sidebarLightBackground = Color(0xFFF5F5F5);

  /// Sidebar background color for dark theme
  static const Color sidebarDarkBackground = Color(0xFF2D2D2D);

  /// Card background color for light theme
  static const Color cardLightBackground = white;

  /// Card background color for dark theme
  static const Color cardDarkBackground = Color(0xFF363636);

  /// Border color for light theme
  static const Color borderLightBackground = Color(0xFFE9E9E9);

  /// Border color for dark theme
  static const Color borderDarkBackground = Color(0xFF171717);

  /// Destructive/error color for light theme
  static const Color destructiveLight = Color(0xFFC30000);

  /// Destructive/error color for dark theme
  static const Color destructiveDark = Color(0xFFFF938C);

  /// Success color for light theme
  static const Color successLight = Color(0xFF007c3d);

  /// Success color for dark theme
  static const Color successDark = Color(0xFF78e9ab);

  /// Warning color for light theme
  static const Color warningLight = Color(0xFF905400);

  /// Warning color for dark theme
  static const Color warningDark = Color(0xFFffc252);

  /// Returns the appropriate background color for the [BackgroundType].
  static Color getBackgroundColor(
    final BuildContext context,
    final BackgroundType type,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    switch (type) {
      case BackgroundType.window:
        return isDark ? windowDarkBackground : windowLightBackground;
      case BackgroundType.headerbar:
        return isDark ? headerbarDarkBackground : headerbarLightBackground;
      case BackgroundType.sidebar:
        return isDark ? sidebarDarkBackground : sidebarLightBackground;
      case BackgroundType.card:
        return isDark ? cardDarkBackground : cardLightBackground;
    }
  }

  /// Returns a color variant based on the [InteractionState].
  static Color getStateColor(
    final Color baseColor,
    final InteractionState state,
  ) {
    final double value = switch (state) {
      InteractionState.hover => _hover,
      InteractionState.pressed => _pressed,
    };

    // For light colors, darken and for dark colors, lighten by value.
    return baseColor.adjustLightness(
      baseColor.computeLuminance() > 0.5 ? -value : value,
    );
  }

  /// Calculates the elevation color based on the elevation level.
  static Color getElevationColor(
    final BuildContext context,
    final int level,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    // [windowDarkBackground] and [windowLightBackground]
    final int baseValue = isDark ? 0x24 : 0xFA;
    const int step = 20;
    final int diff = level * step;
    final int newValue = isDark ? baseValue + diff : baseValue - diff;
    return Color(0xFF000000 | (newValue << 16) | (newValue << 8) | newValue);
  }

  /// Returns the foreground color.
  static Color getForegroundColor(
    final BuildContext context, {
    final Brightness? brightness,
  }) {
    final bool isDark =
        (brightness ?? Theme.of(context).brightness) == Brightness.dark;
    return isDark ? white : getRgbColor(0, 0, 6, 0.8);
  }

  /// Returns the status color based on the [StatusType].
  static Color getStatusColor(
    final BuildContext context,
    final StatusType type,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    switch (type) {
      case StatusType.success:
        return isDark ? successDark : successLight;
      case StatusType.warning:
        return isDark ? warningDark : warningLight;
      case StatusType.error:
        return isDark ? destructiveDark : destructiveLight;
    }
  }

  /// Returns the button background color.
  static Color getButtonBackgroundColor(
    final BuildContext context, {
    final int? elavation,
    final Color? color,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (color != null) {
      return isDark
          ? color.withTransparency(0.36)
          : color.withTransparency(0.12);
    }
    if (elavation == null) {
      return isDark
          ? getRgbColor(255, 255, 255, 0.12)
          : getRgbColor(0, 0, 6, 0.12);
    }
    return getElevationColor(context, elavation);
  }

  /// Returns the border color.
  static Color getBorderColor(
    final BuildContext context, {
    final Color? color,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (color != null) {
      return color.withTransparency(_borderOpacity);
    }
    return isDark ? borderDarkBackground : borderLightBackground;
  }

  /// Create a color from RGB values.
  static Color getRgbColor(
    final int r,
    final int g,
    final int b,
    final double opacity,
  ) {
    final int alpha = (opacity * 255).round();
    return Color.fromARGB(alpha, r, g, b);
  }
}

/// Defines the type of background surface in the Infinity.
enum BackgroundType {
  window,
  headerbar,
  sidebar,
  card;
}

/// Represents different interaction states for UI elements.
enum InteractionState {
  hover,
  pressed;
}

/// Defines status types for displaying different states of operations or
/// feedback.
enum StatusType {
  success,
  warning,
  error,
}

extension ColorExtensions on Color {
  /// Returns a new color with reduced opacity to indicate a disabled state.
  Color disabled() {
    return withTransparency(_disabledOpacity);
  }

  /// Returns a new color with reduced opacity to create a dimmed effect.
  Color dimmed() {
    return withTransparency(_dimOpacity);
  }

  /// Creates a new color with the specified opacity while maintaining the
  /// original RGB values
  Color withTransparency(final double opacity) {
    final int alpha = (opacity * 255).round();
    return withAlpha(alpha);
  }

  /// Calculates whether a color should be considered light or dark based on
  /// its relative luminance value
  Brightness estimateBrightness() {
    final double relativeLuminance = computeLuminance();
    const double kThreshold = 0.0777;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold) {
      return Brightness.light;
    }
    return Brightness.dark;
  }

  /// Adjusts the lightness of a color by the specified value while maintaining
  /// its hue and saturation.
  Color adjustLightness(final double value) {
    return HSLColor.fromColor(this)
        .withLightness(
          (HSLColor.fromColor(this).lightness + value).clamp(0.0, 1.0),
        )
        .toColor();
  }
}
