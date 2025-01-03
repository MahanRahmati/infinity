import 'package:flutter/widgets.dart';

import '../constants/dimens.dart';

/// A container widget that centers and constrains its child's width and
/// follows Infinity's design system.
class IBoundedBox extends StatelessWidget {
  /// Creates a bounded box that centers and constrains its child.
  ///
  /// [child] the widget to display inside the bounded box with constrained
  /// width.
  const IBoundedBox({
    super.key,
    this.child,
  });

  /// The widget to display inside the bounded box.
  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: InfinityDimens.iphone16ProMaxLandscapeWidth,
        ),
        child: child,
      ),
    );
  }
}
