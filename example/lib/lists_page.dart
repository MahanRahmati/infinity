import 'package:infinity_widgets/infinity_widgets.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView(
      children: const <Widget>[
        IStatusPage(
          icon: MingCuteIcons.mgc_rows_4_line,
          title: 'Lists',
          subtitle: 'Flexible list components and layouts',
        ),
        ListItemWidget(),
        ListItemSeparated(),
      ],
    );
  }
}

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return IBoxedList(
      title: const Text('List Item'),
      children: const <Widget>[
        IListItem(
          title: Text('One-line'),
        ),
        IListItem(
          leading: Icon(MingCuteIcons.mgc_star_line),
          title: Text('One-line with leading'),
        ),
        IListItem(
          title: Text('One-line with trailing'),
          trailing: Icon(MingCuteIcons.mgc_more_1_line),
        ),
        IListItem(
          leading: Icon(MingCuteIcons.mgc_star_line),
          title: Text('One-line with both leading and trailing'),
          trailing: Icon(MingCuteIcons.mgc_more_1_line),
        ),
        IListItem(
          leading: Icon(MingCuteIcons.mgc_star_line),
          title: Text('Two-line'),
          subtitle: Text('Here is a subtitle'),
          trailing: Icon(MingCuteIcons.mgc_more_1_line),
        ),
      ],
    );
  }
}

class ListItemSeparated extends StatelessWidget {
  const ListItemSeparated({super.key});

  @override
  Widget build(final BuildContext context) {
    return IBoxedList.separated(
      title: const Text('Separated Items'),
      children: const <Widget>[
        IListItem(title: Text('First Item')),
        IListItem(title: Text('Second Item')),
        IListItem(title: Text('Third Item')),
      ],
    );
  }
}
