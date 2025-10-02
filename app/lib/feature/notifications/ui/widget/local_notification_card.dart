import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/feature/explore/ui/widget/explore_card.dart';
import 'package:flutter_huevo/feature/notifications/bloc/notifications_cubit.dart';
import 'package:flutter_huevo/feature/notifications/model/notification_action.dart';
import 'package:flutter_huevo/feature/notifications/model/notification_metadata.dart';

class LocalNotificationCard extends StatelessWidget {
  const LocalNotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExploreCard(
      title: context.l10n.localNotifications,
      content: Text(context.l10n.localNotificationsDescription),
      action: FilledButton(
        onPressed: () => _showLocalNotification(context),
        child: Text(context.l10n.show),
      ),
    );
  }

  Future<void> _showLocalNotification(BuildContext context) async {
    context.read<NotificationsCubit>().showLocalNotification(
      id: 0,
      title: context.l10n.localNotifications,
      message: 'This is a notification. Tap to open the feedback page.',
      metadata: const DefaultNotificationMetadata(),
      payload: {'type': NotificationAction.showFeedbackPage.type},
    );
  }
}
