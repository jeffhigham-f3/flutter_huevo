import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/extension/context_user.dart';
import 'package:flutter_huevo/core/logger/logger.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/analytics/repository/analytics_repository.dart';
import 'package:flutter_huevo/feature/article/bloc/article_add_cubit.dart';
import 'package:flutter_huevo/feature/article/bloc/articles_cubit.dart';
import 'package:flutter_huevo/feature/article/repository/article_repository.dart';
import 'package:flutter_huevo/feature/article/ui/page/article_add_page.dart';
import 'package:flutter_huevo/feature/auth/bloc/auth_cubit.dart';
import 'package:flutter_huevo/feature/auth/repository/auth_repository.dart';
import 'package:flutter_huevo/feature/auth/ui/page/auth_page.dart';
import 'package:flutter_huevo/feature/auth/ui/page/splash_page.dart';
import 'package:flutter_huevo/feature/home/ui/page/home_page.dart';
import 'package:flutter_huevo/feature/onboarding/bloc/onboarding_cubit.dart';
import 'package:flutter_huevo/feature/onboarding/ui/page/onboarding_explanation_page.dart';
import 'package:flutter_huevo/feature/onboarding/ui/page/onboarding_goal_page.dart';
import 'package:flutter_huevo/feature/onboarding/ui/page/onboarding_preparation_page.dart';
import 'package:flutter_huevo/feature/onboarding/ui/page/onboarding_welcome_page.dart';
import 'package:flutter_huevo/feature/onboarding/ui/widget/onboarding_navigation.dart';
import 'package:flutter_huevo/feature/payment/bloc/paywall_cubit.dart';
import 'package:flutter_huevo/feature/payment/bloc/purchase_cubit.dart';
import 'package:flutter_huevo/feature/payment/repository/payment_repository.dart';
import 'package:flutter_huevo/feature/payment/ui/page/paywall_page.dart';
import 'package:flutter_huevo/feature/payment/ui/page/paywall_success_page.dart';
import 'package:flutter_huevo/feature/settings/bloc/send_feedback_cubit.dart';
import 'package:flutter_huevo/feature/settings/repository/feedback_repository.dart';
import 'package:flutter_huevo/feature/settings/ui/page/send_feedback_page.dart';
import 'package:flutter_huevo/feature/settings/ui/page/settings_page.dart';

GoRouter getRouter({required List<NavigatorObserver> observers}) {
  return GoRouter(
    redirect: (context, state) {
      final path = state.fullPath ?? AppRoute.splash.path;

      if (path == AppRoute.splash.path) {
        // Don't redirect from splash page
        return null;
      }

      final user = context.getCurrentUser;
      final appRoute = AppRoute.fromPath(path);

      if (appRoute.isProtected && user == null) {
        logInfo('No user - redirecting to onboarding page.');
        return getFirstOnboardingRoute().path;
      }

      return null;
    },
    observers: observers,
    routes: [
      // Onboarding
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoute.onboardingWelcome.path,
        name: AppRoute.onboardingWelcome.name,
        builder: (context, state) {
          context.read<OnboardingCubit>().start();
          return const OnboardingWelcomePage();
        },
      ),
      GoRoute(
        path: AppRoute.onboardingExplanation.path,
        name: AppRoute.onboardingExplanation.name,
        builder: (context, state) => const OnboardingExplanationPage(),
      ),
      GoRoute(
        path: AppRoute.onboardingGoal.path,
        name: AppRoute.onboardingGoal.name,
        builder: (context, state) => const OnboardingGoalPage(),
      ),
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        builder: (context, state) {
          final encodedToRoute = state.uri.queryParameters['toRoute'];
          final toRoute = encodedToRoute != null
              ? Uri.decodeQueryComponent(encodedToRoute)
              : null;

          return BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
              analyticsRepository: context.read<AnalyticsRepository>(),
            ),
            child: AuthPage(toRoute: toRoute),
          );
        },
      ),
      GoRoute(
        path: AppRoute.paywall.path,
        name: AppRoute.paywall.name,
        builder: (context, state) {
          final placement = state.uri.queryParameters['placement'];
          if (placement == null) {
            logError('Paywall placement is null');
          } else {
            logInfo('Showing paywall for placement: $placement');
            context.analytics.logEvent(AnalyticsEvent.paywallShown, {
              'placement': placement,
            });
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PaywallCubit(
                  paymentRepository: context.read<PaymentRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => PurchaseCubit(
                  paymentRepository: context.read<PaymentRepository>(),
                ),
              ),
            ],
            child: const PaywallPage(),
          );
        },
      ),
      GoRoute(
        path: AppRoute.paywallSuccess.path,
        name: AppRoute.paywallSuccess.name,
        builder: (context, state) => const PaywallSuccessPage(),
      ),
      GoRoute(
        path: AppRoute.onboardingPreparation.path,
        name: AppRoute.onboardingPreparation.name,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
              analyticsRepository: context.read<AnalyticsRepository>(),
            ),
            child: const OnboardingPreparationPage(),
          );
        },
      ),

      // Home
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => BlocProvider(
          create: (context) => ArticlesCubit(
            articleRepository: context.read<ArticleRepository>(),
          ),
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: AppRoute.settings.path,
        name: AppRoute.settings.name,
        builder: (context, state) => const SettingsPage(),
      ),

      // Article
      GoRoute(
        path: AppRoute.articleAdd.path,
        name: AppRoute.articleAdd.name,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ArticleAddCubit(
              articleRepository: context.read<ArticleRepository>(),
              analyticsRepository: context.read<AnalyticsRepository>(),
            ),
            child: const ArticleAddPage(),
          );
        },
      ),

      // Feedback
      GoRoute(
        path: AppRoute.sendFeedback.path,
        name: AppRoute.sendFeedback.name,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => SendFeedbackCubit(
              feedbackRepository: context.read<FeedbackRepository>(),
            ),
            child: const SendFeedbackPage(),
          );
        },
      ),
    ],
  );
}
