import 'package:flutter/widgets.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

/// A directional chevron icon widget that follows Infinity's design system.
class IListItemChevron extends StatelessWidget {
  /// Creates a directional chevron icon widget.
  const IListItemChevron({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
    return Icon(
      isRTL ? MingCuteIcons.mgc_left_line : MingCuteIcons.mgc_right_line,
    );
  }
}
