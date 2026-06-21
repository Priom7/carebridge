import 'package:flutter/material.dart';

import '../theme/carebridge_tokens.dart';

enum CareButtonStyle { primary, secondary, success, danger, quiet }

class CareButton extends StatelessWidget {
  const CareButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.style = CareButtonStyle.primary,
    this.expanded = false,
    this.large = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final CareButtonStyle style;
  final bool expanded;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (background, foreground, border) = switch (style) {
      CareButtonStyle.primary => (
        scheme.primary,
        scheme.onPrimary,
        scheme.primary,
      ),
      CareButtonStyle.secondary => (
        Colors.transparent,
        scheme.primary,
        scheme.primary,
      ),
      CareButtonStyle.success => (
        CareColors.green,
        CareColors.white,
        CareColors.green,
      ),
      CareButtonStyle.danger => (
        CareColors.red,
        CareColors.white,
        CareColors.red,
      ),
      CareButtonStyle.quiet => (
        Colors.transparent,
        scheme.onSurface,
        Colors.transparent,
      ),
    };
    final button = Semantics(
      button: true,
      label: label,
      child: SizedBox(
        height: large ? 64 : 48,
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: icon == null
              ? const SizedBox.shrink()
              : Icon(icon, size: large ? 26 : 20),
          label: Text(label),
          style: FilledButton.styleFrom(
            backgroundColor: background,
            foregroundColor: foreground,
            disabledBackgroundColor: background.withValues(alpha: .35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CareRadius.sm),
              side: BorderSide(color: border),
            ),
            textStyle: TextStyle(
              fontSize: large ? 18 : 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
