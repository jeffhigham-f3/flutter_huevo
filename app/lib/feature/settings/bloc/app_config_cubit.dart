import 'dart:async';

import 'package:flutter_huevo/core/bloc/value_stream_cubit.dart';
import 'package:flutter_huevo/feature/settings/model/app_config.dart';
import 'package:flutter_huevo/feature/settings/repository/app_config_repository.dart';

class AppConfigCubit extends ValueStreamCubit<AppConfig> {
  AppConfigCubit({required this.appConfigRepository});

  final AppConfigRepository appConfigRepository;

  void setOnboardingComplete({required bool complete}) {
    appConfigRepository.setOnboardingComplete(complete: complete);
  }

  void setDarkMode({required bool darkMode}) {
    appConfigRepository.setDarkMode(darkMode: darkMode);
  }

  @override
  Future<void> close() {
    appConfigRepository.close();
    return super.close();
  }

  @override
  Stream<AppConfig> getValueStream() => appConfigRepository.appConfigStream;
}
