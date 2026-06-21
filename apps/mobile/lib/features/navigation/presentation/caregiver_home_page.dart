import 'package:flutter/material.dart';

import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';

class CaregiverHomePage extends StatelessWidget {
  const CaregiverHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Text(
          l10n.goodMorning,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: CareSpacing.xs),
        Text(l10n.careSummary, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: CareSpacing.lg),
        Wrap(
          spacing: CareSpacing.md,
          runSpacing: CareSpacing.md,
          children: [
            _Summary(
              value: '3',
              label: l10n.medicinesDue,
              icon: Icons.medication,
              color: CareColors.green,
            ),
            _Summary(
              value: '1',
              label: l10n.needsAttention,
              icon: Icons.notifications_active,
              color: CareColors.red,
            ),
            _Summary(
              value: '25 Jun',
              label: l10n.upcomingVisit,
              icon: Icons.calendar_month,
              color: CareColors.blue,
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.lg),
        CareCard(
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: CareColors.greenSoft,
                child: Icon(Icons.done, color: CareColors.green),
              ),
              const SizedBox(width: CareSpacing.md),
              Expanded(
                child: Text(
                  l10n.allCaughtUp,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 240,
    child: CareCard(
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: CareSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: Theme.of(context).textTheme.titleLarge),
                Text(label),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
