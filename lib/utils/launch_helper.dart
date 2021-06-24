import 'package:url_launcher/url_launcher.dart';

class LaunchHelper {
  void launchUrl({required String url}) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }
}
