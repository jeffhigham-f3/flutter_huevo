import 'package:collection/collection.dart';
import 'package:flutter_huevo/core/logger/logger.dart';

enum NotificationAction {
  showFeedbackPage('show_feedback_page');

  const NotificationAction(this.type);

  final String type;

  static NotificationAction? fromType(String type) {
    return NotificationAction.values.firstWhereOrNull((e) => e.type == type);
  }

  static NotificationAction? fromPayload(Map<String, dynamic> payload) {
    final type = payload['type'] as String?;
    if (type == null) {
      logWarning('unexpected notification: $payload');
      return null;
    }

    final action = NotificationAction.fromType(type);
    if (action == null) {
      logWarning('unexpected action: $payload');
      return null;
    }

    return action;
  }
}
