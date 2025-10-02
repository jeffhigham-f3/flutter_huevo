part of 'onboarding_cubit.dart';

@immutable
class OnboardingState {
  const OnboardingState({required this.goals});

  const OnboardingState.initial() : this(goals: const []);

  final List<UserGoal> goals;

  OnboardingState copyWith({List<UserGoal>? goals}) {
    return OnboardingState(goals: goals ?? this.goals);
  }
}
