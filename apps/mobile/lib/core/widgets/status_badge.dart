import 'package:flutter/material.dart';

import '../theme/carebridge_tokens.dart';

enum CareStatus { active, due, warning, missed, neutral }

class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.label, required this.status, super.key});

  final String label;
  final CareStatus status;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (status) {
      CareStatus.active => (CareColors.greenSoft, CareColors.green),
      CareStatus.due => (CareColors.blueSoft, CareColors.blue),
      CareStatus.warning => (CareColors.amberSoft, const Color(0xFF9B6500)),
      CareStatus.missed => (CareColors.redSoft, CareColors.red),
      CareStatus.neutral => (
        Theme.of(context).colorScheme.surfaceContainerHighest,
        Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    };
    return Semantics(
      label: 'Status: $label',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(CareRadius.pill),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: foreground,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
