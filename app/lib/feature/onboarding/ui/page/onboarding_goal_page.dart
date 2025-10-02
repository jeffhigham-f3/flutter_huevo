import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/logger/loggy_types.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/onboarding/bloc/onboarding_cubit.dart';
import 'package:flutter_huevo/feature/onboarding/ui/widget/onboarding_answer.dart';
import 'package:flutter_huevo/feature/onboarding/ui/widget/onboarding_navigation.dart';
import 'package:flutter_huevo/feature/onboarding/ui/widget/onboarding_progress.dart';
import 'package:flutter_huevo/feature/user/model/user_goal.dart';

class OnboardingGoalPage extends StatelessWidget
    with OnboardingNavigation, UiLoggy {
  const OnboardingGoalPage({super.key});

  @override
  AppRoute get route => AppRoute.onboardingGoal;

  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.watch<OnboardingCubit>();
    final selectedGoals = onboardingCubit.state.goals;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OnboardingProgress(progress: getProgress()),
              const SizedBox(height: 48),
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      context.l10n.onboardingGoalTitle,
                      style: context.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 24),
                    for (final goal in UserGoal.values)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: OnboardingAnswer(
                          title: goal.getText(context),
                          selectedDescription: goal.getDescription(context),
                          isSelected: selectedGoals.contains(goal),
                          onTap: () => onboardingCubit.toggleGoal(goal),
                        ),
                      ),
                    Text(
                      context.l10n.canSelectMultipleLabel,
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: selectedGoals.isEmpty
                    ? null
                    : () => _onContinue(context, selectedGoals),
                child: Text(context.l10n.continueAction),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onContinue(BuildContext context, List<UserGoal> goals) {
    context.analytics.logEvent(AnalyticsEvent.goalsSelected, {
      'goals': goals.map((e) => e.id).toList(),
    });
    goToNextOnboardingPage(context);
  }
}
