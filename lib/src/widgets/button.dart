import 'package:flutter/widgets.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';
import '/src/constants/interaction_state.dart';
import '/src/constants/typography.dart';
import 'interaction.dart';
import 'squircle.dart';

/// A customizable button widget that follows Infinity's design system.
class IButton extends StatelessWidget {
  /// Creates an Infinity button.
  ///
  /// [child] optional widget to display inside the button, typically a
  /// Text widget.
  /// [focusNode] defines the focus behavior for keyboard navigation.
  /// [onFocusChange] called when button focus changes.
  /// [autofocus] whether button should focus itself when first displayed.
  /// [alignment] positions the child within the button, defaults to center.
  /// [backgroundColor] optional custom background color.
  /// [borderRadius] optional custom border radius.
  /// [elavation] optional custom elevation level.
  /// [statusType] optional custom status type.
  /// [padding] spacing around the button's outer edge.
  /// [margin] spacing around the button's inner content.
  /// [onPressed] callback when button is tapped.
  /// [onLongPress] callback when button is long pressed.
  const IButton({
    super.key,
    this.child,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.borderRadius,
    this.elavation,
    this.statusType,
    this.padding,
    this.margin,
    this.onPressed,
    this.onLongPress,
  });

  /// Creates an Infinity button with an icon.
  ///
  /// [icon] optional icon to display inside the button.
  /// [focusNode] defines the focus behavior for keyboard navigation.
  /// [onFocusChange] called when button focus changes.
  /// [autofocus] whether button should focus itself when first displayed.
  /// [alignment] positions the child within the button, defaults to center.
  /// [backgroundColor] optional custom background color.
  /// [elavation] optional custom elevation level.
  /// [statusType] optional custom status type.
  /// [padding] spacing around the button's outer edge.
  /// [onPressed] callback when button is tapped.
  /// [onLongPress] callback when button is long pressed.
  IButton.icon({
    super.key,
    required final IconData icon,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.elavation,
    this.statusType,
    this.padding,
    this.onPressed,
    this.onLongPress,
  })  : child = Icon(icon),
        margin = const EdgeInsets.all(InfinityDimens.padding),
        borderRadius = InfinityDimens.smallBorderRadius;

  /// Creates an Infinity button with text.
  ///
  /// [text] text to display inside the button.
  /// [focusNode] defines the focus behavior for keyboard navigation.
  /// [onFocusChange] called when button focus changes.
  /// [autofocus] whether button should focus itself when first displayed.
  /// [alignment] positions the child within the button, defaults to center.
  /// [backgroundColor] optional custom background color.
  /// [borderRadius] optional custom border radius.
  /// [elavation] optional custom elevation level.
  /// [statusType] optional custom status type.
  /// [padding] spacing around the button's outer edge.
  /// [onPressed] callback when button is tapped.
  /// [onLongPress] callback when button is long pressed.
  IButton.text({
    super.key,
    required final String text,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.borderRadius,
    this.elavation,
    this.statusType,
    this.padding,
    this.onPressed,
    this.onLongPress,
  })  : child = Text(text),
        margin = const EdgeInsets.symmetric(
          vertical: InfinityDimens.padding,
          horizontal: InfinityDimens.mediumPadding,
        );

  /// Creates an Infinity button with optional leading icon, text and trailing
  /// icon.
  ///
  /// [leadingIcon] optional icon displayed before the text.
  /// [text] text to display in the middle of the button.
  /// [trailingIcon] optional icon displayed after the text.
  /// [focusNode] defines the focus behavior for keyboard navigation.
  /// [onFocusChange] called when button focus changes.
  /// [autofocus] whether button should focus itself when first displayed.
  /// [alignment] positions the child within the button, defaults to center.
  /// [backgroundColor] optional custom background color.
  /// [borderRadius] optional custom border radius.
  /// [elavation] optional custom elevation level.
  /// [statusType] optional custom status type.
  /// [padding] spacing around the button's outer edge.
  /// [onPressed] callback when button is tapped.
  /// [onLongPress] callback when button is long pressed.
  IButton.compound({
    super.key,
    final IconData? leadingIcon,
    required final String text,
    final IconData? trailingIcon,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.borderRadius,
    this.elavation,
    this.statusType,
    this.padding,
    this.onPressed,
    this.onLongPress,
  })  : child = Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (leadingIcon != null) ...<Widget>[
              Icon(leadingIcon),
              const SizedBox(width: InfinityDimens.smallPadding),
            ],
            Text(text),
            if (trailingIcon != null) ...<Widget>[
              const SizedBox(width: InfinityDimens.smallPadding),
              Icon(trailingIcon),
            ],
          ],
        ),
        margin = const EdgeInsets.symmetric(
          vertical: InfinityDimens.padding,
          horizontal: InfinityDimens.mediumPadding,
        );

  /// Creates a pill-shaped Infinity button.
  ///
  /// [child] optional widget to display inside the button, typically a
  /// Text widget.
  /// [focusNode] defines the focus behavior for keyboard navigation.
  /// [onFocusChange] called when button focus changes.
  /// [autofocus] whether button should focus itself when first displayed.
  /// [alignment] positions the child within the button, defaults to center.
  /// [backgroundColor] optional custom background color.
  /// [elavation] optional custom elevation level.
  /// [statusType] optional custom status type.
  /// [padding] spacing around the button's outer edge.
  /// [onPressed] callback when button is tapped.
  /// [onLongPress] callback when button is long pressed.
  const IButton.pill({
    super.key,
    this.child,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.elavation,
    this.statusType,
    this.padding,
    this.onPressed,
    this.onLongPress,
  })  : borderRadius = double.infinity,
        margin = const EdgeInsets.symmetric(
          vertical: InfinityDimens.mediumPadding,
          horizontal: InfinityDimens.largePadding,
        );

  /// Creates a filled Infinity button.
  ///
  /// [child] optional widget to display inside the button, typically a
  /// Text widget.
  /// [focusNode] defines the focus behavior for keyboard navigation.
  /// [onFocusChange] called when button focus changes.
  /// [autofocus] whether button should focus itself when first displayed.
  /// [alignment] positions the child within the button, defaults to center.
  /// [backgroundColor] optional custom background color.
  /// [elavation] optional custom elevation level.
  /// [statusType] optional custom status type.
  /// [padding] spacing around the button's outer edge.
  /// [onPressed] callback when button is tapped.
  /// [onLongPress] callback when button is long pressed.
  IButton.filled({
    super.key,
    final Widget? child,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.borderRadius,
    this.elavation,
    this.statusType,
    this.padding,
    this.margin,
    this.onPressed,
    this.onLongPress,
  }) : child = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: InfinityDimens.mediumPadding,
                horizontal: InfinityDimens.padding,
              ),
              child: child,
            ),
          ],
        );

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget? child;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// The alignment of the button's [child].
  ///
  /// Typically buttons are sized to be just big enough to contain the child
  /// and its
  /// [padding]. If the button's size is constrained to a fixed size, for
  /// example by enclosing it with a [SizedBox], this property defines how the
  /// child is aligned within the available space.
  ///
  /// Always defaults to [Alignment.center].
  final AlignmentGeometry alignment;

  /// The button's background fill color.
  final Color? backgroundColor;

  /// The button's border radius.
  final double? borderRadius;

  /// The button's elevation.
  final int? elavation;

  /// The button's status type.
  final StatusType? statusType;

  /// The button's padding.
  final EdgeInsetsGeometry? padding;

  /// The spacing around the button's contents.
  final EdgeInsetsGeometry? margin;

  /// The callback that is called when the button is tapped or otherwise
  /// activated.
  ///
  /// If [onPressed] and [onLongPress] callbacks are null, then the button will
  /// be disabled.
  final VoidCallback? onPressed;

  /// If [onPressed] and [onLongPress] callbacks are null, then the button will
  /// be disabled.
  final VoidCallback? onLongPress;

  @override
  Widget build(final BuildContext context) {
    return Interaction(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
      onPressed: onPressed,
      onLongPress: onLongPress,
      builder: (final BuildContext context, final InteractionState? state) {
        Color bgColor = backgroundColor ??
            InfinityColors.getButtonBackgroundColor(
              context,
              state,
              elavation: elavation,
            );
        Color fgColor = InfinityColors.getForegroundColor(context);

        Color bg = bgColor;
        if (statusType != null) {
          fgColor = InfinityColors.getStatusColor(
            context,
            statusType!,
          );
          bgColor = fgColor.withTransparency(0.15);
          bg = state == null
              ? bgColor
              : InfinityColors.getStateColor(bgColor, state);
        }

        final Color fg =
            state == InteractionState.disabled ? fgColor.dimmed() : fgColor;

        final TextStyle textStyle = InfinityTypography.body.copyWith(
          color: fg,
        );
        final IconThemeData iconTheme = IconTheme.of(context).copyWith(
          color: fg,
        );

        return Semantics(
          button: true,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(InfinityDimens.padding),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? InfinityDimens.smallBorderRadius,
                  ),
                  side: BorderSide(
                    color: InfinityColors.getButtonBorderColor(bgColor, state),
                    // ignore: avoid_redundant_argument_values
                    width: InfinityDimens.borderThickness,
                  ),
                ),
                color: bg,
              ),
              child: Align(
                alignment: alignment,
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: DefaultTextStyle(
                  style: textStyle,
                  child: IconTheme(
                    data: iconTheme,
                    child: Padding(
                      padding: margin ??
                          const EdgeInsets.symmetric(
                            vertical: InfinityDimens.padding,
                            horizontal: InfinityDimens.mediumPadding,
                          ),
                      child: child ?? const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
