import 'package:flutter/widgets.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';
import '/src/utils/extensions/build_context.dart';

/// A horizontal divider line that follows Infinity's design system.
class IDivider extends StatelessWidget {
  /// Creates an Infinity horizontal divider.
  ///
  /// [height] controls the extent of the divider.
  /// [indent] spacing before the divider's start.
  /// [endIndent] spacing after the divider's end.
  /// [color] optional custom color for the divider line.
  const IDivider({
    super.key,
    this.height,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
  });

  /// The divider's height extent.
  final double? height;

  /// The amount of empty space to the leading edge of the divider.
  final double indent;

  /// The amount of empty space to the trailing edge of the divider.
  final double endIndent;

  /// The color to use when painting the line.
  final Color? color;

  @override
  Widget build(final BuildContext context) {
    final bool isDarkMode = context.isDarkMode;
    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: InfinityDimens.borderThickness,
          margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: color ?? InfinityColors.getBorderColor(isDarkMode),
                // ignore: avoid_redundant_argument_values
                width: InfinityDimens.borderThickness,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A vertical divider line that follows Infinity's design system.
class IVerticalDivider extends StatelessWidget {
  /// Creates an Infinity vertical divider.
  ///
  /// [width] controls the extent of the divider.
  /// [indent] spacing before the divider's top.
  /// [endIndent] spacing after the divider's bottom.
  /// [color] optional custom color for the divider line.
  const IVerticalDivider({
    super.key,
    this.width,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
  });

  /// The divider's width.
  final double? width;

  /// The amount of empty space on top of the divider.
  final double indent;

  /// The amount of empty space under the divider.
  final double endIndent;

  /// The color to use when painting the line.
  final Color? color;

  @override
  Widget build(final BuildContext context) {
    final bool isDarkMode = context.isDarkMode;
    return SizedBox(
      width: width,
      child: Center(
        child: Container(
          width: InfinityDimens.borderThickness,
          margin: EdgeInsetsDirectional.only(top: indent, bottom: endIndent),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: color ?? InfinityColors.getBorderColor(isDarkMode),
                // ignore: avoid_redundant_argument_values
                width: InfinityDimens.borderThickness,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
