import 'package:flutter/widgets.dart';

import '../constants/colors.dart';
import '../constants/dimens.dart';
import '../constants/interaction_state.dart';
import '../constants/typography.dart';
import 'interaction.dart';
import 'squircle.dart';

/// Represents a tab item with an icon and label in Infinity's design system.
class ITabItem {
  /// Creates a tab item.
  ///
  /// [icon] The default icon widget shown for this tab.
  /// [selectedIcon] Optional icon widget shown when tab is selected.
  /// [label] Text label displayed next to the icon.
  ITabItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });

  /// The default icon widget shown for this tab.
  final Widget icon;

  /// Optional icon widget shown when tab is selected.
  final Widget? selectedIcon;

  /// Text label displayed next to the icon.
  final String label;
}

/// A tab bar widget that follows Infinity's design system.
class ITabBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates an Infinity tab bar.
  ///
  /// [selectedIndex] The currently selected tab index.
  /// [tabs] List of tab items to display.
  /// [onDestinationSelected] Callback when a tab is selected.
  const ITabBar({
    super.key,
    this.selectedIndex = 0,
    required this.tabs,
    this.onDestinationSelected,
  });

  /// The index of the currently selected tab.
  final int selectedIndex;

  /// The list of tab items to display.
  final List<ITabItem> tabs;

  /// Called when a tab is selected.
  final ValueChanged<int>? onDestinationSelected;

  @override
  Size get preferredSize => const Size.fromHeight(
        InfinityDimens.tabbarHeight + InfinityDimens.padding,
      );

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: InfinityDimens.tabbarHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: InfinityDimens.smallPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < tabs.length; i++)
              _ITabItem(
                icon: tabs[i].icon,
                selectedIcon: tabs[i].selectedIcon,
                label: tabs[i].label,
                isSelected: selectedIndex == i,
                onTap: () => onDestinationSelected?.call(i),
              ),
          ],
        ),
      ),
    );
  }
}

class _ITabItem extends StatelessWidget {
  const _ITabItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    return Interaction(
      onPressed: onTap,
      builder: (final BuildContext context, final InteractionState? state) {
        final Color bgColor =
            InfinityColors.getButtonBackgroundColor(context, elavation: 1);
        final Color fgColor = InfinityColors.getForegroundColor(context);

        final Color bg = state == null
            ? bgColor
            : InfinityColors.getStateColor(bgColor, state);
        final Color fg =
            state == InteractionState.disabled ? fgColor.dimmed() : fgColor;

        final TextStyle textStyle = InfinityTypography.body.copyWith(
          color: fg,
        );
        final IconThemeData iconTheme = IconTheme.of(context).copyWith(
          color: fg,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: InfinityDimens.smallPadding,
          ),
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                borderRadius: BorderRadius.circular(
                  InfinityDimens.smallBorderRadius,
                ),
                side: BorderSide(
                  color: InfinityColors.getButtonBorderColor(bgColor, state),
                  width: InfinityDimens.borderThickness,
                ),
              ),
              color: isSelected ? bg : InfinityColors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: InfinityDimens.padding,
                horizontal: InfinityDimens.largePadding,
              ),
              child: DefaultTextStyle(
                style: textStyle,
                child: IconTheme(
                  data: iconTheme,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (isSelected) selectedIcon ?? icon else icon,
                      const SizedBox(width: InfinityDimens.padding),
                      Text(label),
                    ],
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