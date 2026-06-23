import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/emergency_models.dart';

class EmergencyAlertDetailPage extends StatelessWidget {
  const EmergencyAlertDetailPage({
    required this.settings,
    required this.alertId,
    super.key,
  });
  final AppSettings settings;
  final String alertId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final matches = settings.emergencyAlerts.where(
      (item) => item.id == alertId,
    );
    if (matches.isEmpty) {
      return Scaffold(body: Center(child: Text(l10n.pageNotFound)));
    }
    final alert = matches.first;
    final priorityContacts = settings
        .emergencyContactsForSelectedProfile()
        .where(
          (item) => item.priorityLevel == 1 && item.canReceiveEmergencyAlerts,
        )
        .toList();
    final helper = priorityContacts.isEmpty
        ? 'Local contact'
        : priorityContacts.first.fullName;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.emergencyAlertDetail)),
      body: SafeArea(
        child: ListView(
          key: const Key('emergency-alert-detail'),
          padding: const EdgeInsets.all(CareSpacing.lg),
          children: [
            CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          alert.reason,
                          style: Theme.of(context).textTheme.headlineSmall,
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
                  const SizedBox(height: CareSpacing.sm),
                  Text('${l10n.triggeredBy}: ${alert.triggeredBy}'),
                  if (alert.acceptedBy.isNotEmpty)
                    Text('${l10n.acceptedBy}: ${alert.acceptedBy}'),
                  if (alert.resolvedAt.isNotEmpty)
                    Text('${l10n.resolved}: ${alert.resolvedAt}'),
                ],
              ),
            ),
            const SizedBox(height: CareSpacing.lg),
            Text(
              l10n.alertTimeline,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: CareSpacing.sm),
            CareCard(
              child: Column(
                children: [
                  for (var i = 0; i < alert.timeline.length; i++)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 14,
                        child: Text('${i + 1}'),
                      ),
                      title: Text(alert.timeline[i]),
                    ),
                ],
              ),
            ),
            const SizedBox(height: CareSpacing.lg),
            if (alert.status != EmergencyAlertStatus.resolved) ...[
              CareButton(
                expanded: true,
                label: l10n.notifyPriorityOne,
                icon: Icons.notifications_active_outlined,
                style: CareButtonStyle.secondary,
                onPressed: () => settings.notifyPriorityOne(alert.id),
              ),
              const SizedBox(height: CareSpacing.sm),
              if (alert.status == EmergencyAlertStatus.active)
                CareButton(
                  key: const Key('accept-emergency-alert'),
                  expanded: true,
                  label: l10n.goingToHelp,
                  icon: Icons.directions_run,
                  onPressed: () =>
                      settings.acceptEmergencyAlert(alert.id, helper),
                ),
              const SizedBox(height: CareSpacing.sm),
              CareButton(
                key: const Key('resolve-emergency-alert'),
                expanded: true,
                label: l10n.resolveEmergency,
                icon: Icons.check_circle_outline,
                style: CareButtonStyle.success,
                onPressed: () => settings.resolveEmergencyAlert(alert.id),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _status(AppLocalizations l10n, EmergencyAlertStatus status) =>
      switch (status) {
        EmergencyAlertStatus.active => l10n.active,
        EmergencyAlertStatus.accepted => l10n.accepted,
        EmergencyAlertStatus.resolved => l10n.resolved,
      };
}
