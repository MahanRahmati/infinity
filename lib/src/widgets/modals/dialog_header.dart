import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/dimens.dart';
import '/src/constants/typography.dart';
import '/src/widgets/back_button.dart';
import '/src/widgets/close_button.dart';

/// A header widget for modal dialogs that follows Infinity's design system.
/// Displays a title with optional back button and required close button.
class IDialogHeader extends StatelessWidget {
  /// Creates a dialog header.
  ///
  /// [parentId] Optional ID of parent page to enable back navigation
  /// [title] Optional title text to display in the center
  const IDialogHeader({super.key, this.parentId, this.title});

  /// Optional ID of parent page to enable back navigation
  final Object? parentId;

  /// Optional title text to display in the center
  final String? title;

  @override
  Widget build(final BuildContext context) {
    final Widget leading = Padding(
      padding: const EdgeInsets.symmetric(horizontal: InfinityDimens.padding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (parentId != null)
            IBackButton(
              onPressed: () {
                WoltModalSheet.of(context).showPageWithId(parentId!);
              },
            ),
        ],
      ),
    );

    final Widget? middle =
        title != null
            ? Text(
              title!,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: InfinityTypography.heading,
            )
            : null;

    const Widget trailing = Padding(
      padding: EdgeInsets.symmetric(horizontal: InfinityDimens.padding),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[ICloseButton()],
      ),
    );

    return NavigationToolbar(
      leading: leading,
      middle: middle,
      trailing: trailing,
    );
  }
}
