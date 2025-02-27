import 'package:flutter/widgets.dart';

import '/src/constants/dimens.dart';
import '/src/widgets/boxed_list.dart';
import '/src/widgets/list_item.dart';

/// A dialog widget for displaying developer credits that follows Infinity's
/// design system.
class CreditsDialog extends StatelessWidget {
  /// Creates a credits dialog.
  ///
  /// [developers] List of developer names to display
  const CreditsDialog({super.key, required this.developers});

  /// List of developers to display in the dialog.
  final List<String> developers;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IBoxedList(
            children:
                developers.map((final String developer) {
                  return IListItem(title: Text(developer));
                }).toList(),
          ),
          const SizedBox(height: InfinityDimens.padding),
        ],
      ),
    );
  }
}
