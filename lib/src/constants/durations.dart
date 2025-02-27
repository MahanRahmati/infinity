/// This class provides a duration system for Infinity.
/// This class is not meant to be instantiated.
class InfinityDurations {
  InfinityDurations._();

  /// Duration for short animations.
  static const Duration short = Duration(milliseconds: 150);

  /// Duration for medium animations.
  static const Duration medium = Duration(milliseconds: 250);

  /// Duration for long animations.
  static const Duration long = Duration(milliseconds: 350);

  /// Duration for very long animations.
  static const Duration veryLong = Duration(milliseconds: 500);
}
