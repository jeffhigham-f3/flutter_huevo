import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';

class PaywallSuccessPage extends StatelessWidget {
  const PaywallSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    context.l10n.success,
                    style: context.textTheme.headlineMedium,
                  ),
                ),
              ),
              FilledButton(
                child: Text(context.l10n.continueAction),
                onPressed: () {
                  if (context.hasParentRoute) {
                    context.pop();
                  } else {
                    AppRoute.home.go(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
