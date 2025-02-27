import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

import '/src/constants/durations.dart';
import '/src/constants/interaction_state.dart';

/// A builder function that returns a widget based on the current interaction
typedef InteractionBuilder =
    Widget? Function(BuildContext context, InteractionState? state);

const double _scale = 0.95;

/// An interactive widget that handles user interactions following Infinity's
/// design system.
class Interaction extends StatefulWidget {
  /// Creates an Interaction widget.
  ///
  /// [focusNode] defines the node to use for the [Focus] and [Semantics]
  /// of this widget.
  /// [onFocusChange] is called whenever the focus changes.
  /// [autofocus] determines if this widget should focus itself on start.
  /// [useScale] determines if press animation is shown.
  /// [onPressed] and [onLongPress] control whether the widget is enabled.
  /// The [builder] callback is called whenever the interaction state changes.
  const Interaction({
    super.key,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.useScale = true,
    this.onPressed,
    this.onLongPress,
    this.builder,
  });

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether to use scale animation when the widget is pressed.
  final bool useScale;

  /// The callback that is called when the widget is tapped or otherwise
  /// activated.
  ///
  /// If [onPressed] and [onLongPress] callbacks are null, then the widget will
  /// be disabled.
  final VoidCallback? onPressed;

  /// If [onPressed] and [onLongPress] callbacks are null, then the widget will
  /// be disabled.
  final VoidCallback? onLongPress;

  /// The builder that is called to build the widget.
  final InteractionBuilder? builder;

  /// Whether the widget is enabled or disabled. Widgets are disabled by
  /// default. To enable a widget, set [onPressed] or [onLongPress] to a
  /// non-null value.
  bool get enabled => onPressed != null || onLongPress != null;

  @override
  State<Interaction> createState() => _InteractionState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty('enabled', value: enabled, ifFalse: 'disabled'),
    );
  }
}

class _InteractionState extends State<Interaction> {
  late bool _isFocused;
  late bool _isHovered;
  bool _isKeyboardActivated = false;

  @override
  void initState() {
    super.initState();
    _isFocused = false;
    _isHovered = false;
  }

  bool _isPressed = false;

  void _handleTapDown(final TapDownDetails event) {
    if (!_isPressed) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(final TapUpDetails event) {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTap([final Intent? _]) {
    if (widget.onPressed != null) {
      setState(() => _isKeyboardActivated = true);
      widget.onPressed!();
      context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
      Future<void>.delayed(InfinityDurations.short, () {
        if (mounted) {
          setState(() => _isKeyboardActivated = false);
        }
      });
    }
  }

  void _onShowFocusHighlight(final bool showHighlight) {
    setState(() => _isFocused = showHighlight);
  }

  void _onShowHoverHighlight(final bool showHighlight) {
    setState(() => _isHovered = showHighlight);
  }

  late final Map<Type, Action<Intent>> _actionMap = <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _handleTap),
  };

  InteractionState? _getInteractionState() {
    if (!widget.enabled) {
      return InteractionState.disabled;
    }
    if (_isPressed) {
      return InteractionState.pressed;
    }
    if (_isFocused) {
      return InteractionState.focused;
    }
    if (_isHovered) {
      return InteractionState.hover;
    }
    return null;
  }

  @override
  Widget build(final BuildContext context) {
    return MouseRegion(
      cursor:
          widget.enabled && kIsWeb
              ? SystemMouseCursors.click
              : MouseCursor.defer,
      child: FocusableActionDetector(
        actions: _actionMap,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        onFocusChange: widget.onFocusChange,
        onShowFocusHighlight: _onShowFocusHighlight,
        onShowHoverHighlight: _onShowHoverHighlight,
        enabled: widget.enabled,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: widget.enabled ? _handleTapDown : null,
          onTapUp: widget.enabled ? _handleTapUp : null,
          onTapCancel: widget.enabled ? _handleTapCancel : null,
          onTap: widget.onPressed,
          onLongPress: widget.onLongPress,
          child: AnimatedScale(
            scale:
                widget.useScale
                    ? (_isPressed || _isKeyboardActivated)
                        ? _scale
                        : 1.0
                    : 1.0,
            duration: InfinityDurations.short,
            child: widget.builder?.call(context, _getInteractionState()),
          ),
        ),
      ),
    );
  }
}
