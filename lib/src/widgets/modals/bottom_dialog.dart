import 'dart:math';

import 'package:flutter/material.dart' show MaterialLocalizations;
import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/dimens.dart';

/// A bottom dialog modal type that follows Infinity's design system.
/// Displays content in a sliding panel from the bottom edge of the screen.
class IBottomDialog extends WoltModalType {
  /// Creates a bottom dialog modal.
  ///
  /// [shapeBorder] Custom shape border for the dialog, defaults to rounded top
  /// corners
  /// [forceMaxHeight] Whether to force maximum height
  /// [barrierDismissible] Whether tapping the barrier dismisses the dialog
  const IBottomDialog({
    super.shapeBorder = _defaultShapeBorder,
    super.forceMaxHeight,
    super.barrierDismissible,
  }) : super(
          showDragHandle: false,
        );

  static const ShapeBorder _defaultShapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(InfinityDimens.borderRadius),
    ),
  );

  @override
  String routeLabel(final BuildContext context) {
    return MaterialLocalizations.of(context).dialogLabel;
  }

  @override
  BoxConstraints layoutModal(final Size availableSize) {
    return BoxConstraints(
      minWidth: availableSize.width,
      minHeight: InfinityDimens.dialogMinHeight,
      maxWidth: availableSize.width,
      maxHeight: availableSize.height * 0.8,
    );
  }

  @override
  Offset positionModal(
    final Size availableSize,
    final Size modalContentSize,
    final TextDirection textDirection,
  ) {
    return Offset(
      0,
      max(0.0, availableSize.height - modalContentSize.height),
    );
  }

  @override
  Widget decoratePageContent(
    final BuildContext context,
    final Widget child,
    final bool useSafeArea,
  ) {
    return useSafeArea
        ? SafeArea(
            top: false,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: child,
            ),
          )
        : child;
  }

  @override
  Widget decorateModal(
    final BuildContext context,
    final Widget modal,
    final bool useSafeArea,
  ) {
    return useSafeArea
        ? SafeArea(top: false, bottom: false, child: modal)
        : modal;
  }

  @override
  Widget buildTransitions(
    final BuildContext context,
    final Animation<double> animation,
    final Animation<double> secondaryAnimation,
    final Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      ),
      child: child,
    );
  }
}
