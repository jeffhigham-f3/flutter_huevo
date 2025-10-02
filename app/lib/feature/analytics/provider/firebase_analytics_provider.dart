import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_huevo/core/logger/loggy_types.dart';
import 'package:flutter_huevo/feature/analytics/model/auth_method.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/analytics/provider/base_analytics_provider.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';

class FirebaseAnalyticsProvider extends BaseAnalyticsProvider
    with ProviderLoggy {
  final _analytics = FirebaseAnalytics.instance;

  @override
  List<NavigatorObserver> getObservers() {
    return [FirebaseAnalyticsObserver(analytics: _analytics)];
  }

  @override
  void setUser(User user) {
    _analytics
      ..setUserId(id: user.id)
      ..setUserProperty(name: 'name', value: user.name)
      ..setUserProperty(name: 'email', value: user.email);
  }

  @override
  void onSignOut() {
    _analytics.setUserId(id: null);
  }

  @override
  void logSignIn({required AuthMethod method}) {
    _analytics.logLogin(loginMethod: method.id);
  }

  @override
  void logSignUp({required AuthMethod method}) {
    _analytics.logSignUp(signUpMethod: method.id);
  }

  @override
  void logEvent(AnalyticsEvent event, [Map<String, Object>? parameters]) {
    if (parameters != null) {
      // Map list params to a comma-separated string
      for (final key in parameters.keys) {
        if (parameters[key] is List) {
          parameters[key] = (parameters[key]! as List).join(',');
        }
      }
    }

    _analytics.logEvent(name: event.id, parameters: parameters);
  }
}
