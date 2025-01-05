import 'package:flutter/widgets.dart';

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
  IBoxedList({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    final List<Widget>? children,
  }) : children = children != null && children.isNotEmpty
            ? <Widget>[
                FocusTraversalGroup(
                  child: ICard(
                    padding: const EdgeInsets.symmetric(
                      vertical: InfinityDimens.padding,
                      horizontal: InfinityDimens.largePadding,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (int i = 0; i < children.length; i++) ...<Widget>[
                          children[i],
                          if (i < children.length - 1)
                            const IDivider(height: 0),
                        ],
                      ],
                    ),
                  ),
                ),
              ]
            : null;

  /// Creates an Infinity boxed list with separated rows.
  ///
  /// [leading] optional widget displayed at the start of the header.
  /// [title] optional primary text/widget displayed in the header.
  /// [subtitle] optional secondary text/widget displayed below the title.
  /// [trailing] optional widget displayed at the end of the header.
  /// [children] optional list of widgets to display in separate cards.
  /// Each child will be placed in its own card with vertical spacing between
  /// them.
  IBoxedList.separated({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    final List<Widget>? children,
  }) : children = children
            ?.map(
              (final Widget child) => FocusTraversalGroup(
                child: ICard(
                  padding: const EdgeInsets.symmetric(
                    vertical: InfinityDimens.padding,
                    horizontal: InfinityDimens.largePadding,
                  ),
                  child: child,
                ),
              ),
            )
            .toList();

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (headerWidget != null) headerWidget,
        if (children != null) ...children!,
      ],
    );
  }
}
