import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/dimens.dart';

/// A centered dialog modal type that follows Infinity's design system.
/// Displays content in a centered panel with fade and scale animations.
class IDialog extends WoltModalType {
  /// Creates a centered dialog modal.
  ///
  /// [shapeBorder] Custom shape border for the dialog, defaults to rounded
  /// corners
  /// [forceMaxHeight] Whether to force maximum height
  /// [barrierDismissible] Whether tapping the barrier dismisses the dialog
  const IDialog({
    super.shapeBorder = _defaultShapeBorder,
    super.forceMaxHeight,
    super.barrierDismissible,
  }) : super(showDragHandle: false);

  static const ShapeBorder _defaultShapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(InfinityDimens.borderRadius),
    ),
  );

  @override
  String routeLabel(final BuildContext context) {
    return MaterialLocalizations.of(context).dialogLabel;
  }

  @override
  BoxConstraints layoutModal(final Size availableSize) {
    return BoxConstraints(
      minWidth: InfinityDimens.dialogMinWidth,
      maxWidth: InfinityDimens.dialogMaxWidth,
      minHeight: InfinityDimens.dialogMinHeight,
      maxHeight: availableSize.height * 0.8,
    );
  }

  @override
  Offset positionModal(
    final Size availableSize,
    final Size modalContentSize,
    final TextDirection textDirection,
  ) {
    final double xOffset = max(
      0.0,
      (availableSize.width - modalContentSize.width) / 2,
    );
    final double yOffset = max(
      0.0,
      (availableSize.height - modalContentSize.height) / 2,
    );
    return Offset(xOffset, yOffset);
  }

  @override
  Widget decoratePageContent(
    final BuildContext context,
    final Widget child,
    final bool useSafeArea,
  ) {
    return child;
  }

  @override
  Widget decorateModal(
    final BuildContext context,
    final Widget modal,
    final bool useSafeArea,
  ) {
    return modal;
  }

  @override
  Widget buildTransitions(
    final BuildContext context,
    final Animation<double> animation,
    final Animation<double> secondaryAnimation,
    final Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        ),
        child: child,
      ),
    );
  }
}
