import 'package:flutter/widgets.dart';

import '../constants/colors.dart';
import '../constants/dimens.dart';
import '../constants/typography.dart';

/// A status page widget that follows Infinity's design system.
/// Displays a centered icon and/or title message.
class IStatusPage extends StatelessWidget {
  /// Creates an Infinity status page.
  ///
  /// [icon] optional icon to display above the title.
  /// [title] optional text message to display below the icon.
  const IStatusPage({
    super.key,
    this.icon,
    this.title,
  });

  /// The icon to display at the top of the status page.
  final IconData? icon;

  /// The text message to display below the icon.
  final String? title;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null)
            Icon(
              icon,
              size: InfinityDimens.statusPageIconSize,
              color: InfinityColors.getForegroundColor(context).dimmed(),
            ),
          if (icon != null && title != null)
            const SizedBox(height: InfinityDimens.largePadding),
          if (title != null)
            Text(
              title!,
              style: InfinityTypography.title2.copyWith(
                color: InfinityColors.getForegroundColor(context),
              ),
            ),
        ],
      ),
    );
  }
}
