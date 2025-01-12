import 'package:url_launcher/url_launcher.dart';

/// Launches the given url in the default browser.
Future<void> urlLauncher(final String? url) async {
  if (url == null) {
    return;
  }
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }
}
