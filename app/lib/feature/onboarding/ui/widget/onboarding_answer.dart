import 'package:flutter/material.dart';
import 'package:flutter_huevo/core/extension/context.dart';

const _animationDuration = Duration(milliseconds: 250);

class OnboardingAnswer extends StatelessWidget {
  const OnboardingAnswer({
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.selectedDescription,
    super.key,
  });

  final String title;
  final String? selectedDescription;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(32);
    final shouldAnimate = selectedDescription != null;

    Widget selectedDescriptionWidget = isSelected && selectedDescription != null
        ? Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedDescription!,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
    if (shouldAnimate) {
      selectedDescriptionWidget = AnimatedSize(
        duration: _animationDuration,
        child: selectedDescriptionWidget,
      );
    }

    Widget child = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(color: context.theme.dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.onSurface,
                ),
              ),
              selectedDescriptionWidget,
            ],
          ),
        ),
      ),
    );
    if (shouldAnimate) {
      child = AnimatedContainer(
        duration: _animationDuration,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: isSelected ? context.colorScheme.primary : null,
        ),
        child: child,
      );
    } else {
      child = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: isSelected ? context.colorScheme.primary : null,
        ),
        child: child,
      );
    }

    return child;
  }
}
