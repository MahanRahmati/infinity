import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class ExampleHome extends StatefulWidget {
  const ExampleHome({super.key});

  @override
  State<ExampleHome> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  int _selectedIndex = 0;

  static Future<String> getLicense() async {
    try {
      return await rootBundle.loadString('LICENSE');
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: IHeaderBar(
        middle: Text('Showcase'),
        trailing: [
          IButton.icon(
            icon: MingCuteIcons.mgc_information_line,
            onPressed: () async {
              final String license = await getLicense();
              if (!context.mounted) {
                return;
              }
              showAboutDialogModal(
                context: context,
                applicationName: 'Showcase',
                version: '1.0.0',
                applicationIcon: IApplicationIcon(
                  Icon(
                    MingCuteIcons.mgc_presentation_1_line,
                    size: InfinityDimens.appIconSize,
                  ),
                  size: InfinityDimens.appIconSize,
                ),
                developers: ['Mahan Rahmati'],
                website: 'https://github.com/MahanRahmati/infinity',
                issueUrl: 'https://github.com/MahanRahmati/infinity/issues',
                license: license,
              );
            },
          ),
        ],
        bottom: ITabBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedIndex = index);
          },
          tabs: [
            ITabItem(
              icon: Icon(MingCuteIcons.mgc_home_1_line),
              selectedIcon: Icon(MingCuteIcons.mgc_home_1_fill),
              label: 'Home',
            ),
            ITabItem(
              icon: Icon(MingCuteIcons.mgc_ghost_line),
              selectedIcon: Icon(MingCuteIcons.mgc_ghost_fill),
              label: 'Status',
            ),
          ],
        ),
      ),
      body: ILazyIndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(),
          StatusPage(),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Buttons(),
        CardsWidget(),
        ListItemWidget(),
        ListItemSeparated(),
        ModalsWidget(),
      ],
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
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            IButton.pill(
              child: Text('Pill Button'),
              onPressed: () {},
            ),
            IButton.pill(
              child: Text('Disabled Pill'),
            ),
            IButton.pill(
              statusType: StatusType.success,
              child: Text('Success Pill'),
              onPressed: () {},
            ),
            IButton.pill(
              statusType: StatusType.error,
              child: Text('Error Pill'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class CardsWidget extends StatelessWidget {
  const CardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IBoundedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IListItem(title: Text('Cards')),
          Padding(
            padding: const EdgeInsets.only(
              left: InfinityDimens.largePadding,
              right: InfinityDimens.largePadding,
              bottom: InfinityDimens.padding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ICard(
                      child: Center(child: Text('Card 1')),
                    ),
                  ),
                ),
                const SizedBox(width: InfinityDimens.largePadding),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ICard(
                      child: Center(child: Text('Card 2')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

class ListItemSeparated extends StatelessWidget {
  const ListItemSeparated({super.key});

  @override
  Widget build(BuildContext context) {
    return IBoxedList.separated(
      title: const Text('Separated Items'),
      children: [
        IListItem(title: const Text('First Item')),
        IListItem(title: const Text('Second Item')),
        IListItem(title: const Text('Third Item')),
      ],
    );
  }
}

class ModalsWidget extends StatelessWidget {
  const ModalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IBoxedList(
      title: const Text('Modals'),
      children: [
        SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              IButton.text(
                text: 'Modal',
                onPressed: () {
                  showModal(
                    context: context,
                    pageListBuilder: (final BuildContext context) {
                      return <SliverWoltModalSheetPage>[
                        IModalSheetPage(
                          hasTopBarLayer: false,
                          child: IBoxedList(
                            title: const Text('Items'),
                            children: [
                              IListItem(title: const Text('First Item')),
                              IListItem(title: const Text('Second Item')),
                              IListItem(title: const Text('Third Item')),
                            ],
                          ),
                        ),
                      ];
                    },
                  );
                },
              ),
              IButton.text(
                text: 'Dialog Modal',
                onPressed: () {
                  showDialogModal(
                    context: context,
                    pageListBuilder: (final BuildContext context) {
                      return <SliverWoltModalSheetPage>[
                        IModalSheetPage(
                          hasTopBarLayer: false,
                          child: IBoxedList(
                            title: const Text('Items'),
                            children: [
                              IListItem(title: const Text('First Item')),
                              IListItem(title: const Text('Second Item')),
                              IListItem(title: const Text('Third Item')),
                            ],
                          ),
                        ),
                      ];
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IBoundedBox(
      child: IStatusPage(
        icon: MingCuteIcons.mgc_search_line,
        title: 'No Results Found',
        subtitle: 'Try a different search',
      ),
    );
  }
}
