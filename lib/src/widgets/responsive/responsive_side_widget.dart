import 'package:flutter/widgets.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';
import '/src/widgets/card.dart';

/// Position of the responsive side widget relative to its container.
enum ResponsiveSideWidgetPosition {
  /// Widget appears from the start
  start,

  /// Widget appears from the end
  end,
}

/// A responsive side widget that animates in/out from the start or end of its container
/// following Infinity's design system.
class ResponsiveSideWidget extends StatefulWidget {
  /// Creates a responsive side widget.
  ///
  /// [animation] Controls the appearance/disappearance of the widget.
  /// Value of 0.0 means fully hidden, 1.0 means fully visible.
  ///
  /// [child] Optional widget to display inside the responsive container.
  ///
  /// [position] Determines whether the widget appears from the start or end.
  /// Defaults to [ResponsiveSideWidgetPosition.start].
  const ResponsiveSideWidget({
    super.key,
    required this.animation,
    this.child,
    this.position = ResponsiveSideWidgetPosition.start,
  });

  /// Animation that controls the visibility and position of the widget.
  final Animation<double> animation;

  /// The widget to display inside the responsive container.
  final Widget? child;

  /// The position from which the widget animates.
  /// Use [ResponsiveSideWidgetPosition.start] for start-aligned animation or
  /// [ResponsiveSideWidgetPosition.end] for end-aligned animation.
  final ResponsiveSideWidgetPosition position;

  @override
  State<ResponsiveSideWidget> createState() => _ResponsiveSideWidgetState();
}

class _ResponsiveSideWidgetState extends State<ResponsiveSideWidget> {
  // The animations are only rebuilt by this method when the text
  // direction changes because this widget only depends on Directionality.
  late final bool ltr = Directionality.of(context) == TextDirection.ltr;
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: widget.position == ResponsiveSideWidgetPosition.start
        ? ltr
            ? const Offset(-1, 0)
            : const Offset(1, 0)
        : ltr
            ? const Offset(1, 0)
            : const Offset(-1, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(parent: widget.animation, curve: Curves.easeOutCubic),
  );

  late final Animation<double> widthAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(parent: widget.animation, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(final BuildContext context) {
    if (widget.child == null) {
      return const SizedBox();
    }
    return ClipRect(
      child: AnimatedBuilder(
        animation: widthAnimation,
        builder: (final BuildContext context, final Widget? child) {
          return Align(
            alignment: Alignment.topLeft,
            widthFactor: widthAnimation.value,
            child: FractionalTranslation(
              translation: offsetAnimation.value,
              child: SizedBox(
                width: InfinityDimens.sidebarWidth,
                child: ICard(
                  backgroundColor: InfinityColors.getBackgroundColor(
                    context,
                    BackgroundType.sidebar,
                  ),
                  padding: EdgeInsetsDirectional.only(
                    start: widget.position == ResponsiveSideWidgetPosition.end
                        ? 0
                        : InfinityDimens.largePadding,
                    top: InfinityDimens.largePadding,
                    end: widget.position == ResponsiveSideWidgetPosition.start
                        ? 0
                        : InfinityDimens.largePadding,
                    bottom: InfinityDimens.largePadding,
                  ),
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
