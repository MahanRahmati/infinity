import 'package:flutter/widgets.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';

/// A responsive bottom widget that animates in/out vertically from the bottom
/// following Infinity's design system.
class ResponsiveBottomWidget extends StatefulWidget {
  /// Creates a responsive bottom widget.
  ///
  /// [animation] Controls the appearance/disappearance of the widget.
  /// Value of 0.0 means fully visible, 1.0 means fully hidden.
  ///
  /// [child] The widget to display inside the responsive container.
  const ResponsiveBottomWidget({
    super.key,
    required this.animation,
    required this.child,
  });

  /// Animation that controls the visibility and position of the widget.
  final Animation<double> animation;

  /// The widget to display inside the responsive container.
  final Widget? child;

  @override
  State<ResponsiveBottomWidget> createState() => _ResponsiveBottomWidgetState();
}

class _ResponsiveBottomWidgetState extends State<ResponsiveBottomWidget> {
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 1),
  ).animate(
    CurvedAnimation(parent: widget.animation, curve: Curves.easeOutCubic),
  );

  late final Animation<double> heightAnimation = Tween<double>(
    begin: 1,
    end: 0,
  ).animate(
    CurvedAnimation(parent: widget.animation, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(final BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        heightFactor: heightAnimation.value,
        child: FractionalTranslation(
          translation: offsetAnimation.value,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: InfinityColors.getBackgroundColor(
                context,
                BackgroundType.headerbar,
              ),
              border: Border(
                top: BorderSide(
                  color: InfinityColors.getBorderColor(context),
                  // ignore: avoid_redundant_argument_values
                  width: InfinityDimens.borderThickness,
                ),
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
