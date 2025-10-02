enum AnalyticsEvent {
  // Onboarding
  onboardingStarted('onboarding_started'),
  goalsSelected('goals_selected'),
  onboardingCompleted('onboarding_completed'),

  // Notifications
  notificationTap('notification_tap'),

  // Payment
  paywallShown('paywall_shown'),

  // Settings
  deleteAccount('delete_account'),

  // Article
  articleAdded('article_added');

  const AnalyticsEvent(this.id);

  final String id;
}
