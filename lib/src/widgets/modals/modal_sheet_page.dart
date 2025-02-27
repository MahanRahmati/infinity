import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/dimens.dart';

/// A modal sheet page that follows Infinity's design system.
class IModalSheetPage extends SliverWoltModalSheetPage {
  /// Creates a modal sheet page with a single child main content.
  ///
  /// [child] The main content widget to display in the modal page.
  /// [padding] Optional custom padding around the content.
  /// [id] Optional identifier for the page.
  /// [enableDrag] Whether the modal can be dragged.
  /// [forceMaxHeight] Forces the modal to take maximum available height.
  /// [resizeToAvoidBottomInset] Whether to resize when keyboard appears.
  /// [isTopBarLayerAlwaysVisible] Whether the top bar stays visible.
  /// [hasTopBarLayer] Whether to show the top bar.
  /// [scrollController] Optional scroll controller for the content.
  /// [topBar] Optional custom top bar widget.
  /// [useSafeArea] Whether to respect device safe areas.
  IModalSheetPage({
    required this.child,
    this.padding,
    super.id,
    super.enableDrag,
    super.forceMaxHeight = false,
    super.resizeToAvoidBottomInset,
    super.isTopBarLayerAlwaysVisible,
    super.hasTopBarLayer,
    super.scrollController,
    super.topBar,
    super.useSafeArea,
  }) : super(
         mainContentSliversBuilder: (final BuildContext context) {
           return <Widget>[
             SliverToBoxAdapter(
               child: Padding(
                 padding:
                     padding ??
                     const EdgeInsets.symmetric(
                       vertical: InfinityDimens.padding,
                     ),
                 child: child,
               ),
             ),
           ];
         },
       );

  /// A [Widget] that represents the main content displayed in the page.
  final Widget child;

  /// The padding to apply to the child.
  final EdgeInsets? padding;
}
