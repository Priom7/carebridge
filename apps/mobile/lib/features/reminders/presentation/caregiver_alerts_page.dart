import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/reminder_event.dart';

class CaregiverAlertsPage extends StatelessWidget {
  const CaregiverAlertsPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final alerts = settings.reminders
        .where(
          (item) =>
              item.careProfileId == settings.selectedProfile &&
              (item.status == ReminderStatus.missed ||
                  item.status == ReminderStatus.escalated),
        )
        .toList();
    return ListView(
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Text(
          l10n.caregiverAlerts,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: CareSpacing.xs),
        Text(l10n.showingDemoRecords(settings.alarmRequests.length)),
        const SizedBox(height: CareSpacing.lg),
        if (alerts.isEmpty)
          CareCard(child: Text(l10n.noCaregiverAlerts))
        else
          for (final alert in alerts) ...[
            InkWell(
              onTap: () => context.push('/caregiver-alerts/${alert.id}'),
              borderRadius: BorderRadius.circular(CareRadius.md),
              child: CareCard(
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: CareColors.redSoft,
                      child: Icon(
                        Icons.notifications_active,
                        color: CareColors.red,
                      ),
                    ),
                    const SizedBox(width: CareSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alert.medicineName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(l10n.missedAt(_time(alert.scheduledAt))),
                          Text(alert.timezone),
                        ],
                      ),
                    ),
                    StatusBadge(
                      label: alert.status == ReminderStatus.escalated
                          ? l10n.escalated
                          : l10n.missed,
                      status: CareStatus.missed,
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

  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}
