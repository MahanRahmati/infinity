import 'package:flutter/widgets.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import 'button.dart';

/// A close button widget that follows Infinity's design system.
class ICloseButton extends StatelessWidget {
  /// Creates an Infinity close button.
  ///
  /// [onPressed] optional callback when button is tapped. If not provided,
  /// defaults to Navigator.maybePop().
  const ICloseButton({
    super.key,
    this.onPressed,
  });

  /// The callback that is called when the button is tapped.
  /// If null, will attempt to pop the current route using Navigator.maybePop().
  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) {
    return IButton.icon(
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      icon: MingCuteIcons.mgc_close_line,
    );
  }
}
