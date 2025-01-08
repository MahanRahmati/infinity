import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter/widgets.dart';

import '/src/constants/dimens.dart';
import 'responsive_bottom_widget.dart';
import 'responsive_side_widget.dart';

/// Defines the possible responsive states for the scaffold layout.
enum ResponsiveStates {
  /// Compact layout with no side widgets
  collapsed,

  /// Layout with side widgets visible
  extended,

  /// Full width layout with maximum space for side widgets
  fullExtended,
}

/// Function signature for building responsive widgets based on the current
/// state.
typedef ResponsiveBuilder = Widget? Function(
  BuildContext context,
  ResponsiveStates state,
);

/// Function signature for building responsive header bars based on the current
/// state.
typedef ResponsiveHeaderBarBuilder = PreferredSizeWidget? Function(
  BuildContext context,
  ResponsiveStates state,
);

/// A responsive scaffold that adapts its layout based on screen size and
/// following Infinity's design system.
class IResponsiveScaffold extends StatefulWidget {
  /// Creates a responsive scaffold.
  ///
  /// [headerBarBuilder] Optional builder for the header bar that adapts to
  /// responsive states.
  /// [startWidgetBuilder] Optional builder for the start side widget.
  /// [childWidgetBuilder] Optional builder for the main content area.
  /// [endWidgetBuilder] Optional builder for the end side widget.
  /// [bottomWidgetBuilder] Optional builder for the bottom widget.
  /// [backgroundColor] Optional background color for the scaffold.
  const IResponsiveScaffold({
    super.key,
    this.headerBarBuilder,
    this.startWidgetBuilder,
    this.childWidgetBuilder,
    this.endWidgetBuilder,
    this.bottomWidgetBuilder,
    this.backgroundColor,
  });

  /// Builder for the header bar that adapts to different responsive states
  final ResponsiveHeaderBarBuilder? headerBarBuilder;

  /// Builder for the widget displayed at the start side
  final ResponsiveBuilder? startWidgetBuilder;

  /// Builder for the main content widget
  final ResponsiveBuilder? childWidgetBuilder;

  /// Builder for the widget displayed at the end side
  final ResponsiveBuilder? endWidgetBuilder;

  /// Builder for the widget displayed at the bottom
  final ResponsiveBuilder? bottomWidgetBuilder;

  /// Background color of the scaffold
  final Color? backgroundColor;

  @override
  State<IResponsiveScaffold> createState() => _IResponsiveScaffoldState();
}

class _IResponsiveScaffoldState extends State<IResponsiveScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late CurvedAnimation _startWidgetAnimation;
  late CurvedAnimation _endWidgetAnimation;
  late CurvedAnimation _bottomWidgetAnimation;

  bool controllerInitialized = false;
  bool extended = false;
  bool fullExtended = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 350),
      value: 0,
      vsync: this,
    );
    _startWidgetAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _endWidgetAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _bottomWidgetAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    extended = context.isExtended();
    fullExtended = context.isFullExtended();
    final AnimationStatus status = _controller.status;

    if (extended) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = extended ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ResponsiveStates _getState() {
    if (fullExtended) {
      return ResponsiveStates.fullExtended;
    }
    if (extended) {
      return ResponsiveStates.extended;
    }
    return ResponsiveStates.collapsed;
  }

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (final BuildContext context, final Widget? child) {
        return Scaffold(
          backgroundColor: widget.backgroundColor,
          appBar: widget.headerBarBuilder?.call(context, _getState()),
          body: Row(
            children: <Widget>[
              if (widget.startWidgetBuilder != null)
                ResponsiveSideWidget(
                  animation: _startWidgetAnimation,
                  child: widget.startWidgetBuilder!(context, _getState()),
                ),
              Expanded(
                child: widget.childWidgetBuilder?.call(context, _getState()) ??
                    const SizedBox(),
              ),
              if (widget.endWidgetBuilder != null)
                ResponsiveSideWidget(
                  animation: _endWidgetAnimation,
                  position: ResponsiveSideWidgetPosition.end,
                  child: widget.endWidgetBuilder!(context, _getState()),
                ),
            ],
          ),
          bottomNavigationBar: ResponsiveBottomWidget(
            animation: _bottomWidgetAnimation,
            child: widget.bottomWidgetBuilder?.call(context, _getState()),
          ),
        );
      },
    );
  }
}
