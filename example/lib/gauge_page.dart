import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

class GaugePage extends StatelessWidget {
  const GaugePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const IStatusPage(
          icon: MingCuteIcons.mgc_spacing_horizontal_line,
          title: 'Gauge',
          subtitle:
              'A visualization widget to display progress or value ranges',
        ),
        IBoxedList(
          children: <Widget>[
            IGauge(
              value: 75,
              minValue: 0,
              maxValue: 100,
              childBuilder: (value) => Text('${value.toInt()}%'),
            ),
            IGauge(
              value: 0.3,
              childBuilder: (_) => Icon(
                MingCuteIcons.mgc_cloud_fill,
                size: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
