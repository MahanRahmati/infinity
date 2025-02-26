import 'dart:ui' show Brightness, Color;

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
    final bool isDarkMode,
    final BackgroundType type,
  ) {
    switch (type) {
      case BackgroundType.window:
        return isDarkMode ? windowDarkBackground : windowLightBackground;
      case BackgroundType.headerbar:
        return isDarkMode ? headerbarDarkBackground : headerbarLightBackground;
      case BackgroundType.sidebar:
        return isDarkMode ? sidebarDarkBackground : sidebarLightBackground;
      case BackgroundType.card:
        return isDarkMode ? cardDarkBackground : cardLightBackground;
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
    final bool isDarkMode,
    final InteractionState state,
  ) {
    final double value = switch (state) {
      InteractionState.hover => _hover,
      InteractionState.focused => _focused,
      InteractionState.pressed => _pressed,
      InteractionState.disabled => _disabledOpacity,
    };
    return isDarkMode
        ? white.withTransparency(value)
        : black.withTransparency(value);
  }

  /// Returns the foreground color.
  static Color getForegroundColor(final bool isDarkMode) {
    return isDarkMode ? foregroundDarkColor : foregroundLightColor;
  }

  /// Returns the status color based on the [StatusType].
  static Color getStatusColor(final bool isDarkMode, final StatusType type) {
    switch (type) {
      case StatusType.success:
        return isDarkMode ? successDark : successLight;
      case StatusType.warning:
        return isDarkMode ? warningDark : warningLight;
      case StatusType.error:
        return isDarkMode ? destructiveDark : destructiveLight;
    }
  }

  /// Returns the base color for button backgrounds and borders
  static Color _getButtonBaseColor(
    final bool isDarkMode,
    final InteractionState? state,
    final int? elevation,
    final Color? color,
    final StatusType? statusType,
  ) {
    if (statusType != null) {
      final Color statusColor = getStatusColor(isDarkMode, statusType);
      return statusColor.withTransparency(
        state == InteractionState.disabled ? 0.08 : 0.15,
      );
    }

    if (color != null) {
      return color.withTransparency(isDarkMode ? 0.36 : 0.12);
    }

    final int e = elevation != null ? elevation * 10 : 0;
    return isDarkMode
        ? getDarkBackgroundColor(e, state)
        : getLightBackgroundColor(e, state);
  }

  /// Returns the button background color.
  static Color getButtonBackgroundColor(
    final bool isDarkMode,
    final InteractionState? state, {
    final int? elevation,
    final Color? color,
    final StatusType? statusType,
    final bool isTransparent = false,
  }) {
    Color bgColor = _getButtonBaseColor(
      isDarkMode,
      state,
      elevation,
      color,
      statusType,
    );

    if (statusType != null &&
        state != null &&
        state != InteractionState.disabled) {
      bgColor = getStateColor(bgColor, state);
    }

    if (isTransparent) {
      return switch (state) {
        InteractionState.hover => bgColor,
        InteractionState.focused => bgColor,
        InteractionState.pressed => bgColor,
        InteractionState.disabled => transparent,
        null => transparent,
      };
    }

    return bgColor;
  }

  /// Returns the button foreground color.
  static Color getButtonForegroundColor(
    final bool isDarkMode, {
    final InteractionState? state,
    final StatusType? statusType,
  }) {
    final Color fgColor = statusType != null
        ? getStatusColor(isDarkMode, statusType)
        : getForegroundColor(isDarkMode);
    return state == InteractionState.disabled ? fgColor.dimmed() : fgColor;
  }

  /// Calculates the alpha of the background color based on the
  /// [InteractionState].
  static int _getBackgroundAlphaValue(
    final int base,
    final int step,
    final int elevation,
    final InteractionState? state,
  ) {
    final int value = switch (state) {
      InteractionState.hover => base + (step * 1),
      InteractionState.focused => base + (step * 2),
      InteractionState.pressed => base + (step * 3),
      InteractionState.disabled => base + ((step - elevation) * -1),
      null => base + elevation,
    };
    return value;
  }

  /// Returns the dark background color based on the [InteractionState].
  static Color getDarkBackgroundColor(
    final int elevation,
    final InteractionState? state,
  ) {
    const int base = 25;
    final int step = 11 + elevation;
    final int value = _getBackgroundAlphaValue(base, step, elevation, state);
    return white.withAlpha(value);
  }

  /// Returns the light background color based on the [InteractionState].
  static Color getLightBackgroundColor(
    final int elevation,
    final InteractionState? state,
  ) {
    const int base = 20;
    final int step = 8 + elevation;
    final int value = _getBackgroundAlphaValue(base, step, elevation, state);
    return black.withAlpha(value);
  }

  /// Returns the button border color.
  static Color getButtonBorderColor(
    final bool isDarkMode,
    final InteractionState? state, {
    final int? elevation,
    final Color? color,
    final StatusType? statusType,
    final bool isTransparent = false,
  }) {
    if (state == InteractionState.focused) {
      final Color baseColor = _getButtonBaseColor(
        isDarkMode,
        state,
        elevation,
        color,
        statusType,
      );
      return getStateColor(baseColor, InteractionState.pressed);
    }

    return InfinityColors.transparent;
  }

  /// Returns the border color.
  static Color getBorderColor(final bool isDarkMode, {final Color? color}) {
    if (color != null) {
      return color.withTransparency(_borderOpacity);
    }
    return isDarkMode ? borderDarkBackground : borderLightBackground;
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
