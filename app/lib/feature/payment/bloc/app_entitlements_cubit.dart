import 'dart:async';

import 'package:flutter_huevo/core/bloc/value_stream_cubit.dart';
import 'package:flutter_huevo/feature/payment/model/app_entitlements.dart';
import 'package:flutter_huevo/feature/payment/repository/payment_repository.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';
import 'package:flutter_huevo/feature/user/repository/user_repository.dart';

class AppEntitlementsCubit extends ValueStreamCubit<AppEntitlements> {
  AppEntitlementsCubit({
    required this.paymentRepository,
    required this.userRepository,
  }) {
    _userSubscription = userRepository.getUserStream().listen(
      paymentRepository.setUser,
    );
  }

  StreamSubscription<User?>? _userSubscription;

  final PaymentRepository paymentRepository;
  final UserRepository userRepository;

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    paymentRepository.close();
    return super.close();
  }

  @override
  Stream<AppEntitlements> getValueStream() =>
      paymentRepository.appEntitlementsStream;
}
