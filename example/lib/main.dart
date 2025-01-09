import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

import 'bounded_page.dart';
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
    return IResponsiveScaffold(
      headerBarBuilder: (
        final BuildContext context,
        final ResponsiveStates state,
      ) {
        final ITabBar tabBar = ITabBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (final int index) {
            setState(() => _selectedIndex = index);
          },
          tabs: <ITabItem>[
            ITabItem(
              icon: const Icon(MingCuteIcons.mgc_presentation_1_line),
              selectedIcon: const Icon(MingCuteIcons.mgc_presentation_1_fill),
              label: 'Welcome',
            ),
            ITabItem(
              icon: const Icon(MingCuteIcons.mgc_spacing_horizontal_line),
              selectedIcon:
                  const Icon(MingCuteIcons.mgc_spacing_horizontal_fill),
              label: 'Bounded',
            ),
            ITabItem(
              icon: const Icon(MingCuteIcons.mgc_rows_4_line),
              selectedIcon: const Icon(MingCuteIcons.mgc_rows_4_fill),
              label: 'Rows',
            ),
            ITabItem(
              icon: const Icon(MingCuteIcons.mgc_home_1_line),
              selectedIcon: const Icon(MingCuteIcons.mgc_home_1_fill),
              label: 'Home',
            ),
          ],
        );

        return IHeaderBar(
          middle: const Text('Showcase'),
          trailing: <Widget>[
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
          bottom: switch (state) {
            ResponsiveStates.collapsed => null,
            ResponsiveStates.extended => tabBar,
            ResponsiveStates.fullExtended => tabBar,
          },
        );
      },
      childWidgetBuilder: (
        final BuildContext context,
        final ResponsiveStates state,
      ) {
        return ILazyIndexedStack(
          index: _selectedIndex,
          children: const <Widget>[
            WelcomePage(),
            BoundedPage(),
            ListsPage(),
            HomePage(),
          ],
        );
      },
      bottomWidgetBuilder: (
        final BuildContext context,
        final ResponsiveStates state,
      ) {
        final IBottomTabBar bottomTabBar = IBottomTabBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (final int index) {
            setState(() => _selectedIndex = index);
          },
          tabs: <ITabItem>[
            ITabItem(
              icon: const Icon(MingCuteIcons.mgc_presentation_1_line),
              selectedIcon: const Icon(MingCuteIcons.mgc_presentation_1_fill),
              label: 'Welcome',
            ),
            ITabItem(
              icon: const Icon(MingCuteIcons.mgc_spacing_horizontal_line),
              selectedIcon:
                  const Icon(MingCuteIcons.mgc_spacing_horizontal_fill),
              label: 'Bounded',
            ),
            ITabItem(
              icon: const Icon(MingCuteIcons.mgc_rows_4_line),
              selectedIcon: const Icon(MingCuteIcons.mgc_rows_4_fill),
              label: 'Rows',
            ),
            ITabItem(
              icon: const Icon(MingCuteIcons.mgc_home_1_line),
              selectedIcon: const Icon(MingCuteIcons.mgc_home_1_fill),
              label: 'Home',
            ),
          ],
        );
        return switch (state) {
          ResponsiveStates.collapsed => bottomTabBar,
          ResponsiveStates.extended => null,
          ResponsiveStates.fullExtended => null,
        };
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListView(
      children: const <Widget>[
        Buttons(),
        CardsWidget(),
        ModalsWidget(),
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
                    child: ICard(
                      child: Center(child: Text('Card 1')),
                    ),
                  ),
                ),
                SizedBox(width: InfinityDimens.largePadding),
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
