import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/extension/context.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size * 0.2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.primary,
      ),
      child: Icon(
        Icons.rocket_launch,
        size: size,
        color: context.colorScheme.onPrimary,
      ),
    );
  }
}
