import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/dimens.dart';
import 'bottom_dialog.dart';
import 'bottom_sheet.dart';
import 'dialog.dart';
import 'dialog_header.dart';
import 'dialogs/about_dialog.dart';
import 'dialogs/credits_dialog.dart';
import 'dialogs/legal_dialog.dart';
import 'modal_sheet_page.dart';
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

/// Shows an about dialog modal with application information, credits and legal
/// sections.
/// Adapts between bottom dialog and centered dialog based on screen width.
///
/// The about dialog includes:
/// - Application name and version
/// - Optional application icon
/// - Optional website and issue reporting links
/// - Optional credits page with developer list
/// - Optional legal page with license text
///
/// [context] The build context used to show the modal
/// [applicationName] Name of the application to display
/// [version] Version string to show
/// [applicationIcon] Optional widget to display app icon
/// [developers] Optional list of developer names for credits page
/// [website] Optional website URL
/// [issueUrl] Optional URL for reporting issues
/// [license] Optional license text for legal page
void showAboutDialogModal({
  required final BuildContext context,
  required final String applicationName,
  required final String version,
  final Widget? applicationIcon,
  final List<String> developers = const <String>[],
  final String? website,
  final String? issueUrl,
  final String? license,
}) {
  const String aboutId = 'about-dialog-id';
  const String creditsId = 'credits-dialog-id';
  const String legalId = 'legal-dialog-id';

  const String creditsTitle = 'Credits';
  const String legalTitle = 'Legal';

  showDialogModal(
    context: context,
    pageListBuilder: (final BuildContext context) => <SliverWoltModalSheetPage>[
      IModalSheetPage(
        id: aboutId,
        isTopBarLayerAlwaysVisible: true,
        topBar: const IDialogHeader(),
        child: AboutDialog(
          applicationName: applicationName,
          version: version,
          applicationIcon: applicationIcon,
          website: website,
          issueUrl: issueUrl,
          developers: developers,
          creditsId: creditsId,
          creditsTitle: creditsTitle,
          license: license,
          legalId: legalId,
          legalTitle: legalTitle,
        ),
      ),
      if (developers.isNotEmpty)
        IModalSheetPage(
          id: creditsId,
          isTopBarLayerAlwaysVisible: true,
          topBar: const IDialogHeader(parentId: aboutId, title: creditsTitle),
          child: CreditsDialog(developers: developers),
        ),
      if (license != null && license.trim().isNotEmpty)
        IModalSheetPage(
          id: legalId,
          isTopBarLayerAlwaysVisible: true,
          topBar: const IDialogHeader(parentId: aboutId, title: legalTitle),
          child: LegalDialog(license: license),
        ),
    ],
  );
}
