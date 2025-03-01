import 'package:infinity_widgets/infinity_widgets.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return const IStatusPage(
      icon: MingCuteIcons.mgc_presentation_1_line,
      title: 'Welcome to Infinity Showcase',
      subtitle: 'This is a tour of the Infinity widgets',
    );
  }
}
