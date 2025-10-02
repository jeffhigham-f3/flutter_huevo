import 'package:flutter/widgets.dart';
import 'package:flutter_huevo/core/logger/loggy_types.dart';
import 'package:flutter_huevo/feature/analytics/model/auth_method.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/analytics/provider/base_analytics_provider.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';

class AnalyticsRepository extends BaseAnalyticsProvider with RepositoryLoggy {
  const AnalyticsRepository({required this.providers});

  final List<BaseAnalyticsProvider> providers;

  @override
  List<NavigatorObserver> getObservers() {
    return [for (final provider in providers) ...provider.getObservers()];
  }

  @override
  void setUser(User user) {
    _all((p) => p.setUser(user));
  }

  @override
  void onSignOut() {
    _all((p) => p.onSignOut());
  }

  @override
  void logSignIn({required AuthMethod method}) {
    _all((p) => p.logSignIn(method: method));
  }

  @override
  void logSignUp({required AuthMethod method}) {
    _all((p) => p.logSignUp(method: method));
  }

  @override
  void logEvent(AnalyticsEvent event, [Map<String, Object>? parameters]) {
    _all((p) => p.logEvent(event, parameters));
  }

  void _all(void Function(BaseAnalyticsProvider p) action) {
    providers.forEach(action);
  }
}
