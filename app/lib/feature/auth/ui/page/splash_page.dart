import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/bloc/value_stream_cubit.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/core/ui/widget/app_logo.dart';
import 'package:flutter_huevo/feature/settings/bloc/app_config_cubit.dart';
import 'package:flutter_huevo/feature/settings/model/app_config.dart';
import 'package:flutter_huevo/feature/user/bloc/user_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  UserLoaded? _userLoadedState;
  ValueLoaded<AppConfig>? _appConfigLoadedState;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserLoaded) {
              _userLoadedState = state;
            }

            _onLoaded();
          },
        ),
        BlocListener<AppConfigCubit, ValueState<AppConfig>>(
          listener: (context, state) {
            if (state is ValueLoaded<AppConfig>) {
              _appConfigLoadedState = state;
            }

            _onLoaded();
          },
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(64),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(size: 120),
                Text(
                  context.l10n.appName,
                  style: context.primaryTextTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onLoaded() async {
    final userState = _userLoadedState;
    final appConfigState = _appConfigLoadedState;
    if (userState == null || appConfigState == null) {
      // Not loaded yet
      return;
    }

    if (Platform.isIOS) {
      await AppTrackingTransparency.requestTrackingAuthorization();
      if (!mounted) {
        return;
      }
    }

    AppRoute.home.go(context);
  }
}
