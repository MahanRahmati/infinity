import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import '/src/constants/colors.dart';
import '/src/constants/dimens.dart';
import '/src/constants/interaction_state.dart';
import '/src/constants/typography.dart';
import '/src/utils/date_time.dart';
import '/src/utils/extensions/build_context.dart';
import '/src/utils/extensions/date_time.dart';
import 'button.dart';
import 'interaction.dart';
import 'squircle.dart';

/// A customizable calendar widget that follows Infinity's design system.
class ICalendar extends StatefulWidget {
  /// Creates an Infinity calendar.
  ///
  /// [initialDate] optional initial date to display when the calendar first.
  /// [firstDate] optional earliest allowable date.
  /// [lastDate] optional latest allowable date.
  /// [onDateChanged] called when the user selects a date in the calendar.
  const ICalendar({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateChanged,
    this.startDay = StartDay.sunday,
  });

  /// The initial date to display when the calendar first appears.
  final DateTime? initialDate;

  /// The earliest allowable date.
  final DateTime? firstDate;

  /// The latest allowable date.
  final DateTime? lastDate;

  /// Called when the user selects a date in the calendar.
  final ValueChanged<DateTime>? onDateChanged;

  /// What day of the week the calendar should start on.
  final StartDay startDay;

  @override
  State<ICalendar> createState() => _ICalendarState();
}

class _ICalendarState extends State<ICalendar> {
  DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;
  late DateTime _currentMonth;
  late int _pageCount;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _firstDate = widget.firstDate ?? DateTime(1900);
    _lastDate = widget.lastDate ?? DateTime(2100, 12);

    _currentMonth = (widget.initialDate ?? DateTime.now()).startOfMonth;
    _pageCount = _firstDate.monthDifference(_lastDate) + 1;

    final int initialPage = _firstDate.monthDifference(_currentMonth);
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onMonthChanged(final int page) {
    final DateTime newMonth = DateTime(
      _firstDate.year,
      _firstDate.month + page,
    );
    setState(() => _currentMonth = newMonth);
  }

  void _previousMonth() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _nextMonth() {
    if (_pageController.page! < _pageCount - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: InfinityDimens.padding,
        horizontal: InfinityDimens.largePadding,
      ),
      child: SizedBox(
        width: InfinityDimens.calendarWidth,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: InfinityDimens.calendarHeaderHeight,
                child: Row(
                  children: <Widget>[
                    IButton.icon(
                      onPressed: _previousMonth,
                      icon: MingCuteIcons.mgc_left_line,
                    ),
                    const SizedBox(width: InfinityDimens.padding),
                    Expanded(
                      child: Text(
                        DateFormat('MMMM yyyy').format(_currentMonth),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: InfinityDimens.padding),
                    IButton.icon(
                      onPressed: _nextMonth,
                      icon: MingCuteIcons.mgc_right_line,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: InfinityDimens.largePadding),
              Row(
                children: <String>[' ', ...widget.startDay.days]
                    .map((final String day) {
                  return Expanded(child: _WeekDay(day: day));
                }).toList(),
              ),
              const SizedBox(height: InfinityDimens.largePadding),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: InfinityDimens.calendarMaxHeight,
                ),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onMonthChanged,
                  itemCount: _pageCount,
                  itemBuilder: (final BuildContext context, final int index) {
                    final DateTime monthToShow = DateTime(
                      _firstDate.year,
                      _firstDate.month + index,
                    );
                    return _Month(
                      key: ValueKey<DateTime>(monthToShow),
                      month: monthToShow,
                      selectedDate: _selectedDate,
                      firstDate: widget.firstDate,
                      lastDate: widget.lastDate,
                      onDateChanged: (final DateTime date) {
                        setState(() => _selectedDate = date);
                        widget.onDateChanged?.call(date);
                      },
                      startDay: widget.startDay,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekDay extends StatelessWidget {
  const _WeekDay({required this.day});

  final String day;

  @override
  Widget build(final BuildContext context) {
    final bool isDarkMode = context.isDarkMode;
    return Center(
      child: Text(
        day,
        style: InfinityTypography.caption.copyWith(
          color: InfinityColors.getForegroundColor(isDarkMode).dimmed(),
        ),
      ),
    );
  }
}

class _Month extends StatefulWidget {
  const _Month({
    super.key,
    required this.month,
    required this.selectedDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateChanged,
    required this.startDay,
  });

  final DateTime month;
  final DateTime? selectedDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateChanged;
  final StartDay startDay;

  @override
  State<_Month> createState() => _MonthState();
}

class _MonthState extends State<_Month> {
  late final List<FocusNode> _focusNodes;
  late final List<DateTime> _days;

  @override
  void initState() {
    super.initState();
    _days = widget.month.getDaysInMonth(widget.startDay);
    _focusNodes =
        List<FocusNode>.generate(_days.length, (final _) => FocusNode());
  }

  @override
  void dispose() {
    for (final FocusNode focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  List<int> _getWeekNumbers(final List<DateTime> days) {
    final List<int> weekNumbers = <int>[];
    for (int i = 0; i < days.length; i += 7) {
      weekNumbers.add(days[i].weekNumber);
    }
    return weekNumbers;
  }

  @override
  Widget build(final BuildContext context) {
    final List<int> weekNumbers = _getWeekNumbers(_days);
    final DateTime today = DateTime.now().startOfDay;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: weekNumbers.map((final int weekNumber) {
              return SizedBox.square(
                dimension: 56,
                child: _WeekDay(day: weekNumber.toString()),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (final BuildContext context, final int index) {
              final DateTime date = _days[index];

              final bool isBeforeFirstDate = widget.firstDate != null &&
                  date.isBefore(widget.firstDate!.startOfDay);

              final bool isAfterLastDate = widget.lastDate != null &&
                  date.isAfter(widget.lastDate!.startOfDay);

              final bool isDisabled = date.month != widget.month.month ||
                  isBeforeFirstDate ||
                  isAfterLastDate;
              return _Day(
                day: date,
                isDisabled: isDisabled,
                isSelectedDay: widget.selectedDate?.startOfDay == date,
                isToday: date == today,
                onChanged: widget.onDateChanged,
                focusNode: _focusNodes[index],
              );
            },
            itemCount: _days.length,
          ),
        ),
      ],
    );
  }
}

class _Day extends StatelessWidget {
  const _Day({
    required this.day,
    required this.isDisabled,
    required this.isSelectedDay,
    required this.isToday,
    required this.onChanged,
    required this.focusNode,
  });

  final DateTime day;
  final bool isDisabled;
  final bool isSelectedDay;
  final bool isToday;
  final ValueChanged<DateTime>? onChanged;
  final FocusNode focusNode;

  @override
  Widget build(final BuildContext context) {
    final bool isDarkMode = context.isDarkMode;

    return Interaction(
      focusNode: focusNode,
      onPressed: isDisabled
          ? null
          : () {
              onChanged?.call(day);
            },
      builder: (final BuildContext context, final InteractionState? state) {
        final StatusType? backgroundStatusType =
            isSelectedDay ? StatusType.success : null;
        final StatusType? foregroundStatusType =
            (isToday || isSelectedDay) ? StatusType.success : null;

        final Color backgroundColor = InfinityColors.getButtonBackgroundColor(
          isDarkMode,
          state,
          statusType: backgroundStatusType,
          isTransparent: !isSelectedDay,
        );

        final Color foregroundColor = InfinityColors.getButtonForegroundColor(
          isDarkMode,
          state: isDisabled ? InteractionState.disabled : state,
          statusType: foregroundStatusType,
        );

        final Color borderColor = InfinityColors.getButtonBorderColor(
          isDarkMode,
          state,
          statusType: foregroundStatusType,
          isTransparent: !isSelectedDay,
        );

        final TextStyle textStyle = InfinityTypography.body.copyWith(
          color: foregroundColor,
        );
        final IconThemeData iconTheme = IconTheme.of(
          context,
        ).copyWith(color: foregroundColor);

        return Semantics(
          button: true,
          label: 'Day ${day.day}',
          selected: isSelectedDay,
          enabled: !isDisabled,
          child: Padding(
            padding: const EdgeInsets.all(InfinityDimens.smallPadding),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    InfinityDimens.smallBorderRadius,
                  ),
                  side: BorderSide(
                    color: borderColor,
                    // ignore: avoid_redundant_argument_values
                    width: InfinityDimens.borderThickness,
                  ),
                ),
                color: backgroundColor,
              ),
              child: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: DefaultTextStyle(
                  style: textStyle,
                  child: IconTheme(
                    data: iconTheme,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: InfinityDimens.mediumPadding,
                        horizontal: InfinityDimens.padding,
                      ),
                      child: Text(day.day.toString()),
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
