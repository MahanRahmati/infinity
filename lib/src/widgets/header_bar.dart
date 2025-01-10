import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';
import '/src/constants/typography.dart';
import 'back_button.dart';

/// A header bar widget that follows Infinity's design system.
class IHeaderBar extends StatefulWidget implements PreferredSizeWidget {
  /// Creates an Infinity header bar.
  ///
  /// [leading] optional widget displayed at the start of the header bar.
  /// [automaticallyImplyLeading] whether to automatically add a back button
  /// when applicable.
  /// [middle] optional widget displayed in the center of the header bar.
  /// [trailing] optional list of widgets displayed at the end of the header
  /// bar.
  /// [bottom] optional widget displayed below the main header bar content.
  const IHeaderBar({
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.middle,
    this.trailing,
    this.bottom,
    this.primary = true,
  });

  /// Widget displayed at the start of the header bar.
  final Widget? leading;

  /// Whether to automatically add a back button when applicable.
  final bool automaticallyImplyLeading;

  /// Widget displayed in the center of the header bar.
  final Widget? middle;

  /// List of widgets displayed at the end of the header bar.
  final List<Widget>? trailing;

  /// Widget displayed below the main header bar content.
  final PreferredSizeWidget? bottom;

  /// Whether this header bar is part of the primary content of the app.
  final bool primary;

  @override
  Size get preferredSize {
    final double bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(
      InfinityDimens.headerbarHeight +
          bottomHeight +
          InfinityDimens.borderThickness,
    );
  }

  @override
  State<IHeaderBar> createState() => _IHeaderBarState();
}

class _IHeaderBarState extends State<IHeaderBar> {
  ScrollNotificationObserverState? _scrollNotificationObserver;
  double _scrollAnimationValue = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollNotificationObserver?.removeListener(_handleScrollNotification);
    _scrollNotificationObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollNotificationObserver?.addListener(_handleScrollNotification);
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  void _handleScrollNotification(final ScrollNotification notification) {
    if (notification is ScrollUpdateNotification &&
        notification.depth == 0 &&
        notification.metrics.axis == Axis.vertical) {
      final ScrollMetrics metrics = notification.metrics;
      final double oldScrollAnimationValue = _scrollAnimationValue;
      double scrollExtent = 0.0;
      switch (metrics.axisDirection) {
        case AxisDirection.up:
          // Scroll view is reversed
          scrollExtent = metrics.extentAfter;
        case AxisDirection.down:
          scrollExtent = metrics.extentBefore;
        case AxisDirection.right:
        case AxisDirection.left:
          // Scrolled under is only supported in the vertical axis, and should
          // not be altered based on horizontal notifications of the same
          // predicate since it could be a 2D scroller.
          break;
      }

      if (scrollExtent > InfinityDimens.headerBarScrollUnderAnimationExtent &&
          oldScrollAnimationValue != 1.0) {
        setState(() {
          _scrollAnimationValue = 1.0;
        });
      } else if (scrollExtent <= 0 && oldScrollAnimationValue != 0.0) {
        setState(() {
          _scrollAnimationValue = 0.0;
        });
      }
    }
  }

  SystemUiOverlayStyle _systemOverlayStyleForBrightness(
    final Brightness brightness, [
    final Color? backgroundColor,
  ]) {
    final SystemUiOverlayStyle style = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
    // For backward compatibility, create an overlay style without system
    // navigation bar settings.
    return SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarBrightness: style.statusBarBrightness,
      statusBarIconBrightness: style.statusBarIconBrightness,
      systemStatusBarContrastEnforced: style.systemStatusBarContrastEnforced,
    );
  }

  @override
  Widget build(final BuildContext context) {
    final Color backgroundColor = InfinityColors.getBackgroundColor(
      context,
      BackgroundType.headerbar,
    );

    final Color windowBackgroundColor = InfinityColors.getBackgroundColor(
      context,
      BackgroundType.window,
    );

    final Color borderColor = InfinityColors.getBorderColor(context);

    final Border? effectiveBorder = Border.lerp(
      const Border(
        bottom: BorderSide(
          color: InfinityColors.transparent,
          // ignore: avoid_redundant_argument_values
          width: InfinityDimens.borderThickness,
        ),
      ),
      Border(
        bottom: BorderSide(
          color: borderColor,
          // ignore: avoid_redundant_argument_values
          width: InfinityDimens.borderThickness,
        ),
      ),
      _scrollAnimationValue,
    );

    final Color effectiveBackgroundColor = Color.lerp(
          windowBackgroundColor,
          backgroundColor,
          _scrollAnimationValue,
        ) ??
        backgroundColor;

    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    Widget? leading;
    if (widget.leading != null) {
      leading = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[widget.leading!],
      );
    } else {
      if (parentRoute?.impliesAppBarDismissal ?? false) {
        leading = const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[IBackButton()],
        );
      }
    }

    Widget? middle = widget.middle;
    if (middle != null) {
      middle = _IHeaderBarTitleBox(child: middle);

      middle = DefaultTextStyle(
        style: InfinityTypography.heading.copyWith(
          color: InfinityColors.getForegroundColor(context),
        ),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: middle,
      );
    }

    Widget? trailing;
    if (widget.trailing != null && widget.trailing!.isNotEmpty) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.trailing!,
      );
    }

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: middle,
      trailing: trailing,
    );

    // If the toolbar is allocated less than toolbarHeight make it
    // appear to scroll upwards within its shrinking container.
    Widget headerBar = Column(
      children: <Widget>[
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: InfinityDimens.headerbarHeight,
            ),
            child: toolbar,
          ),
        ),
        if (widget.bottom != null) widget.bottom!,
      ],
    );

    if (widget.primary) {
      headerBar = SafeArea(
        bottom: false,
        child: headerBar,
      );
    }

    headerBar = Align(
      alignment: Alignment.topCenter,
      child: headerBar,
    );

    final SystemUiOverlayStyle overlayStyle = _systemOverlayStyleForBrightness(
      backgroundColor.estimateBrightness(),
      InfinityColors.transparent,
    );

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: effectiveBorder,
            color: effectiveBackgroundColor,
          ),
          child: Semantics(
            explicitChildNodes: true,
            child: headerBar,
          ),
        ),
      ),
    );
  }
}

class _IHeaderBarTitleBox extends SingleChildRenderObjectWidget {
  const _IHeaderBarTitleBox({required Widget super.child});

  @override
  _RenderIHeaderBarTitleBox createRenderObject(final BuildContext context) {
    return _RenderIHeaderBarTitleBox(
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
    final BuildContext context,
    final _RenderIHeaderBarTitleBox renderObject,
  ) {
    renderObject.textDirection = Directionality.of(context);
  }
}

class _RenderIHeaderBarTitleBox extends RenderAligningShiftedBox {
  _RenderIHeaderBarTitleBox({
    super.textDirection,
  }) : super(alignment: Alignment.center);

  @override
  Size computeDryLayout(final BoxConstraints constraints) {
    final BoxConstraints innerConstraints = constraints.copyWith(
      maxHeight: double.infinity,
    );
    final Size childSize = child!.getDryLayout(innerConstraints);
    return constraints.constrain(childSize);
  }

  @override
  double? computeDryBaseline(
    covariant final BoxConstraints constraints,
    final TextBaseline baseline,
  ) {
    final BoxConstraints innerConstraints = constraints.copyWith(
      maxHeight: double.infinity,
    );
    final RenderBox? child = this.child;
    if (child == null) {
      return null;
    }
    final double? result = child.getDryBaseline(innerConstraints, baseline);
    if (result == null) {
      return null;
    }
    final Size childSize = child.getDryLayout(innerConstraints);
    return result +
        resolvedAlignment
            .alongOffset(getDryLayout(constraints) - childSize as Offset)
            .dy;
  }

  @override
  void performLayout() {
    final BoxConstraints innerConstraints = constraints.copyWith(
      maxHeight: double.infinity,
    );
    child!.layout(innerConstraints, parentUsesSize: true);
    size = constraints.constrain(child!.size);
    alignChild();
  }
}
