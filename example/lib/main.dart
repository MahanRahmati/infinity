import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

import 'bounded_page.dart';
import 'buttons_page.dart';
import 'calendar_page.dart';
import 'gauge_page.dart';
import 'lists_page.dart';
import 'welcome_page.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: InfinityTheme.light(),
      darkTheme: InfinityTheme.dark(),
      home: const ExampleHome(),
    );
  }
}

enum Pages { welcome, bounded, lists, buttons, calendar, gauge, home }

class ExampleHome extends StatefulWidget {
  const ExampleHome({super.key});

  @override
  State<ExampleHome> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  static Future<String> getLicense() async {
    try {
      return await rootBundle.loadString('LICENSE');
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(final BuildContext context) {
    return IMasterDetailPage<Pages>(
      items: Pages.values,
      initialItem: Pages.welcome,
      masterMiddle: const Text('Showcase'),
      masterTrailing: <Widget>[
        IButton.icon(
          icon: MingCuteIcons.mgc_information_line,
          isTransparent: true,
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
                const Icon(
                  MingCuteIcons.mgc_presentation_1_line,
                  size: InfinityDimens.appIconSize,
                ),
                size: InfinityDimens.appIconSize,
              ),
              developers: <String>['Mahan Rahmati'],
              website: 'https://github.com/MahanRahmati/infinity',
              issueUrl: 'https://github.com/MahanRahmati/infinity/issues',
              license: license,
            );
          },
        ),
      ],
      masterBuilder: (context, selectedItem, onItemSelected) {
        return ListView(
          children: <Widget>[
            IBoxedList(
              children: <Widget>[
                IListItem(
                  leading: Icon(
                    selectedItem == Pages.welcome
                        ? MingCuteIcons.mgc_presentation_1_fill
                        : MingCuteIcons.mgc_presentation_1_line,
                  ),
                  title: const Text('Welcome'),
                  onPressed: () {
                    onItemSelected(Pages.welcome);
                  },
                ),
                IListItem(
                  leading: Icon(
                    selectedItem == Pages.bounded
                        ? MingCuteIcons.mgc_spacing_horizontal_fill
                        : MingCuteIcons.mgc_spacing_horizontal_line,
                  ),
                  title: const Text('Bounded'),
                  onPressed: () {
                    onItemSelected(Pages.bounded);
                  },
                ),
                IListItem(
                  leading: Icon(
                    selectedItem == Pages.lists
                        ? MingCuteIcons.mgc_rows_4_fill
                        : MingCuteIcons.mgc_rows_4_line,
                  ),
                  title: const Text('Lists'),
                  onPressed: () {
                    onItemSelected(Pages.lists);
                  },
                ),
                IListItem(
                  leading: Icon(
                    selectedItem == Pages.buttons
                        ? MingCuteIcons.mgc_star_fill
                        : MingCuteIcons.mgc_star_line,
                  ),
                  title: const Text('Buttons'),
                  onPressed: () {
                    onItemSelected(Pages.buttons);
                  },
                ),
                IListItem(
                  leading: Icon(
                    selectedItem == Pages.calendar
                        ? MingCuteIcons.mgc_calendar_fill
                        : MingCuteIcons.mgc_calendar_line,
                  ),
                  title: const Text('Calendar'),
                  onPressed: () {
                    onItemSelected(Pages.calendar);
                  },
                ),
                IListItem(
                  leading: Icon(
                    selectedItem == Pages.gauge
                        ? MingCuteIcons.mgc_dashboard_2_fill
                        : MingCuteIcons.mgc_dashboard_2_line,
                  ),
                  title: const Text('Gauge'),
                  onPressed: () {
                    onItemSelected(Pages.gauge);
                  },
                ),
                IListItem(
                  leading: Icon(
                    selectedItem == Pages.home
                        ? MingCuteIcons.mgc_home_1_fill
                        : MingCuteIcons.mgc_home_1_line,
                  ),
                  title: const Text('Home'),
                  onPressed: () {
                    onItemSelected(Pages.home);
                  },
                ),
              ],
            ),
          ],
        );
      },
      detailHeaderMiddleBuilder: (
        final BuildContext context,
        final Pages item,
      ) {
        final String title = switch (item) {
          Pages.welcome => 'Welcome',
          Pages.bounded => 'Bounded',
          Pages.lists => 'Lists',
          Pages.buttons => 'Buttons',
          Pages.calendar => 'Calendar',
          Pages.gauge => 'Gauge',
          Pages.home => 'Home',
        };
        return Text(title);
      },
      detailBuilder: (final BuildContext context, final Pages item) {
        final Widget detail = switch (item) {
          Pages.welcome => const WelcomePage(),
          Pages.bounded => const BoundedPage(),
          Pages.lists => const ListsPage(),
          Pages.buttons => const ButtonsPage(),
          Pages.calendar => const CalendarPage(),
          Pages.gauge => const GaugePage(),
          Pages.home => const HomePage(),
        };
        return detail;
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView(
      children: <Widget>[
        CardsWidget(),
        ModalsWidget(),
      ],
    );
  }
}

class CardsWidget extends StatelessWidget {
  const CardsWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return const IBoundedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IListItem(title: Text('Cards')),
          Padding(
            padding: EdgeInsets.only(
              left: InfinityDimens.largePadding,
              right: InfinityDimens.largePadding,
              bottom: InfinityDimens.padding,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ICard(child: Center(child: Text('Card 1'))),
                  ),
                ),
                SizedBox(width: InfinityDimens.largePadding),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ICard(child: Center(child: Text('Card 2'))),
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

class ModalsWidget extends StatelessWidget {
  const ModalsWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return IBoxedList(
      title: const Text('Modals'),
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
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
                            children: const <Widget>[
                              IListItem(title: Text('First Item')),
                              IListItem(title: Text('Second Item')),
                              IListItem(title: Text('Third Item')),
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
                            children: const <Widget>[
                              IListItem(title: Text('First Item')),
                              IListItem(title: Text('Second Item')),
                              IListItem(title: Text('Third Item')),
                            ],
                          ),
                        ),
                      ];
                    },
                  );
                },
              ),
              IButton.text(
                text: 'Message Dialog Modal',
                onPressed: () {
                  showDialogModal(
                    context: context,
                    pageListBuilder: (final BuildContext context) {
                      return <SliverWoltModalSheetPage>[
                        IModalSheetPage(
                          hasTopBarLayer: false,
                          child: IMessageDialog(
                            title: 'Message',
                            description: 'This is a message dialog',
                            actions: <Widget>[
                              IButton.filled(
                                statusType: StatusType.success,
                                onPressed: Navigator.of(context).pop,
                                child: const Text('OK'),
                              ),
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
