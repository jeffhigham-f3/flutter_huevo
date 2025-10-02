import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:flutter_huevo/core/extension/context_app_entitlements.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/feature/onboarding/bloc/onboarding_cubit.dart';
import 'package:flutter_huevo/feature/payment/model/paywall_placement.dart';

const _onboardingRoutes = [
  AppRoute.onboardingWelcome,
  AppRoute.onboardingExplanation,
  AppRoute.onboardingGoal,
  AppRoute.onboardingPreparation,
  AppRoute.paywall,
];

AppRoute getFirstOnboardingRoute() => _onboardingRoutes.first;

bool isOnboardingRoute(AppRoute route) {
  return _onboardingRoutes.contains(route);
}

mixin OnboardingNavigation {
  AppRoute get route;

  double getProgress() =>
      _onboardingRoutes.indexOf(route) / (_onboardingRoutes.length - 1);

  Future<void> goToNextOnboardingPage(
    BuildContext context, [
    Map<String, String>? params,
  ]) async {
    params ??= {};

    final index = _onboardingRoutes.indexOf(route);
    if (index < 0) {
      throw ArgumentError('Route $route is not a valid onboarding route.');
    }

    if (index == _onboardingRoutes.length - 1) {
      logInfo('Onboarding finished, going home...');
      AppRoute.home.go(context);
      return;
    }

    final nextRoute = _onboardingRoutes[index + 1];
    if (nextRoute == AppRoute.paywall) {
      logInfo('Saving onboarding data & going to paywall...');
      await _saveOnboardingData(context);
      if (!context.mounted) {
        return;
      }

      if (context.getAppEntitlements?.pro ?? false) {
        // Onboarding finished, go home
        logInfo('Has pro access. Skipping paywall and going home...');
        AppRoute.home.go(context);
        return;
      }

      // Paywall is the last onboarding step
      params['placement'] = PaywallPlacement.onboarding.id;
    }

    logInfo('Going to next onboarding page: ${nextRoute.name}');
    nextRoute.go(context, params: params);
  }

  Future<void> _saveOnboardingData(BuildContext context) async {
    final onboardingCubit = context.read<OnboardingCubit>();
    final onboardingState = onboardingCubit.state;
    final goals = onboardingState.goals;

    await onboardingCubit.complete(goals: goals);
  }
}
