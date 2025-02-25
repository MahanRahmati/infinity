import 'package:flutter/widgets.dart';

import '/src/constants/dimens.dart';
import 'squircle.dart';

/// An application icon widget that follows Infinity's design system.
class IApplicationIcon extends StatelessWidget {
  /// Creates an Infinity application icon.
  ///
  /// [child] the widget to display inside the icon.
  /// [size] optional size constraint for both width and height.
  IApplicationIcon(final Widget child, {super.key, this.size})
    : child = SizedBox.square(dimension: size, child: child);

  /// Creates an Infinity application icon from an asset image.
  ///
  /// [name] the asset image path to load.
  /// [size] optional size constraint for both width and height.
  IApplicationIcon.asset(final String name, {super.key, this.size})
    : child = Image.asset(name, width: size, height: size);

  /// Creates an Infinity application icon from a network image.
  ///
  /// [url] the network image URL to load.
  /// [size] optional size constraint for both width and height.
  IApplicationIcon.network(final String url, {super.key, this.size})
    : child = Image.network(url, width: size, height: size);

  /// The widget to display inside the rounded container.
  final Widget child;

  /// Optional size constraint applied to both width and height.
  final double? size;

  @override
  Widget build(final BuildContext context) {
    return SmoothClipRRect(
      borderRadius: BorderRadius.circular(InfinityDimens.borderRadius),
      child: child,
    );
  }
}
