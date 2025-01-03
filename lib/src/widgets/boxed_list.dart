import 'package:flutter/widgets.dart';

import '../constants/colors.dart';
import '../constants/dimens.dart';
import 'card.dart';
import 'divider.dart';

/// A boxed list widget that follows Infinity's design system.
/// Combines a card container with optional header and divider-separated
/// children.
class IBoxedList extends StatelessWidget {
  /// Creates an Infinity boxed list.
  ///
  /// [header] optional widget displayed above the list.
  /// [children] optional list of widgets to display in the card container,
  /// separated by dividers.
  const IBoxedList({
    super.key,
    this.header,
    this.children,
  });

  /// Widget displayed above the list container.
  /// Typically used for titles or descriptive content.
  final Widget? header;

  /// List of widgets to display in the card container.
  /// Each widget is separated by a horizontal divider except for the last item.
  final List<Widget>? children;

  @override
  Widget build(final BuildContext context) {
    Widget? headerWidget;
    if (header != null) {
      headerWidget = Padding(
        padding: const EdgeInsets.symmetric(
          vertical: InfinityDimens.padding,
          horizontal: InfinityDimens.largePadding,
        ),
        child: header,
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
