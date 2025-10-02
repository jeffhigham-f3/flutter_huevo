import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggy/loggy.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/extension/context_app_entitlements.dart';
import 'package:flutter_huevo/core/extension/value_state_extension.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/feature/explore/ui/widget/explore_card.dart';
import 'package:flutter_huevo/feature/payment/bloc/app_entitlements_cubit.dart';
import 'package:flutter_huevo/feature/payment/model/paywall_placement.dart';

class PaywallCard extends StatelessWidget {
  const PaywallCard({super.key});

  @override
  Widget build(BuildContext context) {
    final appEntitlementsState = context.watch<AppEntitlementsCubit>().state;
    final hasPro = context.getAppEntitlements?.pro ?? false;

    final content = appEntitlementsState.when(
      initial: () => const Text('-'),
      loaded: (appEntitlements) => Icon(
        appEntitlements.pro ? Icons.check : Icons.close,
        color: appEntitlements.pro ? Colors.green : Colors.red,
      ),
      error: (error) => Text(error.getText(context)),
    );

    return ExploreCard(
      title: context.l10n.pro,
      content: content,
      action: hasPro
          ? null
          : FilledButton(
              onPressed: () => _onPressed(context),
              child: Text(context.l10n.unlockPro),
            ),
    );
  }

  void _onPressed(BuildContext context) {
    final hasPro = context.getAppEntitlements?.pro ?? false;
    if (hasPro) {
      logWarning('Already pro');
      return;
    }

    AppRoute.paywall.push(
      context,
      params: {'placement': PaywallPlacement.explore.id},
    );
  }
}
