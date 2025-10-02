import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:flutter_huevo/core/app/constants.dart';
import 'package:flutter_huevo/feature/analytics/model/auth_method.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/analytics/provider/base_analytics_provider.dart';
import 'package:flutter_huevo/feature/analytics/provider/mixpanel_observer.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';

class MixpanelAnalyticsProvider extends BaseAnalyticsProvider {
  static late final Mixpanel _mixpanel;

  static Future<void> init() async {
    _mixpanel = await Mixpanel.init(mixpanelToken, trackAutomaticEvents: true);

    // Enable logging in debug mode
    _mixpanel.setLoggingEnabled(!kReleaseMode);

    // Uncomment to track only in release
    // if (!kReleaseMode) {
    //   await _mixpanel.flush();
    //   _mixpanel.optOutTracking();
    // }
  }

  @override
  List<NavigatorObserver> getObservers() => [MixpanelObserver(_mixpanel)];

  @override
  void setUser(User user) {
    _mixpanel.identify(user.id);
    _mixpanel.getPeople()
      ..set('Name', user.name)
      ..set('Email', user.email);
  }

  @override
  void onSignOut() {
    _mixpanel
      ..track('Sign Out')
      ..reset();
  }

  @override
  void logSignIn({required AuthMethod method}) {
    _mixpanel.track('Sign In', properties: {'Method': method.id});
  }

  @override
  void logSignUp({required AuthMethod method}) {
    _mixpanel.track('Sign Up', properties: {'Method': method.id});
  }

  @override
  void logEvent(AnalyticsEvent event, [Map<String, Object>? parameters]) {
    _mixpanel.track(event.id, properties: parameters);
  }
}
