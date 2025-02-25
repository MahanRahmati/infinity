import 'package:flutter/material.dart';

/// Extensions for [BuildContext] class.
extension InfinityBuildContextExtensions on BuildContext {
  /// Returns `true` if the current theme is dark.
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
