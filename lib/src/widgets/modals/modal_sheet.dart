import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/dimens.dart';
import 'bottom_dialog.dart';
import 'bottom_sheet.dart';
import 'dialog.dart';
import 'side_sheet.dart';

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
/// Both sheet types use Infinity's design system.
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
      return context.isExtended() ? const ISideSheet() : const IBottomSheet();
    },
    onModalDismissedWithBarrierTap: () => Navigator.pop(context),
  );
}

/// Shows a dialog modal that adapts between bottom dialog and centered dialog
/// based on screen width.
///
/// [context] The build context used to show the modal.
/// [pageListBuilder] Builder function that returns the list of pages to display
/// in the modal.
/// [useSafeArea] Whether to respect device safe areas when positioning the
/// modal. Defaults to true.
///
/// The modal automatically switches between:
/// - Bottom dialog on narrow screens
/// - Centered dialog on wide screens
///
/// Both dialog types use Infinity's design system.
void showDialogModal({
  required final BuildContext context,
  required final WoltModalSheetPageListBuilder pageListBuilder,
  final bool useSafeArea = true,
}) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: pageListBuilder,
    useSafeArea: useSafeArea,
    modalTypeBuilder: (final BuildContext context) {
      return context.isExtended() ? const IDialog() : const IBottomDialog();
    },
    onModalDismissedWithBarrierTap: () => Navigator.pop(context),
  );
}
