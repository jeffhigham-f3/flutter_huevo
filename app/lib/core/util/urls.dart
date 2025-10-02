import 'package:flutter_huevo/core/app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Urls {
  Urls._();

  static void showTermsOfService() => _show(termsOfServiceUrl);

  static void showPrivacyPolicy() => _show(privacyPolicyUrl);

  static void _show(String url) {
    launchUrl(Uri.parse(url));
  }
}
