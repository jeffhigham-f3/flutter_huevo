import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/extension/context.dart';

class AppleAuthButton extends StatelessWidget {
  const AppleAuthButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = context.colorScheme.brightness;
    final isDark = brightness == Brightness.dark;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: isDark ? Colors.black : Colors.white,
        backgroundColor: isDark ? Colors.white : Colors.black,
        textStyle: context.textTheme.bodyMedium,
      ),
      icon: const Icon(Icons.apple),
      label: Text(context.l10n.signInWithApple),
      onPressed: onPressed,
    );
  }
}
