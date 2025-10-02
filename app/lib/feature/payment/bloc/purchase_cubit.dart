import 'package:flutter_huevo/core/bloc/single_action_cubit.dart';
import 'package:flutter_huevo/feature/payment/model/paywall_product.dart';
import 'package:flutter_huevo/feature/payment/repository/payment_repository.dart';

class PurchaseCubit extends SingleActionCubit {
  PurchaseCubit({required this.paymentRepository});

  final PaymentRepository paymentRepository;

  void purchase(PaywallProduct product) {
    doAction(() => paymentRepository.purchase(product));
  }

  void restorePurchase() {
    doAction(
      () => paymentRepository.restorePurchase().then((_) => false),
      shouldEmitError: false,
    );
  }
}
