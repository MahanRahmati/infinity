import 'package:flutter/material.dart' show Theme;
import 'package:flutter/widgets.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';
import '/src/constants/typography.dart';
import '/src/utils/url_launcher.dart';
import '/src/widgets/boxed_list.dart';
import '/src/widgets/list_item.dart';
import '/src/widgets/list_item_chevron.dart';

/// A dialog widget for displaying application information that follows
/// Infinity's design system.
/// Shows app details, version, links and optional credits/legal sections.
class AboutDialog extends StatelessWidget {
  /// Creates an about dialog.
  ///
  /// [applicationIcon] Optional widget to display app icon
  /// [applicationName] Name of the application to display
  /// [version] Version string to show in badge
  /// [website] Optional website URL
  /// [issueUrl] Optional URL for reporting issues
  /// [developers] List of developer names for credits
  /// [creditsId] ID for credits page navigation
  /// [creditsTitle] Title for credits section
  /// [license] License text content
  /// [legalId] ID for legal page navigation
  /// [legalTitle] Title for legal section
  const AboutDialog({
    super.key,
    this.applicationIcon,
    required this.applicationName,
    required this.version,
    this.website,
    this.issueUrl,
    this.developers = const <String>[],
    this.creditsId,
    this.creditsTitle,
    this.license,
    this.legalId,
    this.legalTitle,
  });

  /// Optional widget to display app icon
  final Widget? applicationIcon;

  /// Name of the application to display
  final String applicationName;

  /// Version string to show in badge
  final String version;

  /// Optional website URL
  final String? website;

  /// Optional URL for reporting issues
  final String? issueUrl;

  /// List of developer names for credits
  final List<String> developers;

  /// ID for credits page navigation
  final Object? creditsId;

  /// Title for credits section
  final String? creditsTitle;

  /// License text content
  final String? license;

  /// ID for legal page navigation
  final Object? legalId;

  /// Title for legal section
  final String? legalTitle;

  @override
  Widget build(final BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    const String websiteTitle = 'Website';
    const String issueTitle = 'Report an issue';
    final bool showCredits =
        developers.isNotEmpty && creditsId != null && creditsTitle != null;
    final bool showLicense =
        license != null &&
        license!.trim().isNotEmpty &&
        legalId != null &&
        legalTitle != null;
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (applicationIcon != null) ...<Widget>[
            applicationIcon!,
            const SizedBox(height: InfinityDimens.mediumPadding),
          ],
          Text(applicationName, style: InfinityTypography.title2),
          const SizedBox(height: InfinityDimens.padding),
          DecoratedBox(
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: primary.withTransparency(0.15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: InfinityDimens.largePadding,
                vertical: InfinityDimens.smallPadding,
              ),
              child: Text(
                version,
                style: InfinityTypography.body.copyWith(color: primary),
              ),
            ),
          ),
          const SizedBox(height: InfinityDimens.padding),
          if (issueUrl != null || website != null)
            IBoxedList(
              children: <Widget>[
                if (website != null)
                  IListItem(
                    title: const Text(websiteTitle),
                    trailing: const Icon(MingCuteIcons.mgc_external_link_line),
                    onPressed: () => urlLauncher(website),
                  ),
                if (issueUrl != null)
                  IListItem(
                    title: const Text(issueTitle),
                    trailing: const Icon(MingCuteIcons.mgc_external_link_line),
                    onPressed: () => urlLauncher(issueUrl),
                  ),
              ],
            ),
          if (showCredits || showLicense)
            IBoxedList(
              children: <Widget>[
                if (showCredits)
                  IListItem(
                    title: Text(creditsTitle!),
                    trailing: const IListItemChevron(),
                    onPressed: () {
                      WoltModalSheet.of(context).showPageWithId(creditsId!);
                    },
                  ),
                if (showLicense)
                  IListItem(
                    title: Text(legalTitle!),
                    trailing: const IListItemChevron(),
                    onPressed: () {
                      WoltModalSheet.of(context).showPageWithId(legalId!);
                    },
                  ),
              ],
            ),
          SizedBox(
            height:
                (issueUrl != null ||
                        website != null ||
                        showCredits ||
                        showLicense)
                    ? 0
                    : InfinityDimens.padding,
          ),
        ],
      ),
    );
  }
}
