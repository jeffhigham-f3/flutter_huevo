import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/extension/context_user.dart';
import 'package:flutter_huevo/core/logger/loggy_types.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/feature/auth/bloc/auth_cubit.dart';
import 'package:flutter_huevo/feature/onboarding/ui/widget/onboarding_navigation.dart';
import 'package:flutter_huevo/feature/user/bloc/user_cubit.dart';

class OnboardingPreparationPage extends StatefulWidget {
  const OnboardingPreparationPage({super.key});

  @override
  State<OnboardingPreparationPage> createState() =>
      _OnboardingPreparationPageState();
}

class _OnboardingPreparationPageState extends State<OnboardingPreparationPage>
    with OnboardingNavigation, UiLoggy {
  @override
  AppRoute get route => AppRoute.onboardingPreparation;

  @override
  void initState() {
    super.initState();

    final user = context.getCurrentUser;
    if (user != null) {
      loggy.info('User already exists: ${user.id}');
      _onUserLoaded();
    } else {
      loggy.info('No user found, signing in anonymously...');
      context.read<AuthCubit>().signInAnonymously();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: _onAuthState,
      child: BlocListener<UserCubit, UserState>(
        listenWhen: _whenUserStateLoaded,
        listener: _onUserState,
        child: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 32),
                  Text(
                    context.l10n.onboardingPreparationTitle,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (state is AuthFailure) {
      context.showSnackBarMessage(
        state.exception.getText(context),
        isError: true,
      );

      return;
    }
  }

  bool _whenUserStateLoaded(UserState previous, UserState current) {
    final previousUser = previous is UserLoaded ? previous.user : null;
    final previousUserLoaded = previousUser?.isLoaded ?? false;
    final currentUser = current is UserLoaded ? current.user : null;
    final currentUserLoaded = currentUser?.isLoaded ?? false;

    return !previousUserLoaded && currentUserLoaded;
  }

  Future<void> _onUserState(BuildContext context, UserState state) async {
    if (state is! UserLoaded) {
      return;
    }

    final user = state.user;
    if (user == null) {
      return;
    }

    loggy.info('Anonymous user loaded: ${user.id}');
    _onUserLoaded();
  }

  void _onUserLoaded() {
    goToNextOnboardingPage(context);
  }
}
