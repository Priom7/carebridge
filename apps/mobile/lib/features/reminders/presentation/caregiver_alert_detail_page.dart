import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/alarm_request.dart';
import '../domain/reminder_event.dart';

class CaregiverAlertDetailPage extends StatelessWidget {
  const CaregiverAlertDetailPage({
    required this.settings,
    required this.reminder,
    super.key,
  });
  final AppSettings settings;
  final ReminderEvent reminder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final latest = settings.latestAlarmForReminder(reminder.id);
    final canSend = settings.canSendAlarm(reminder.id);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.missedReminderAlert)),
      body: ListView(
        key: const Key('caregiver-alert-detail'),
        padding: const EdgeInsets.all(CareSpacing.lg),
        children: [
          CareCard(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 38,
                  backgroundColor: CareColors.redSoft,
                  child: Icon(Icons.alarm, size: 38, color: CareColors.red),
                ),
                const SizedBox(height: CareSpacing.md),
                Text(
                  reminder.medicineName,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                Text('${reminder.dosage} · ${reminder.foodInstruction}'),
                const SizedBox(height: CareSpacing.md),
                Text(
                  l10n.parentLocalTime(
                    reminder.timezone,
                    _time(reminder.scheduledAt),
                  ),
                ),
                Text(l10n.caregiverLocalTime(_ukTime(reminder.scheduledAt))),
              ],
            ),
          ),
          const SizedBox(height: CareSpacing.md),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.deliveryTracking,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: CareSpacing.sm),
                _trackingRow(context, l10n.requested, true),
                _trackingRow(
                  context,
                  l10n.delivered,
                  latest?.deliveredAt.isNotEmpty == true,
                ),
                _trackingRow(
                  context,
                  l10n.opened,
                  latest?.openedAt.isNotEmpty == true,
                ),
                _trackingRow(
                  context,
                  l10n.actioned,
                  latest?.actionedAt.isNotEmpty == true,
                ),
                if (latest?.status == AlarmDeliveryStatus.failed)
                  Text(
                    '${l10n.failed}: ${latest?.failureReason}',
                    style: const TextStyle(color: CareColors.red),
                  ),
              ],
            ),
          ),
          const SizedBox(height: CareSpacing.md),
          CareCard(child: Text(l10n.remoteDeliveryWarning)),
          const SizedBox(height: CareSpacing.lg),
          CareButton(
            key: const Key('remote-ring-button'),
            expanded: true,
            large: true,
            label: l10n.remoteRing,
            icon: Icons.alarm,
            style: CareButtonStyle.danger,
            onPressed: canSend
                ? () => _send(context, 'remote_ring')
                : () => _rateLimited(context),
          ),
          const SizedBox(height: CareSpacing.sm),
          CareButton(
            expanded: true,
            label: l10n.sendReminder,
            icon: Icons.notifications_active,
            onPressed: canSend
                ? () => _send(context, 'reminder_push')
                : () => _rateLimited(context),
          ),
          const SizedBox(height: CareSpacing.lg),
          Text(
            l10n.fallbackActions,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: CareSpacing.sm),
          Wrap(
            spacing: CareSpacing.sm,
            runSpacing: CareSpacing.sm,
            children: [
              CareButton(
                label: l10n.callParent,
                icon: Icons.call,
                style: CareButtonStyle.success,
                onPressed: () => _feedback(context, l10n.callParent),
              ),
              CareButton(
                label: l10n.notifyLocalContact,
                icon: Icons.contact_phone,
                style: CareButtonStyle.secondary,
                onPressed: () => _feedback(context, l10n.notifyLocalContact),
              ),
              CareButton(
                key: const Key('resolve-caregiver-alert'),
                label: l10n.resolveAlert,
                icon: Icons.task_alt,
                style: CareButtonStyle.quiet,
                onPressed: () {
                  settings.resolveReminder(reminder.id);
                  _feedback(context, l10n.alertResolved);
                  context.pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trackingRow(BuildContext context, String label, bool complete) =>
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          complete ? Icons.check_circle : Icons.radio_button_unchecked,
          color: complete ? CareColors.green : CareColors.slate,
        ),
        title: Text(label),
      );

  void _send(BuildContext context, String type) {
    settings.sendRemoteAlarm(reminder.id, type: type);
    final l10n = AppLocalizations.of(context);
    _feedback(
      context,
      type == 'remote_ring' ? l10n.remoteRingSent : l10n.reminderSent,
    );
  }

  void _rateLimited(BuildContext context) =>
      _feedback(context, AppLocalizations.of(context).ringRateLimited);
  void _feedback(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  String _time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  String _ukTime(DateTime value) =>
      '${(value.hour - 5).remainder(24).toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}
