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
    return Scaffold(
      appBar: IHeaderBar(
        middle: Text('Showcase'),
      ),
      body: IBoundedBox(
        child: ListView(
          children: <Widget>[
            Buttons(),
            ListItemWidget(),
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
      title: const Text('Buttons'),
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
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            IBackButton(),
            ICloseButton(),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
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
      ],
    );
  }
}

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IBoxedList(
      title: const Text('List Item'),
      children: [
        IListItem(
          title: const Text('One-line'),
        ),
        IListItem(
          leading: Icon(MingCuteIcons.mgc_star_line),
          title: const Text('One-line with leading'),
        ),
        IListItem(
          title: const Text('One-line with trailing'),
          trailing: Icon(MingCuteIcons.mgc_more_1_line),
        ),
        IListItem(
          leading: Icon(MingCuteIcons.mgc_star_line),
          title: const Text('One-line with both leading and trailing'),
          trailing: Icon(MingCuteIcons.mgc_more_1_line),
        ),
        IListItem(
          leading: Icon(MingCuteIcons.mgc_star_line),
          title: const Text('Two-line'),
          subtitle: const Text('Here is a subtitle'),
          trailing: Icon(MingCuteIcons.mgc_more_1_line),
        ),
      ],
    );
  }
}
