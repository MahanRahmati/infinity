import 'package:flutter/material.dart' show Brightness, Theme;
import 'package:flutter/widgets.dart';

import 'interaction_state.dart';

/// The opacity of the border of the dialog.
const double _borderOpacity = 0.15;

/// The opacity of the dim overlay.
const double _dimOpacity = 0.55;

/// The opacity of disabled elements.
const double _disabledOpacity = 0.5;

/// The value of the [InteractionState] that represents a hovered state.
const double _hover = 0.03;

/// The value of the [InteractionState] that represents a focused state.
const double _focused = 0.05;

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

  /// Foreground color for light theme
  static const Color foregroundLightColor = Color(0xFF323232);

  /// Foreground color for dark theme
  static const Color foregroundDarkColor = white;

  /// Border color for light theme
  static const Color borderLightBackground = Color(0xFFE9E9E9);

  /// Border color for dark theme
  static const Color borderDarkBackground = Color(0xFF191919);

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

  /// Modal barrier color for light theme
  static const Color modalBarrierLight = Color(0x2B000000);

  /// Modal barrier color for dark theme
  static const Color modalBarrierDark = Color(0x7F000000);

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
      InteractionState.focused => _focused,
      InteractionState.pressed => _pressed,
      InteractionState.disabled => _disabledOpacity,
    };

    // For disabled state, use opacity
    if (state == InteractionState.disabled) {
      return baseColor.withTransparency(value);
    }

    // For light colors, darken and for dark colors, lighten by value.
    return baseColor.adjustLightness(
      baseColor.computeLuminance() > 0.5 ? -value : value,
    );
  }

  /// Returns a color with opacity based on the [InteractionState].
  static Color getStateOpacityColor(
    final BuildContext context,
    final InteractionState state,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double value = switch (state) {
      InteractionState.hover => _hover,
      InteractionState.focused => _focused,
      InteractionState.pressed => _pressed,
      InteractionState.disabled => _disabledOpacity,
    };

    return isDark
        ? white.withTransparency(value)
        : black.withTransparency(value);
  }

  /// Returns the foreground color.
  static Color getForegroundColor(
    final BuildContext context, {
    final Color? color,
  }) {
    final Brightness brightness =
        color?.estimateBrightness() ?? Theme.of(context).brightness;
    final bool isDark = brightness == Brightness.dark;
    return isDark ? foregroundDarkColor : foregroundLightColor;
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
    final BuildContext context,
    final InteractionState? state, {
    final int? elevation,
    final Color? color,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (color != null) {
      return isDark
          ? color.withTransparency(0.36)
          : color.withTransparency(0.12);
    }
    final int e = elevation != null ? elevation * 10 : 0;
    if (isDark) {
      const int base = 25;
      final int step = 11 + e;
      final int value = switch (state) {
        InteractionState.hover => base + (step * 1),
        InteractionState.focused => base + (step * 2),
        InteractionState.pressed => base + (step * 3),
        InteractionState.disabled => base + ((step - e) * -1),
        null => base + e,
      };
      return white.withAlpha(value);
    }

    const int base = 20;
    final int step = 8 + e;
    final int value = switch (state) {
      InteractionState.hover => base + (step * 1),
      InteractionState.focused => base + (step * 2),
      InteractionState.pressed => base + (step * 3),
      InteractionState.disabled => base + ((step - e) * -1),
      null => base + e,
    };

    return black.withAlpha(value);
  }

  /// Returns the button border color.
  static Color getButtonBorderColor(
    final Color baseColor,
    final InteractionState? state,
  ) {
    if (state == InteractionState.focused) {
      return getStateColor(baseColor, InteractionState.pressed);
    }
    return InfinityColors.transparent;
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
}

/// Defines the type of background surface in the Infinity.
enum BackgroundType {
  /// The background color for the entire window.
  window,

  /// The background color for the header bar.
  headerbar,

  /// The background color for the sidebar.
  sidebar,

  /// The background color for the content area.
  card,
}

/// Defines status types for displaying different states of operations or
/// feedback.
enum StatusType {
  /// Represents a successful state.
  success,

  /// Represents a warning state.
  warning,

  /// Represents an error state.
  error,
}

/// Extensions for [Color] class.
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
