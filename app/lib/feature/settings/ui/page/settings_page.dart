import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_huevo/core/extension/context.dart';
import 'package:flutter_huevo/core/extension/context_app_config.dart';
import 'package:flutter_huevo/core/extension/context_user.dart';
import 'package:flutter_huevo/core/navigation/app_route.dart';
import 'package:flutter_huevo/core/ui/dialog/dialogs.dart';
import 'package:flutter_huevo/core/util/urls.dart';
import 'package:flutter_huevo/feature/onboarding/ui/widget/onboarding_navigation.dart';
import 'package:flutter_huevo/feature/settings/bloc/app_config_cubit.dart';
import 'package:flutter_huevo/feature/settings/ui/widget/app_version.dart';
import 'package:flutter_huevo/feature/settings/ui/widget/settings_tile.dart';
import 'package:flutter_huevo/feature/user/bloc/user_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDeleteAccountInProgress;
  late bool _isSignOutInProgress;

  @override
  void initState() {
    _isDeleteAccountInProgress = false;
    _isSignOutInProgress = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watchCurrentUser;
    final appConfig = context.watchAppConfig;
    final isDarkMode = appConfig?.isDarkMode ?? false;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settings)),
      body: SafeArea(
        child: ListView(
          children: [
            SettingsTile.toggle(
              icon: const Icon(Icons.dark_mode_outlined),
              label: context.l10n.darkMode,
              isOn: isDarkMode,
              onChanged: (value) =>
                  context.read<AppConfigCubit>().setDarkMode(darkMode: value),
            ),
            SettingsTile(
              icon: const Icon(Icons.feedback_outlined),
              label: context.l10n.sendFeedback,
              onTap: () => AppRoute.sendFeedback.push(context),
            ),
            const Divider(),
            SettingsTile(
              icon: const Icon(Icons.security_outlined),
              label: context.l10n.privacyPolicy,
              onTap: Urls.showPrivacyPolicy,
            ),
            SettingsTile(
              icon: const Icon(Icons.fact_check_outlined),
              label: context.l10n.termsOfService,
              onTap: Urls.showTermsOfService,
            ),
            if (user?.isNotAnonymous ?? false) ...[
              const Divider(),
              SettingsTile(
                icon: const Icon(Icons.delete_outlined),
                label: context.l10n.deleteMyAccount,
                isDestructive: true,
                isLoading: _isDeleteAccountInProgress,
                onTap: () => _onDeleteAccountTap(context),
              ),
              SettingsTile(
                icon: const Icon(Icons.logout_outlined),
                label: context.l10n.signOut,
                isLoading: _isSignOutInProgress,
                onTap: () => _onSignOutTap(context),
              ),
            ],
            const Padding(padding: EdgeInsets.all(32), child: AppVersion()),
          ],
        ),
      ),
    );
  }

  Future<void> _onDeleteAccountTap(BuildContext context) async {
    final confirmed = await Dialogs.showDeleteAccountConfirmationDialog(
      context,
    );

    if (!confirmed || !context.mounted) {
      return;
    }

    setState(() => _isDeleteAccountInProgress = true);
    await context.read<UserCubit>().deleteAccount();
    if (!context.mounted) {
      return;
    }

    getFirstOnboardingRoute().go(context);
  }

  Future<void> _onSignOutTap(BuildContext context) async {
    setState(() => _isSignOutInProgress = true);
    final success = await Dialogs.showLogOutConfirmationDialog(context);
    if (!success && context.mounted) {
      setState(() => _isSignOutInProgress = false);
    }
  }
}
