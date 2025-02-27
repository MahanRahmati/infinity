import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const IStatusPage(
          icon: MingCuteIcons.mgc_spacing_horizontal_line,
          title: 'Calendar',
          subtitle: 'A customizable date selection widget',
        ),
        IBoxedList(
          children: const <Widget>[
            ICalendar(),
          ],
        ),
      ],
    );
  }
}
