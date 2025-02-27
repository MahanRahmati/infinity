import 'dart:math';

import 'package:flutter/material.dart' show MaterialLocalizations;
import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '/src/constants/dimens.dart';

/// A side sheet modal type that follows Infinity's design system.
/// Displays content in a sliding panel from the end (right/left) edge of the
/// screen.
class ISideSheet extends WoltModalType {
  /// Creates a side sheet modal.
  ///
  /// [shapeBorder] Custom shape border for the sheet, defaults to rounded start
  /// corners
  /// [forceMaxHeight] Whether to force maximum height, defaults to true
  /// [dismissDirection] Direction for dismissal gesture, defaults to endToStart
  /// [barrierDismissible] Whether tapping the barrier dismisses the sheet
  const ISideSheet({
    super.shapeBorder = _defaultShapeBorder,
    super.forceMaxHeight = true,
    super.dismissDirection = WoltModalDismissDirection.endToStart,
    super.barrierDismissible,
  }) : super(showDragHandle: false);

  static const ShapeBorder _defaultShapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.only(
      topStart: Radius.circular(InfinityDimens.borderRadius),
      bottomStart: Radius.circular(InfinityDimens.borderRadius),
    ),
  );

  @override
  String routeLabel(final BuildContext context) {
    return MaterialLocalizations.of(context).drawerLabel;
  }

  @override
  BoxConstraints layoutModal(final Size availableSize) {
    final double width = min(
      InfinityDimens.sidebarWidth,
      max(0.0, availableSize.width - InfinityDimens.hugePadding),
    );
    return BoxConstraints(
      minWidth: width,
      maxWidth: width,
      minHeight: availableSize.height,
      maxHeight: availableSize.height,
    );
  }

  @override
  Offset positionModal(
    final Size availableSize,
    final Size modalContentSize,
    final TextDirection textDirection,
  ) {
    final double xOffset =
        textDirection == TextDirection.rtl
            ? 0.0
            : max(0.0, availableSize.width - modalContentSize.width);
    return Offset(xOffset, 0);
  }

  @override
  Widget decoratePageContent(
    final BuildContext context,
    final Widget child,
    final bool useSafeArea,
  ) {
    final TextDirection textDirection = Directionality.of(context);
    return useSafeArea
        ? SafeArea(
          left: textDirection != TextDirection.ltr,
          right: textDirection == TextDirection.ltr,
          child: child,
        )
        : child;
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
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return SlideTransition(
      position: Tween<Offset>(
        begin: isRtl ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: child,
    );
  }
}
