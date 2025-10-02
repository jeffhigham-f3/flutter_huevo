import 'package:flutter/widgets.dart';
import 'package:flutter_huevo/feature/analytics/model/auth_method.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';

abstract class BaseAnalyticsProvider {
  const BaseAnalyticsProvider();

  List<NavigatorObserver> getObservers() => const [];

  void setUser(User user);

  void onSignOut();

  void logSignUp({required AuthMethod method});

  void logSignIn({required AuthMethod method});

  void logEvent(AnalyticsEvent event, [Map<String, Object>? parameters]);
}
