import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_huevo/core/ui/widget/responsive.dart';
import 'package:flutter_huevo/feature/analytics/repository/analytics_repository.dart';
import 'package:flutter_huevo/l10n/app_localizations.dart';

extension Context on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  AnalyticsRepository get analytics => read<AnalyticsRepository>();

  void closeKeyboard() => FocusScope.of(this).unfocus();

  bool get isKeyboardVisible =>
      KeyboardVisibilityProvider.isKeyboardVisible(this);

  bool get hasParentRoute =>
      ModalRoute.of(this)?.impliesAppBarDismissal ?? false;

  void showSnackBarMessage(String message, {bool isError = false}) {
    final Color? foregroundColor;
    final Color? backgroundColor;
    if (isError) {
      foregroundColor = theme.colorScheme.onError;
      backgroundColor = theme.colorScheme.error;
    } else {
      foregroundColor = null;
      backgroundColor = null;
    }

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message, style: TextStyle(color: foregroundColor)),
      ),
    );
  }

  bool get isWide {
    final maxWidth = MediaQuery.sizeOf(this).width;
    return maxWidth > desktopWidthBreakpoint;
  }
}
