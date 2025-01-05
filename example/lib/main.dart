import 'package:flutter/material.dart';
import 'package:infinity/infinity.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      theme: InfinityTheme.light(),
      darkTheme: InfinityTheme.dark(),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Scaffold(
      body: IBoundedBox(
        child: Column(
          children: <Widget>[
            Buttons(),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return IBoxedList(
      header: const Text('Buttons'),
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            IButton.text(
              onPressed: () {},
              text: 'Primary',
            ),
            IButton.text(
              text: 'Disabled',
            ),
            IButton.text(
              statusType: StatusType.error,
              onPressed: () {},
              text: 'Error',
            ),
            IButton.text(
              statusType: StatusType.warning,
              onPressed: () {},
              text: 'Warning',
            ),
            IButton.text(
              statusType: StatusType.success,
              onPressed: () {},
              text: 'Success',
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            IButton.icon(
              onPressed: () {},
              icon: MingCuteIcons.mgc_star_line,
            ),
            IButton.icon(
              icon: MingCuteIcons.mgc_star_line,
            ),
            IButton.icon(
              statusType: StatusType.error,
              onPressed: () {},
              icon: MingCuteIcons.mgc_delete_line,
            ),
            IButton.icon(
              statusType: StatusType.warning,
              onPressed: () {},
              icon: MingCuteIcons.mgc_warning_line,
            ),
            IButton.icon(
              statusType: StatusType.success,
              onPressed: () {},
              icon: MingCuteIcons.mgc_check_line,
            ),
          ],
        ),
      ],
    );
  }
}
