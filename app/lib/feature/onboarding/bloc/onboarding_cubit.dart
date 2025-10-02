import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/logger/loggy_types.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/analytics/repository/analytics_repository.dart';
import 'package:flutter_huevo/feature/user/model/user_goal.dart';
import 'package:flutter_huevo/feature/user/repository/user_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> with BlocLoggy {
  OnboardingCubit({
    required this.analyticsRepository,
    required this.userRepository,
  }) : super(const OnboardingState.initial());

  final AnalyticsRepository analyticsRepository;
  final UserRepository userRepository;

  void start() {
    analyticsRepository.logEvent(AnalyticsEvent.onboardingStarted);
    emit(const OnboardingState.initial());
  }

  void toggleGoal(UserGoal goal) {
    final goals = List<UserGoal>.from(state.goals);
    if (goals.contains(goal)) {
      goals.remove(goal);
    } else {
      goals.add(goal);
    }

    emit(state.copyWith(goals: goals));
  }

  Future<void> complete({required List<UserGoal> goals}) async {
    analyticsRepository.logEvent(AnalyticsEvent.onboardingCompleted);

    loggy.info('complete: Saving user data...');
    await userRepository.setOnboardingCompleted(goals: goals);
    loggy.info('complete: done');
  }
}
