import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/dimens.dart';

/// Shows a modal sheet that adapts between bottom sheet and side sheet based on
/// screen width.
///
/// [context] The build context used to show the modal.
/// [pageListBuilder] Builder function that returns the list of pages to display
/// in the modal.
/// [useSafeArea] Whether to respect device safe areas when positioning the
/// modal. Defaults to true.
///
/// The modal automatically switches between:
/// - Bottom sheet on narrow screens
/// - Side sheet on wide screens
///
/// Both sheet types use Infinity's design system border radius and styling.
void showModal({
  required final BuildContext context,
  required final WoltModalSheetPageListBuilder pageListBuilder,
  final bool useSafeArea = true,
}) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: pageListBuilder,
    useSafeArea: useSafeArea,
    modalTypeBuilder: (final BuildContext context) {
      if (context.isExtended()) {
        return const WoltSideSheetType(
          // ignore: avoid_redundant_argument_values
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(InfinityDimens.borderRadius),
              bottomStart: Radius.circular(InfinityDimens.borderRadius),
            ),
          ),
        );
      } else {
        return const WoltBottomSheetType(
          // ignore: avoid_redundant_argument_values
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(InfinityDimens.borderRadius),
            ),
          ),
        );
      }
    },
    onModalDismissedWithBarrierTap: () => Navigator.pop(context),
  );
}
