import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/extension/context_app_config.dart';
import 'package:flutter_huevo/core/extension/context_user.dart';
import 'package:flutter_huevo/feature/connectivity/ui/widget/connectivity_card.dart';
import 'package:flutter_huevo/feature/explore/ui/widget/flavor_card.dart';
import 'package:flutter_huevo/feature/notifications/ui/widget/local_notification_card.dart';
import 'package:flutter_huevo/feature/notifications/ui/widget/remote_notification_card.dart';
import 'package:flutter_huevo/feature/payment/ui/widget/paywall_card.dart';
import 'package:flutter_huevo/feature/settings/ui/widget/app_review_card.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = context.watchAppConfig;
    final showAppReviewCard = appConfig?.showAppReviewCard ?? false;
    final user = context.watchCurrentUser;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const FlavorCard(),
        const ConnectivityCard(),
        const PaywallCard(),
        if (!kIsWeb) ...[
          if (showAppReviewCard) const AppReviewCard(),
          const LocalNotificationCard(),
          if (user != null) const RemoteNotificationCard(),
        ],
      ],
    );
  }
}
