import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/app/assets.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/core/ui/widget/app_logo.dart';
import 'package:flutter_huevo/feature/onboarding/ui/widget/onboarding_navigation.dart';

class OnboardingWelcomePage extends StatelessWidget with OnboardingNavigation {
  const OnboardingWelcomePage({super.key});

  @override
  AppRoute get route => AppRoute.onboardingWelcome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const AppLogo(size: 120),
              const SizedBox(height: 32),
              Text(
                context.l10n.welcomeTitle,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineMedium,
              ),
              const Spacer(),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.laurelLeft,
                    height: 76,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: context.l10n.welcomeProof1,
                      style: context.textTheme.labelMedium,
                      children: [
                        TextSpan(
                          text: context.l10n.welcomeProof2,
                          style: context.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    AppAssets.laurelRight,
                    height: 76,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: () => goToNextOnboardingPage(context),
                child: Text(context.l10n.getStarted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
