/// What day of the week the calendar should start on.
enum StartDay {
  /// Saturday.
  saturday,

  /// Sunday.
  sunday,

  /// Monday.
  monday;

  const StartDay();

  /// Returns the days of the week in the order they should be displayed.
  List<String> get days {
    switch (this) {
      case StartDay.saturday:
        return <String>['S', 'S', 'M', 'T', 'W', 'T', 'F'];
      case StartDay.sunday:
        return <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];
      case StartDay.monday:
        return <String>['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    }
  }
}
