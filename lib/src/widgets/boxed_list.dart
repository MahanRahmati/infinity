import 'package:flutter/widgets.dart';

import '../constants/colors.dart';
import '../constants/dimens.dart';
import 'card.dart';
import 'divider.dart';
import 'list_item.dart';

/// A boxed list widget that follows Infinity's design system.
/// Combines a card container with optional header and divider-separated
/// children.
class IBoxedList extends StatelessWidget {
  /// Creates an Infinity boxed list.
  ///
  /// [leading] optional widget displayed at the start of the header.
  /// [title] optional primary text/widget displayed in the header.
  /// [subtitle] optional secondary text/widget displayed below the title.
  /// [trailing] optional widget displayed at the end of the header.
  /// [children] optional list of widgets to display in the card container,
  /// separated by dividers.
  const IBoxedList({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.children,
  });

  /// Widget displayed at the start of the header section.
  final Widget? leading;

  /// Primary content widget displayed in the header section.
  final Widget? title;

  /// Secondary content widget displayed below the title in the header section.
  final Widget? subtitle;

  /// Widget displayed at the end of the header section.
  final Widget? trailing;

  /// List of widgets to display in the card container.
  /// Each widget is separated by a horizontal divider except for the last item.
  final List<Widget>? children;

  @override
  Widget build(final BuildContext context) {
    Widget? headerWidget;
    if (leading != null ||
        title != null ||
        subtitle != null ||
        trailing != null) {
      headerWidget = IListItem(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      );
    }

    Widget? childrenWidget;
    if (children != null && children!.isNotEmpty) {
      final Color borderColor = InfinityColors.getBorderColor(context);
      final List<Widget> items = <Widget>[
        for (int i = 0; i < children!.length; i++) ...<Widget>[
          children![i],
          if (i < children!.length - 1) IDivider(height: 0, color: borderColor),
        ],
      ];
      childrenWidget = FocusTraversalGroup(
        child: ICard(
          padding: const EdgeInsets.symmetric(
            vertical: InfinityDimens.padding,
            horizontal: InfinityDimens.largePadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (headerWidget != null) headerWidget,
        if (childrenWidget != null) childrenWidget,
      ],
    );
  }
}
