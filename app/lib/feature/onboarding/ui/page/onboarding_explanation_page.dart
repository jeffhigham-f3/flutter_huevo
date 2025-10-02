import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/core/ui/widget/page_indicator.dart';
import 'package:flutter_huevo/feature/onboarding/ui/widget/onboarding_navigation.dart';

class OnboardingExplanationPage extends StatefulWidget {
  const OnboardingExplanationPage({super.key});

  @override
  State<OnboardingExplanationPage> createState() =>
      _OnboardingExplanationPageState();
}

class _OnboardingExplanationPageState extends State<OnboardingExplanationPage>
    with OnboardingNavigation {
  final _pageController = PageController();
  int _currentIndex = 0;

  @override
  AppRoute get route => AppRoute.onboardingExplanation;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _Content(
        image: const _OnboardingImage(Icons.rocket_launch),
        title: context.l10n.onboardingExplanationTitle1,
        subtitle: context.l10n.onboardingExplanationSubtitle1,
      ),
      _Content(
        image: const _OnboardingImage(Icons.widgets),
        title: context.l10n.onboardingExplanationTitle2,
        subtitle: context.l10n.onboardingExplanationSubtitle2,
      ),
      _Content(
        image: const _OnboardingImage(Icons.center_focus_strong),
        title: context.l10n.onboardingExplanationTitle3,
        subtitle: context.l10n.onboardingExplanationSubtitle3,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) => pages[index],
              ),
            ),
            Center(
              child: PageIndicator(current: _currentIndex, total: pages.length),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                onPressed: _onContinue,
                child: Text(context.l10n.continueAction),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onContinue() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    goToNextOnboardingPage(context);
  }
}

class _OnboardingImage extends StatelessWidget {
  const _OnboardingImage(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 120, color: context.colorScheme.onPrimaryContainer);
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final Widget image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ColoredBox(
            color: context.colorScheme.primaryContainer,
            child: SafeArea(bottom: false, child: image),
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
