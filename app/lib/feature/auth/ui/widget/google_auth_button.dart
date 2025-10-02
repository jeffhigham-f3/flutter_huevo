import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/app/assets.dart';
import 'package:flutter_huevo/core/extension/context.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.black),
        textStyle: context.textTheme.bodyMedium,
      ),
      icon: Image.asset(AppAssets.google, width: 18, height: 18),
      label: Text(context.l10n.signInWithGoogle),
      onPressed: onPressed,
    );
  }
}
