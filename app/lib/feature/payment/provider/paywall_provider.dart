import 'package:flutter_huevo/core/logger/loggy_types.dart';
import 'package:flutter_huevo/feature/payment/model/app_entitlements.dart';
import 'package:flutter_huevo/feature/payment/model/paywall.dart';
import 'package:flutter_huevo/feature/payment/model/paywall_product.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';

abstract class PaywallProvider with ProviderLoggy {
  void close();

  Stream<AppEntitlements> get appEntitlementsStream;

  Future<void> setUser(User? user);

  Future<void> logOut();

  Future<Paywall> getPaywall();

  Future<void> restorePurchase();

  Future<bool> purchase({required PaywallProduct product});
}
