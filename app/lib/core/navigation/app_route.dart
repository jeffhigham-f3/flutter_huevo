import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  // Onboarding
  splash('/', 'splash'),
  onboardingWelcome(
    '/onboardingWelcome',
    'onboardingWelcome',
    isProtected: false,
  ),
  onboardingExplanation(
    '/onboardingExplanation',
    'onboardingExplanation',
    isProtected: false,
  ),
  onboardingGoal('/onboardingGoal', 'onboardingGoal', isProtected: false),
  auth('/auth', 'auth'),
  paywall('/paywall', 'paywall'),
  paywallSuccess('/paywallSuccess', 'paywallSuccess'),
  onboardingPreparation(
    '/onboardingPreparation',
    'onboardingPreparation',
    isProtected: false,
  ),

  // Home
  home('/home', 'home'),
  settings('/settings', 'settings'),

  // Feedback
  sendFeedback('/sendFeedback', 'sendFeedback'),

  // Articles
  articleAdd('/articleAdd', 'articleAdd');

  const AppRoute(this.path, this.name, {this.isProtected = true});

  factory AppRoute.fromPath(String path) {
    return AppRoute.values.firstWhere((route) => route.path == path);
  }

  final String path;
  final String name;
  final bool isProtected;
}

extension AppRouteNavigation on AppRoute {
  void go(BuildContext context, {Map<String, dynamic> params = const {}}) =>
      context.goNamed(
        name,
        queryParameters: {...params, if (isProtected) 'toRoute': path},
      );

  void push(BuildContext context, {Map<String, dynamic> params = const {}}) =>
      context.pushNamed(
        name,
        queryParameters: {...params, if (isProtected) 'toRoute': path},
      );

  void pushReplacement(
    BuildContext context, {
    Map<String, dynamic> params = const {},
  }) => context.pushReplacementNamed(
    name,
    queryParameters: {...params, if (isProtected) 'toRoute': path},
  );
}
