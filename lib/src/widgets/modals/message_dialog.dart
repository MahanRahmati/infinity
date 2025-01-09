import 'package:flutter/widgets.dart';

import '/src/constants/dimens.dart';
import '/src/constants/typography.dart';
import '/src/widgets/button.dart';

/// A message dialog widget that follows Infinity's design system.
class IMessageDialog extends StatelessWidget {
  /// Creates an Infinity message dialog.
  ///
  /// [title] optional title text displayed at the top of the dialog.
  /// [description] optional description text displayed below the title.
  /// [actions] optional list of action buttons displayed above the close
  /// button.
  /// [closeText] text for the bottom close button, defaults to 'Cancel'.
  const IMessageDialog({
    super.key,
    this.title,
    this.description,
    this.actions,
    this.closeText = 'Cancel',
  });

  /// The title text displayed at the top of the dialog.
  final String? title;

  /// The description text displayed below the title.
  final String? description;

  /// List of action buttons displayed above the close button.
  final List<Widget>? actions;

  /// Text for the bottom close button.
  final String closeText;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: InfinityDimens.padding,
        top: InfinityDimens.padding,
        right: InfinityDimens.padding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title != null) ...<Widget>[
            Text(
              title!,
              style: InfinityTypography.title3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: InfinityDimens.largePadding),
          ],
          if (description != null) ...<Widget>[
            Text(
              description!,
              style: InfinityTypography.body,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: InfinityDimens.largePadding),
          ],
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (actions != null)
                ...actions!.map((final Widget action) => action),
              IButton.filled(
                onPressed: () => Navigator.pop(context),
                child: Text(closeText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
