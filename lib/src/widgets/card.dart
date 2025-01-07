import 'package:flutter/widgets.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';
import 'squircle.dart';

/// A customizable card widget that follows Infinity's design system.
class ICard extends StatelessWidget {
  /// Creates an Infinity card.
  ///
  /// [backgroundColor] optional custom background color for the card.
  /// [padding] spacing around the card's outer edge, defaults to zero.
  /// [margin] spacing around the card's inner content, defaults to zero.
  /// [child] the widget to display inside the card.
  const ICard({
    super.key,
    this.backgroundColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.child,
  });

  /// The background color of the card.
  final Color? backgroundColor;

  /// The padding around the card's outer edge.
  final EdgeInsetsGeometry padding;

  /// The margin around the card's inner content.
  final EdgeInsetsGeometry margin;

  /// The widget to display inside the card.
  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    if (child == null) {
      return const SizedBox.shrink();
    }

    final Color bg = backgroundColor ??
        InfinityColors.getBackgroundColor(
          context,
          BackgroundType.card,
        );
    final Color borderColor = InfinityColors.getBorderColor(
      context,
      color: backgroundColor,
    );
    return Padding(
      padding: padding,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: bg,
          shape: SmoothRectangleBorder(
            borderRadius: BorderRadius.circular(InfinityDimens.borderRadius),
            side: BorderSide(
              color: borderColor,
              // ignore: avoid_redundant_argument_values
              width: InfinityDimens.borderThickness,
            ),
          ),
        ),
        child: Padding(
          padding: margin,
          child: Padding(
            padding: const EdgeInsets.all(InfinityDimens.borderThickness),
            child: SmoothClipRRect(
              borderRadius: BorderRadius.circular(
                InfinityDimens.borderRadius - InfinityDimens.borderThickness,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
