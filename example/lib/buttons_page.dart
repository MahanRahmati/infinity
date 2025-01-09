import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView(
      children: const <Widget>[
        IStatusPage(
          icon: MingCuteIcons.mgc_star_line,
          title: 'Buttons',
          subtitle: 'Interactive buttons with multiple styles',
        ),
        Buttons(),
      ],
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(final BuildContext context) {
    return IBoxedList(
      title: const Text('Buttons'),
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
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
          children: <Widget>[
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
        const Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            IBackButton(),
            ICloseButton(),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            IButton.compound(
              text: 'Text Only',
              onPressed: () {},
            ),
            IButton.compound(
              leadingIcon: MingCuteIcons.mgc_star_line,
              text: 'Leading',
              onPressed: () {},
            ),
            IButton.compound(
              text: 'Trailing',
              trailingIcon: MingCuteIcons.mgc_right_line,
              onPressed: () {},
            ),
            IButton.compound(
              leadingIcon: MingCuteIcons.mgc_star_line,
              text: 'Both Icons',
              trailingIcon: MingCuteIcons.mgc_right_line,
              onPressed: () {},
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            IButton.pill(
              child: const Text('Pill Button'),
              onPressed: () {},
            ),
            const IButton.pill(
              child: Text('Disabled Pill'),
            ),
            IButton.pill(
              statusType: StatusType.success,
              child: const Text('Success Pill'),
              onPressed: () {},
            ),
            IButton.pill(
              statusType: StatusType.error,
              child: const Text('Error Pill'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
