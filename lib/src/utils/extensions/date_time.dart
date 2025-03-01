import '/src/utils/date_time.dart';

const List<int> _daysInMonth = <int>[
  31,
  28,
  31,
  30,
  31,
  30,
  31,
  31,
  30,
  31,
  30,
  31,
];

/// Extensions for [DateTime] class.
extension InfinityDateTimeExtension on DateTime {
  /// Returns `true` if the current year is a leap year.
  bool isLeapYear(final int value) {
    return value % 400 == 0 || (value % 4 == 0 && value % 100 != 0);
  }

  /// Returns the number of days in the month of this date.
  int get daysInMonth {
    int result = _daysInMonth[month - 1];
    if (month == 2 && isLeapYear(year)) {
      result++;
    }
    return result;
  }

  /// Returns the start of the day of this date.
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Returns the start of the month of this date.
  DateTime get startOfMonth {
    return DateTime(year, month);
  }

  /// Returns the start of the year of this date.
  DateTime get startOfYear {
    return DateTime(year);
  }

  /// Calculates the difference in months between this date and [endDate].
  int monthDifference(final DateTime endDate) {
    final int yearDifference = endDate.year - year;
    final int monthDifference = endDate.month - month;
    return (yearDifference * 12) + monthDifference;
  }

  /// Returns a list of dates for a month view calendar.
  ///
  /// The list includes days from the previous and next months to
  /// fill a complete calendar grid starting from the specified [startDay].
  List<DateTime> getDaysInMonth(final StartDay startDay) {
    final DateTime firstDay = startOfMonth;
    final int daysInMonth = this.daysInMonth;

    int startDayOffset;
    switch (startDay) {
      case StartDay.saturday:
        // Saturday is 6
        startDayOffset = (firstDay.weekday + 1) % 7;
      case StartDay.sunday:
        // Sunday is 0
        startDayOffset = firstDay.weekday % 7;
      case StartDay.monday:
        // Monday is 1
        startDayOffset = (firstDay.weekday - 1) % 7;
        if (startDayOffset < 0) {
          startDayOffset += 7;
        }
    }

    final List<DateTime> days = <DateTime>[];
    final DateTime previousMonth = DateTime(year, month - 1);
    final int daysInPreviousMonth = previousMonth.daysInMonth;

    for (int i = 0; i < startDayOffset; i++) {
      days.add(
        DateTime(
          previousMonth.year,
          previousMonth.month,
          daysInPreviousMonth - startDayOffset + i + 1,
        ),
      );
    }

    for (int i = 0; i < daysInMonth; i++) {
      days.add(DateTime(year, month, i + 1));
    }

    final int remainingDays = (7 - (days.length % 7)) % 7;
    for (int i = 0; i < remainingDays; i++) {
      days.add(DateTime(year, month + 1, i + 1));
    }

    return days;
  }

  /// Calculate the week number for this date according to ISO-8601 standard.
  ///
  /// Returns the week number where week 1 is the week containing the first
  /// Thursday of the year.
  int get weekNumber {
    final DateTime d = DateTime(year, month, day);
    // Find the Thursday in the current week
    // (ISO weeks start on Monday and Thursday is used to determine the year)
    final DateTime thursday = d.add(Duration(days: (4 - d.weekday) % 7));
    final DateTime firstDayOfYear = DateTime(thursday.year);
    final int daysToThursday = thursday.difference(firstDayOfYear).inDays;
    return (daysToThursday / 7).floor() + 1;
  }

  /// Returns `true` if this date is the same as today.
  bool get isToday {
    return DateTime.now().startOfDay == startOfDay;
  }
}
