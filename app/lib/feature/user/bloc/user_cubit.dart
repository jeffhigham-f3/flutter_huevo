import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_huevo/core/logger/loggy_types.dart';
import 'package:flutter_huevo/feature/analytics/model/event.dart';
import 'package:flutter_huevo/feature/analytics/repository/analytics_repository.dart';
import 'package:flutter_huevo/feature/notifications/repository/notifications_repository.dart';
import 'package:flutter_huevo/feature/payment/repository/payment_repository.dart';
import 'package:flutter_huevo/feature/user/model/user.dart';
import 'package:flutter_huevo/feature/user/repository/user_repository.dart';
import 'package:timezone/timezone.dart' as tz;

part 'user_state.dart';

class UserCubit extends Cubit<UserState> with BlocLoggy {
  UserCubit({
    required this.userRepository,
    required this.analyticsRepository,
    required this.notificationsRepository,
    required this.paymentRepository,
  }) : super(const UserInitial()) {
    _load();
  }

  final UserRepository userRepository;
  final AnalyticsRepository analyticsRepository;
  final NotificationsRepository notificationsRepository;
  final PaymentRepository paymentRepository;

  StreamSubscription<User?>? _userSubscription;

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  Future<void> logOut({bool isDeleteAccount = false}) async {
    analyticsRepository.onSignOut();
    paymentRepository.setUser(null);
    if (!isDeleteAccount) {
      await notificationsRepository.removeFcmToken();
    }
    await userRepository.logOut();
  }

  Future<void> deleteAccount() async {
    analyticsRepository.logEvent(AnalyticsEvent.deleteAccount);

    await userRepository.deleteAccount();
    await logOut(isDeleteAccount: true);
  }

  void _load() {
    _userSubscription = userRepository.getUserStream().listen(_onUser);
  }

  void _onUser(User? user) {
    loggy.info('new user: ${user?.id}');
    emit(UserLoaded(user: user));

    if (user != null) {
      notificationsRepository.addFcmToken();
      analyticsRepository.setUser(user);
      paymentRepository.setUser(user);

      FlutterTimezone.getLocalTimezone()
          .then((timezone) {
            if (user.timezone != timezone) {
              loggy.info('Timezone changed: ${user.timezone} -> $timezone');
              userRepository.setTimezone(timezone);
            }

            final location = tz.getLocation(timezone);
            tz.setLocalLocation(location);
          })
          .catchError((dynamic error) {
            loggy.error('Failed to get timezone: $error');
          });
    }
  }
}
