import 'package:infinity_widgets/infinity_widgets.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          IBoxedList(
            title: const Text('Day View Calendar'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: InfinityDimens.padding),
                child: ICalendarDayView(
                  date: DateTime.now(),
                  eventBuilder: (DateTime timeSlot) {
                    final List<ICalendarEvent> events = [];

                    if (timeSlot.hour == 10) {
                      final DateTime startTime1 = DateTime(
                        timeSlot.year,
                        timeSlot.month,
                        timeSlot.day,
                        10,
                        0,
                      );
                      final DateTime endTime1 = DateTime(
                        timeSlot.year,
                        timeSlot.month,
                        timeSlot.day,
                        11,
                        0,
                      );

                      events.add(
                        ICalendarEvent(
                          start: startTime1,
                          end: endTime1,
                          color: InfinityColors.destructiveDark,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Meeting with Team'),
                          ),
                        ),
                      );

                      final DateTime startTime2 = DateTime(
                        timeSlot.year,
                        timeSlot.month,
                        timeSlot.day,
                        10,
                        30,
                      );
                      final DateTime endTime2 = DateTime(
                        timeSlot.year,
                        timeSlot.month,
                        timeSlot.day,
                        11,
                        30,
                      );

                      events.add(
                        ICalendarEvent(
                          start: startTime2,
                          end: endTime2,
                          color: InfinityColors.successDark,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Client Call'),
                          ),
                        ),
                      );
                    }

                    if (timeSlot.hour == 14) {
                      final DateTime startTime = DateTime(
                        timeSlot.year,
                        timeSlot.month,
                        timeSlot.day,
                        14,
                        0,
                      );
                      final DateTime endTime = DateTime(
                        timeSlot.year,
                        timeSlot.month,
                        timeSlot.day,
                        15,
                        30,
                      );
                      events.add(
                        ICalendarEvent(
                          start: startTime,
                          end: endTime,
                          color: InfinityColors.successLight,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Project Review'),
                          ),
                        ),
                      );
                    }

                    return events;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
