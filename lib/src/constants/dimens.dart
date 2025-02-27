import 'package:flutter/widgets.dart';

/// This class provides a dimension system for Infinity.
/// This class is not meant to be instantiated.
class InfinityDimens {
  InfinityDimens._();

  /// Base unit for all measurements
  static const double base = 8.0;

  /// Border thickness - 1.0
  static const double borderThickness = base * 0.125;

  /// Tiny padding - 2.0
  static const double tinyPadding = base * 0.25;

  /// Small padding - 4.0
  static const double smallPadding = base * 0.5;

  /// Standard padding - 8.0
  static const double padding = base;

  /// Small border radius - 8.0
  static const double smallBorderRadius = base;

  /// Header bar scroll under animation extent - 8.0
  static const double headerBarScrollUnderAnimationExtent = base;

  /// Medium padding - 12.0
  static const double mediumPadding = base * 1.5;

  /// Large padding - 16.0
  static const double largePadding = base * 2;

  /// Standard border radius - 16.0
  static const double borderRadius = base * 2;

  /// Huge padding - 32.0
  static const double hugePadding = base * 4;

  /// Height for tab bars - 40.0
  static const double tabbarHeight = base * 5;

  /// Height for header bars - 56.0
  static const double headerbarHeight = base * 7;

  /// Height for list items - 56.0
  static const double listItemHeight = base * 7;

  /// Height for calendar header - 56.0
  static const double calendarHeaderHeight = base * 7;

  /// Minimum height for dialog - 80.0
  static const double dialogMinHeight = base * 10;

  /// Size for status page icons - 96.0
  static const double statusPageIconSize = base * 12;

  /// Size for app icons - 96.0
  static const double appIconSize = base * 12;

  /// Width for popups - 280.0
  static const double popupWidth = base * 35;

  /// Minimum width for dialog - 280.0
  static const double dialogMinWidth = base * 35;

  /// Maximum height for calendar - 336.0
  static const double calendarMaxHeight = base * 42;

  /// Width for calendar - 448.0
  static const double calendarWidth = base * 56;

  /// Maximum width for dialog - 480.0
  static const double dialogMaxWidth = base * 60;

  /// Maximum width for bounded layouts - 720.0
  static const double boundedMaxWidth = base * 90;

  /// Sidebar width that defaults to iPhone 16 Pro Max width
  static const double sidebarWidth = iphone16ProMaxWidth;

  /// Standard iPhone 16 Pro Max width
  static const double iphone16ProMaxWidth = 440;

  /// iPhone 16 Pro Max width in landscape mode
  static const double iphone16ProMaxLandscapeWidth = 956;

  /// iPad Pro 13" width
  static const double ipadPro13Width = 1032;

  /// iPad Pro 13" width in landscape mode
  static const double ipadPro13LandscapeWidth = 1376;
}

/// Extensions for [BuildContext].
extension DimensExtensions on BuildContext {
  /// Checks if the current context width is extended.
  bool isExtended() {
    final double width = MediaQuery.of(this).size.width;
    return width >= InfinityDimens.ipadPro13Width;
  }

  /// Checks if the current context width is fully extended.
  bool isFullExtended() {
    final double width = MediaQuery.of(this).size.width;
    return width >= InfinityDimens.ipadPro13LandscapeWidth;
  }
}

/// Extensions for [double].
extension DimensDoubleExtensions on double {
  /// Checks if a specific width value is extended.
  bool isWidthExtended() {
    return this >= InfinityDimens.ipadPro13Width;
  }

  /// Checks if a specific width value is fully extended.
  bool isWidthFullExtended() {
    return this >= InfinityDimens.ipadPro13LandscapeWidth;
  }
}
