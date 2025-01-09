import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

class BoundedPage extends StatelessWidget {
  const BoundedPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const IStatusPage(
          icon: MingCuteIcons.mgc_spacing_horizontal_line,
          title: 'Bounded',
          subtitle:
              'This page is bounded to smoothly grow up to a maximum width',
        ),
        IBoxedList(
          children: <Widget>[
            IListItem(
              title: const Text('Maximum Width'),
              trailing: Text(InfinityDimens.boundedMaxWidth.toString()),
            ),
          ],
        ),
      ],
    );
  }
}
