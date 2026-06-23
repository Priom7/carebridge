import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/emergency_models.dart';

class EmergencyAlertsPage extends StatelessWidget {
  const EmergencyAlertsPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final alerts = settings.emergencyAlertsForSelectedProfile();
    return ListView(
      key: const Key('emergency-alerts-list'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Text(
          l10n.emergencyAlerts,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: CareSpacing.sm),
        Text(l10n.showingDemoRecords(alerts.length)),
        const SizedBox(height: CareSpacing.lg),
        if (alerts.isEmpty)
          CareCard(child: Center(child: Text(l10n.noEmergencyAlerts))),
        for (final alert in alerts) ...[
          InkWell(
            onTap: () => context.push('/emergency-alerts/${alert.id}'),
            child: CareCard(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        alert.status == EmergencyAlertStatus.resolved
                        ? CareColors.greenSoft
                        : CareColors.redSoft,
                    child: Icon(
                      Icons.emergency_outlined,
                      color: alert.status == EmergencyAlertStatus.resolved
                          ? CareColors.green
                          : CareColors.red,
                    ),
                  ),
                  const SizedBox(width: CareSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.reason,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${alert.triggeredBy} · ${_time(alert.triggeredAt)}',
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(
                    label: _status(l10n, alert.status),
                    status: alert.status == EmergencyAlertStatus.resolved
                        ? CareStatus.active
                        : CareStatus.warning,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: CareSpacing.sm),
        ],
      ],
    );
  }

  String _status(AppLocalizations l10n, EmergencyAlertStatus status) =>
      switch (status) {
        EmergencyAlertStatus.active => l10n.active,
        EmergencyAlertStatus.accepted => l10n.accepted,
        EmergencyAlertStatus.resolved => l10n.resolved,
      };
  String _time(DateTime value) =>
      '${value.day}/${value.month} ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}
