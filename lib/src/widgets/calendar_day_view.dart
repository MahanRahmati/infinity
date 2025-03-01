import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';
import '/src/constants/interaction_state.dart';
import '/src/constants/typography.dart';
import '/src/utils/extensions/build_context.dart';
import '/src/utils/extensions/date_time.dart';
import 'divider.dart';
import 'interaction.dart';
import 'squircle.dart';

/// Function signature for handling event taps with time information
typedef CalendarEventTapCallback = void Function(DateTime start, DateTime end);

/// A customizable calendar event.
class ICalendarEvent {
  /// Creates a calendar event.
  /// [start] the start time of the event.
  /// [end] the end time of the event.
  /// [child] the content of the event.
  /// [color] the color of the event.
  /// [onTap] callback function when the event is tapped.
  ICalendarEvent({
    required this.start,
    required this.end,
    required this.child,
    this.color,
    this.onTap,
  });

  /// The start time of the event.
  final DateTime start;

  /// The end time of the event.
  final DateTime end;

  /// The content of the event.
  final Widget child;

  /// The color of the event.
  final Color? color;

  /// Callback function when the event is tapped, providing start and end times.
  final CalendarEventTapCallback? onTap;
}

/// Function signature for building time slot labels
typedef TimeSlotLabelBuilder = String Function(DateTime dateTime);

/// Function signature for building calendar events
typedef CalendarEventBuilder = List<ICalendarEvent> Function(DateTime dateTime);

/// A customizable day view calendar widget that follows Infinity's design
/// system.
class ICalendarDayView extends StatelessWidget {
  /// Creates an Infinity day view calendar.
  ///
  /// [date] date to display in the day view.
  /// [onTimeSlotSelected] called when the user selects a time slot in the
  /// calendar.
  /// [hourHeight] height for each hour in the day view.
  /// [startHour] first hour to show in the day view.
  /// [endHour] last hour to show in the day view.
  /// [sectionsPerHour] number of sections to divide each hour into.
  /// [timeSlotLabelBuilder] custom builder for time slot labels.
  /// [eventBuilder] custom builder for calendar events.
  const ICalendarDayView({
    super.key,
    required this.date,
    this.onTimeSlotSelected,
    this.hourHeight = InfinityDimens.calendarDayItemHeight,
    this.startHour = 0,
    this.endHour = 23,
    this.sectionsPerHour = 2,
    this.timeSlotLabelBuilder,
    this.eventBuilder,
  }) : assert(
         startHour >= 0 && startHour <= 23,
         'startHour must be between 0 and 23',
       ),
       assert(
         endHour >= startHour && endHour <= 23,
         'endHour must be between startHour and 23',
       ),
       assert(sectionsPerHour > 0, 'sectionsPerHour must be greater than 0'),
       assert(hourHeight > 0, 'hourHeight must be positive');

  /// The date to display in the day view.
  final DateTime date;

  /// Called when the user selects a time slot in the calendar.
  final ValueChanged<DateTime>? onTimeSlotSelected;

  /// Height for each hour in the day view.
  final double hourHeight;

  /// First hour to show in the day view (24-hour format, 0-23).
  final int startHour;

  /// Last hour to show in the day view (24-hour format, 0-23).
  final int endHour;

  /// Number of sections to divide each hour into.
  final int sectionsPerHour;

  /// Custom builder for time slot labels.
  final TimeSlotLabelBuilder? timeSlotLabelBuilder;

  /// Custom builder for calendar events.
  final CalendarEventBuilder? eventBuilder;

  String _defaultTimeSlotLabelBuilder(final DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  @override
  Widget build(final BuildContext context) {
    final List<ICalendarEvent> allEvents = <ICalendarEvent>[];
    if (eventBuilder != null) {
      for (int hour = startHour; hour <= endHour; hour++) {
        final DateTime hourSlot = DateTime(
          date.year,
          date.month,
          date.day,
          hour,
        );
        allEvents.addAll(eventBuilder!(hourSlot));
      }
    }

    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: InfinityDimens.calendarDayLabelWidth,
                child: _TimeLabel(
                  date: date,
                  hourHeight: hourHeight,
                  startHour: startHour,
                  endHour: endHour,
                  timeSlotLabelBuilder:
                      timeSlotLabelBuilder ?? _defaultTimeSlotLabelBuilder,
                ),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: InfinityDimens.padding,
                      ),
                      child: Column(
                        children: List<Widget>.generate(
                          endHour - startHour + 1,
                          (_) {
                            return _TimeDivider(hourHeight: hourHeight);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: InfinityDimens.padding,
                      ),
                      child: _TimeSlots(
                        date: date,
                        onTimeSlotSelected: onTimeSlotSelected,
                        hourHeight: hourHeight,
                        startHour: startHour,
                        endHour: endHour,
                        sectionsPerHour: sectionsPerHour,
                        events: allEvents,
                      ),
                    ),
                    if (eventBuilder != null)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: InfinityDimens.padding,
                        ),
                        child: _EventsLayer(
                          date: date,
                          hourHeight: hourHeight,
                          startHour: startHour,
                          endHour: endHour,
                          eventBuilder: eventBuilder!,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (date.isToday)
            _CurrentTimeIndicator(
              startHour: startHour,
              hourHeight: hourHeight,
              timeSlotLabelBuilder:
                  timeSlotLabelBuilder ?? _defaultTimeSlotLabelBuilder,
            ),
        ],
      ),
    );
  }
}

class _TimeLabel extends StatelessWidget {
  const _TimeLabel({
    required this.date,
    required this.hourHeight,
    required this.startHour,
    required this.endHour,
    required this.timeSlotLabelBuilder,
  });

  final DateTime date;
  final double hourHeight;
  final int startHour;
  final int endHour;
  final TimeSlotLabelBuilder timeSlotLabelBuilder;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: List<Widget>.generate(endHour - startHour + 1, (
        final int index,
      ) {
        final int hour = startHour + index;
        final DateTime timeSlot = DateTime(
          date.year,
          date.month,
          date.day,
          hour,
        );
        final String timeLabel = timeSlotLabelBuilder.call(timeSlot);
        return SizedBox(
          height: hourHeight,
          child: Text(timeLabel, style: InfinityTypography.caption),
        );
      }),
    );
  }
}

class _TimeDivider extends StatelessWidget {
  const _TimeDivider({required this.hourHeight});

  final double hourHeight;

  @override
  Widget build(final BuildContext context) {
    final bool isDarkMode = context.isDarkMode;
    final Color foregroundColor = InfinityColors.getForegroundColor(isDarkMode);
    final Color dividerColor = foregroundColor.withOpacity(0.1);
    return SizedBox(
      height: hourHeight,
      child: Column(
        children: <Widget>[IDivider(color: dividerColor), const Spacer()],
      ),
    );
  }
}

class _TimeSlots extends StatelessWidget {
  const _TimeSlots({
    required this.date,
    required this.onTimeSlotSelected,
    required this.hourHeight,
    required this.startHour,
    required this.endHour,
    required this.sectionsPerHour,
    this.events,
  });

  final DateTime date;
  final ValueChanged<DateTime>? onTimeSlotSelected;
  final double hourHeight;
  final int startHour;
  final int endHour;
  final int sectionsPerHour;
  final List<ICalendarEvent>? events;

  bool _hasEventOverlap(
    final DateTime timeSlot,
    final int slotDurationMinutes,
  ) {
    if (events == null || events!.isEmpty) {
      return false;
    }

    final DateTime slotEnd = timeSlot.add(
      Duration(minutes: slotDurationMinutes),
    );

    for (final ICalendarEvent event in events!) {
      // If time slot start or end falls within event time range
      if ((timeSlot.isAfter(event.start) && timeSlot.isBefore(event.end)) ||
          (slotEnd.isAfter(event.start) && slotEnd.isBefore(event.end)) ||
          (timeSlot.isAtSameMomentAs(event.start)) ||
          (slotEnd.isAtSameMomentAs(event.end)) ||
          (timeSlot.isBefore(event.start) && slotEnd.isAfter(event.end))) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(final BuildContext context) {
    final int slotDurationMinutes = 60 ~/ sectionsPerHour;

    return Column(
      children: List<Widget>.generate(
        (endHour - startHour + 1) * sectionsPerHour,
        (final int index) {
          final int hourIndex = index ~/ sectionsPerHour;
          final int minuteIndex =
              (index % sectionsPerHour) * (60 ~/ sectionsPerHour);
          final int hour = startHour + hourIndex;

          final DateTime timeSlot = DateTime(
            date.year,
            date.month,
            date.day,
            hour,
            minuteIndex,
          );

          final bool isOverlappingEvent = _hasEventOverlap(
            timeSlot,
            slotDurationMinutes,
          );

          return _TimeSlot(
            height: hourHeight / sectionsPerHour,
            timeSlot: timeSlot,
            onSelected: isOverlappingEvent ? null : onTimeSlotSelected,
            isDisabled: isOverlappingEvent,
          );
        },
      ),
    );
  }
}

class _TimeSlot extends StatelessWidget {
  const _TimeSlot({
    required this.height,
    required this.timeSlot,
    this.onSelected,
    this.isDisabled = false,
  });

  final double height;
  final DateTime timeSlot;
  final ValueChanged<DateTime>? onSelected;
  final bool isDisabled;

  @override
  Widget build(final BuildContext context) {
    final bool isDarkMode = context.isDarkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: InfinityDimens.smallPadding,
      ),
      child: SizedBox(
        height: height,
        child: Interaction(
          useScale: false,
          onPressed: isDisabled ? null : () => onSelected?.call(timeSlot),
          builder: (final BuildContext context, final InteractionState? state) {
            final Color backgroundColor =
                isDisabled
                    ? InfinityColors.transparent
                    : InfinityColors.getButtonBackgroundColor(
                      isDarkMode,
                      state,
                      isTransparent: true,
                    );

            return DecoratedBox(
              decoration: ShapeDecoration(
                color: backgroundColor,
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    InfinityDimens.smallBorderRadius,
                  ),
                ),
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
      ),
    );
  }
}

class _EventsLayer extends StatelessWidget {
  const _EventsLayer({
    required this.date,
    required this.hourHeight,
    required this.startHour,
    required this.endHour,
    required this.eventBuilder,
  });

  final DateTime date;
  final double hourHeight;
  final int startHour;
  final int endHour;
  final CalendarEventBuilder eventBuilder;

  @override
  Widget build(final BuildContext context) {
    final List<Widget> eventWidgets = <Widget>[];

    for (int hour = startHour; hour <= endHour; hour++) {
      final DateTime timeSlot = DateTime(date.year, date.month, date.day, hour);
      final List<ICalendarEvent> hourEvents = eventBuilder(timeSlot);

      for (final ICalendarEvent event in hourEvents) {
        final double startHourDecimal =
            event.start.hour + event.start.minute / 60.0;
        final double endHourDecimal = event.end.hour + event.end.minute / 60.0;

        final double top = (startHourDecimal - startHour) * hourHeight;
        final double height = (endHourDecimal - startHourDecimal) * hourHeight;

        eventWidgets.add(
          Positioned(
            top: top,
            left: 0,
            right: 0,
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: InfinityDimens.smallPadding,
              ),
              child: GestureDetector(
                onTap:
                    event.onTap != null
                        ? () => event.onTap!(event.start, event.end)
                        : null,
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: event.color?.dimmed(),
                    shape: SmoothRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        InfinityDimens.borderRadius,
                      ),
                    ),
                  ),
                  child: event.child,
                ),
              ),
            ),
          ),
        );
      }
    }

    final double totalHeight = (endHour - startHour + 1) * hourHeight;
    return SizedBox(height: totalHeight, child: Stack(children: eventWidgets));
  }
}

class _CurrentTimeIndicator extends StatefulWidget {
  const _CurrentTimeIndicator({
    required this.startHour,
    required this.hourHeight,
    required this.timeSlotLabelBuilder,
  });

  final int startHour;
  final double hourHeight;
  final TimeSlotLabelBuilder timeSlotLabelBuilder;

  @override
  State<_CurrentTimeIndicator> createState() => _CurrentTimeIndicatorState();
}

class _CurrentTimeIndicatorState extends State<_CurrentTimeIndicator> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final double hourDecimal = _currentTime.hour + _currentTime.minute / 60.0;
    final double top = (hourDecimal - widget.startHour) * widget.hourHeight;
    final String currentTimeLabel = widget.timeSlotLabelBuilder(_currentTime);
    return Positioned(
      left: 0,
      right: 0,
      top: top,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: InfinityDimens.padding,
            ),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: InfinityColors.destructiveDark,
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    InfinityDimens.borderRadius,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: InfinityDimens.smallPadding,
                  vertical: InfinityDimens.tinyPadding,
                ),
                child: Text(
                  currentTimeLabel,
                  style: InfinityTypography.caption,
                ),
              ),
            ),
          ),
          const Expanded(
            child: IDivider(color: InfinityColors.destructiveDark),
          ),
        ],
      ),
    );
  }
}
