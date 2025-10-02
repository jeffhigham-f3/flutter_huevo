import 'package:flutter/material.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixpanelObserver extends NavigatorObserver {
  MixpanelObserver(this.mixpanel);

  final Mixpanel mixpanel;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _trackScreen(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _trackScreen(newRoute);
    }

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _trackScreen(Route<dynamic> route) {
    if (route.settings.name != null) {
      mixpanel.track('page_viewed', properties: {'page': route.settings.name});
    }
  }
}
