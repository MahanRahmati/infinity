import 'package:flutter/widgets.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import 'button.dart';

/// A back button widget that follows Infinity's design system.
class IBackButton extends StatelessWidget {
  /// Creates an Infinity back button.
  ///
  /// [onPressed] optional callback when button is tapped. If not provided,
  /// defaults to Navigator.maybePop().
  const IBackButton({
    super.key,
    this.onPressed,
  });

  /// The callback that is called when the button is tapped.
  /// If null, will attempt to pop the current route using Navigator.maybePop().
  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
    return IButton.icon(
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      icon: isRTL ? MingCuteIcons.mgc_right_line : MingCuteIcons.mgc_left_line,
    );
  }
}
