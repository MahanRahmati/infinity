import 'dart:math';

import 'package:flutter/widgets.dart';

import '/src/constants/colors.dart';
import '/src/constants/durations.dart';
import '/src/constants/interaction_state.dart';
import '/src/utils/extensions/build_context.dart';

/// A customizable gauge widget that follows Infinity's design system.
class IGauge extends StatelessWidget {
  /// Creates an [IGauge] widget.
  ///
  /// [value] the current value to display on the gauge.
  /// [minValue] the minimum value the gauge can represent.
  /// [maxValue] the maximum value the gauge can represent.
  /// [size] the diameter of the gauge.
  /// [thickness] the thickness of the gauge.
  /// [startAngle] the starting angle of the gauge, in radians.
  /// [sweepAngle] the angle of the gauge, in radians.
  /// [childBuilder] a builder that returns a widget to display inside the
  /// gauge.
  const IGauge({
    super.key,
    required this.value,
    this.minValue = 0.0,
    this.maxValue = 1.0,
    this.size = 200.0,
    this.thickness = 12.0,
    this.startAngle = pi * 0.75,
    this.sweepAngle = pi * 1.5,
    this.childBuilder,
  }) : assert(
          value >= minValue && value <= maxValue,
          'Value must be between minValue and maxValue',
        );

  /// The current value to display on the gauge.
  final double value;

  /// The minimum value the gauge can represent.
  final double minValue;

  /// The maximum value the gauge can represent.
  final double maxValue;

  /// The diameter of the gauge.
  final double size;

  /// The thickness of the gauge.
  final double thickness;

  /// The angle where the gauge starts, in radians.
  final double startAngle;

  /// The total sweep angle of the gauge, in radians.
  final double sweepAngle;

  /// A builder that returns a widget to display inside the gauge.
  final Widget? Function(double value)? childBuilder;

  @override
  Widget build(final BuildContext context) {
    final bool isDarkMode = context.isDarkMode;
    final double normalizedValue = (value - minValue) / (maxValue - minValue);
    final Color backgroundColor = InfinityColors.getStateOpacityColor(
      isDarkMode,
      InteractionState.pressed,
    );
    const Color foregroundColor = InfinityColors.successDark;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: normalizedValue),
      duration: InfinityDurations.veryLong,
      builder: (
        final BuildContext context,
        final double value,
        final Widget? child,
      ) {
        final double currentValue = minValue + value * (maxValue - minValue);
        return CustomPaint(
          size: Size(size, size),
          painter: _GaugePainter(
            normalizedValue: value,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            thickness: thickness,
            startAngle: startAngle,
            sweepAngle: sweepAngle,
          ),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: childBuilder?.call(currentValue) ?? const SizedBox(),
            ),
          ),
        );
      },
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({
    required this.normalizedValue,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.thickness,
    required this.startAngle,
    required this.sweepAngle,
  });

  final double normalizedValue;
  final Color backgroundColor;
  final Color foregroundColor;
  final double thickness;
  final double startAngle;
  final double sweepAngle;

  @override
  void paint(final Canvas canvas, final Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width, size.height) / 2 - thickness / 2;

    // Draw background arc
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    // Draw foreground arc
    final Paint foregroundPaint = Paint()
      ..color = foregroundColor
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * normalizedValue,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(final _GaugePainter oldDelegate) {
    return oldDelegate.normalizedValue != normalizedValue ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor ||
        oldDelegate.thickness != thickness ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle;
  }
}
