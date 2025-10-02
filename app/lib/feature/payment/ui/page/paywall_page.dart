import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/extension/value_state_extension.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/core/ui/widget/item/single_action_bloc_listener.dart';
import 'package:flutter_huevo/feature/payment/bloc/paywall_cubit.dart';
import 'package:flutter_huevo/feature/payment/bloc/purchase_cubit.dart';
import 'package:flutter_huevo/feature/payment/ui/widget/paywall_content.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    final paywallState = context.watch<PaywallCubit>().state;
    final content = paywallState.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loaded: PaywallContent.new,
      error: (error) => Text(error.getText(context)),
    );

    return SingleActionBlocListener<PurchaseCubit>(
      onSuccess: () => AppRoute.paywallSuccess.pushReplacement(context),
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.pro)),
        body: Center(child: content),
      ),
    );
  }
}
