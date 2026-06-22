import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/reminder_event.dart';

class ReminderHistoryPage extends StatefulWidget {
  const ReminderHistoryPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  State<ReminderHistoryPage> createState() => _ReminderHistoryPageState();
}

class _ReminderHistoryPageState extends State<ReminderHistoryPage> {
  ReminderStatus? filter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final all = widget.settings.reminders
        .where((item) => item.careProfileId == widget.settings.selectedProfile)
        .toList();
    final events = filter == null
        ? all
        : all.where((item) => item.status == filter).toList();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.reminderHistory)),
      body: ListView(
        key: const Key('reminder-history-list'),
        padding: const EdgeInsets.all(CareSpacing.lg),
        children: [
          Text(
            l10n.showingDemoRecords(all.length),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: CareSpacing.md),
          DropdownButtonFormField<ReminderStatus?>(
            initialValue: filter,
            decoration: InputDecoration(labelText: l10n.filterStatus),
            items: [
              DropdownMenuItem(value: null, child: Text(l10n.allStatuses)),
              ...ReminderStatus.values.map(
                (status) => DropdownMenuItem(
                  value: status,
                  child: Text(_label(l10n, status)),
                ),
              ),
            ],
            onChanged: (value) => setState(() => filter = value),
          ),
          const SizedBox(height: CareSpacing.lg),
          for (final event in events) ...[
            CareCard(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: _color(
                      event.status,
                    ).withValues(alpha: .12),
                    child: Icon(Icons.medication, color: _color(event.status)),
                  ),
                  const SizedBox(width: CareSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.medicineName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          '${event.scheduledAt.day} Jun · ${event.scheduledAt.hour.toString().padLeft(2, '0')}:${event.scheduledAt.minute.toString().padLeft(2, '0')} · ${event.timezone}',
                        ),
                        if (event.queuedOffline)
                          Text(
                            l10n.queuedOffline,
                            style: const TextStyle(color: CareColors.amber),
                          ),
                      ],
                    ),
                  ),
                  StatusBadge(
                    label: _label(l10n, event.status),
                    status: _badge(event.status),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CareSpacing.sm),
          ],
        ],
      ),
    );
  }

  String _label(AppLocalizations l10n, ReminderStatus value) => switch (value) {
    ReminderStatus.scheduled => l10n.scheduled,
    ReminderStatus.due => l10n.dueNow,
    ReminderStatus.taken => l10n.takenStatus,
    ReminderStatus.snoozed => l10n.snoozed,
    ReminderStatus.skipped => l10n.skipped,
    ReminderStatus.missed => l10n.missed,
    ReminderStatus.escalated => l10n.escalated,
    ReminderStatus.resolved => l10n.resolved,
    ReminderStatus.cancelled => l10n.cancelled,
  };

  Color _color(ReminderStatus value) => switch (value) {
    ReminderStatus.taken || ReminderStatus.resolved => CareColors.green,
    ReminderStatus.missed || ReminderStatus.escalated => CareColors.red,
    ReminderStatus.snoozed || ReminderStatus.skipped => CareColors.amber,
    _ => CareColors.blue,
  };

  CareStatus _badge(ReminderStatus value) => switch (value) {
    ReminderStatus.taken || ReminderStatus.resolved => CareStatus.active,
    ReminderStatus.missed || ReminderStatus.escalated => CareStatus.missed,
    ReminderStatus.snoozed || ReminderStatus.skipped => CareStatus.warning,
    ReminderStatus.due => CareStatus.due,
    _ => CareStatus.neutral,
  };
}
