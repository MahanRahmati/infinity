import 'package:flutter/widgets.dart';

import '/src/constants/dimens.dart';
import '/src/constants/typography.dart';

/// A dialog widget for displaying legal text content that follows Infinity's
/// design system.
class LegalDialog extends StatelessWidget {
  /// Creates a legal dialog.
  ///
  /// [license] The legal text content to display
  const LegalDialog({
    super.key,
    required this.license,
  });

  final String license;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(InfinityDimens.largePadding),
        child: Text(
          license,
          style: InfinityTypography.body,
        ),
      ),
    );
  }
}
