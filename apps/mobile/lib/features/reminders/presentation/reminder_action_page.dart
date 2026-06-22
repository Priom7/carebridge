import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/reminder_event.dart';

class ReminderActionPage extends StatelessWidget {
  const ReminderActionPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final reminder = settings.dueReminderForSelectedProfile();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.today),
        actions: [
          IconButton(
            tooltip: l10n.reminderHistory,
            onPressed: () => context.push('/reminders/history'),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          key: const Key('reminder-action-list'),
          padding: const EdgeInsets.all(CareSpacing.lg),
          children: [
            SwitchListTile.adaptive(
              key: const Key('offline-demo-switch'),
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.offlineDemo),
              subtitle: Text(l10n.offlineDemoBody),
              value: settings.demoOffline,
              onChanged: settings.setDemoOffline,
            ),
            if (reminder == null)
              _NoReminder(settings: settings)
            else
              _ReminderCard(settings: settings, reminder: reminder),
            const SizedBox(height: CareSpacing.lg),
            CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.reminderPermissionHealth,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: CareSpacing.sm),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.check_circle,
                      color: CareColors.green,
                    ),
                    title: Text(l10n.notificationsAllowed),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.battery_alert_outlined,
                      color: CareColors.amber,
                    ),
                    title: Text(l10n.batteryGuidance),
                  ),
                  Text(
                    l10n.deliveryLimitation,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard({required this.settings, required this.reminder});
  final AppSettings settings;
  final ReminderEvent reminder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CareCard(
      padding: const EdgeInsets.all(CareSpacing.xl),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: const BoxDecoration(
              color: CareColors.blueSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active,
              size: 44,
              color: CareColors.blue,
            ),
          ),
          const SizedBox(height: CareSpacing.lg),
          Text(
            l10n.timeForMedicine,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CareSpacing.sm),
          Text(
            reminder.medicineName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text('${reminder.dosage} · ${reminder.foodInstruction}'),
          Text('${_time(reminder.scheduledAt)} · ${reminder.timezone}'),
          const SizedBox(height: CareSpacing.lg),
          CareButton(
            key: const Key('reminder-taken'),
            expanded: true,
            large: true,
            label: l10n.takenAction,
            icon: Icons.done,
            style: CareButtonStyle.success,
            onPressed: () => _act(context, ReminderStatus.taken),
          ),
          const SizedBox(height: CareSpacing.sm),
          CareButton(
            expanded: true,
            large: true,
            label: l10n.snooze15,
            icon: Icons.snooze,
            style: CareButtonStyle.secondary,
            onPressed: () => _act(context, ReminderStatus.snoozed),
          ),
          const SizedBox(height: CareSpacing.sm),
          CareButton(
            expanded: true,
            large: true,
            label: l10n.skipDose,
            icon: Icons.skip_next,
            style: CareButtonStyle.quiet,
            onPressed: () => _act(context, ReminderStatus.skipped),
          ),
          const SizedBox(height: CareSpacing.sm),
          CareButton(
            key: const Key('reminder-help'),
            expanded: true,
            large: true,
            label: l10n.needHelpAction,
            icon: Icons.support_agent,
            style: CareButtonStyle.danger,
            onPressed: () => _act(context, ReminderStatus.escalated),
          ),
        ],
      ),
    );
  }

  void _act(BuildContext context, ReminderStatus status) {
    final l10n = AppLocalizations.of(context);
    settings.actOnReminder(reminder.id, status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == ReminderStatus.escalated
              ? l10n.helpRequested
              : settings.demoOffline
              ? l10n.queuedOffline
              : l10n.actionRecorded,
        ),
      ),
    );
  }

  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}

class _NoReminder extends StatelessWidget {
  const _NoReminder({required this.settings});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CareCard(
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 64,
            color: CareColors.green,
          ),
          const SizedBox(height: CareSpacing.md),
          Text(
            l10n.noReminderDue,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: CareSpacing.md),
          CareButton(
            label: l10n.viewReminderHistory,
            style: CareButtonStyle.secondary,
            onPressed: () => context.push('/reminders/history'),
          ),
        ],
      ),
    );
  }
}
