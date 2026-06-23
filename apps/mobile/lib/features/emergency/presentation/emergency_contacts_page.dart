import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/emergency_models.dart';

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final contacts = settings.emergencyContactsForSelectedProfile();
    return ListView(
      key: const Key('emergency-contacts-list'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.emergencyContacts,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            CareButton(
              label: l10n.addEmergencyContact,
              icon: Icons.add,
              onPressed: () => context.push('/emergency-contacts/new'),
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.sm),
        Text(l10n.showingDemoRecords(contacts.length)),
        const SizedBox(height: CareSpacing.lg),
        for (final contact in contacts) ...[
          _ContactCard(settings: settings, contact: contact),
          const SizedBox(height: CareSpacing.sm),
        ],
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.settings, required this.contact});
  final AppSettings settings;
  final EmergencyContact contact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(child: Text(contact.initials)),
              const SizedBox(width: CareSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.fullName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text('${contact.relationship} · ${contact.distanceNote}'),
                  ],
                ),
              ),
              StatusBadge(
                label: '${l10n.priorityLevel} ${contact.priorityLevel}',
                status: contact.priorityLevel == 1
                    ? CareStatus.warning
                    : CareStatus.neutral,
              ),
            ],
          ),
          const SizedBox(height: CareSpacing.sm),
          Wrap(
            spacing: CareSpacing.sm,
            runSpacing: CareSpacing.sm,
            children: [
              Chip(label: Text(_status(l10n, contact.verificationStatus))),
              if (contact.canReceiveEmergencyAlerts)
                Chip(label: Text(l10n.receiveEmergencyAlert)),
              if (contact.canViewLocation) Chip(label: Text(l10n.viewLocation)),
            ],
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: () => _message(
                  context,
                  l10n.callingContact(contact.primaryPhone),
                ),
                icon: const Icon(Icons.call_outlined),
                label: Text(l10n.call),
              ),
              TextButton.icon(
                onPressed: () => _message(
                  context,
                  l10n.openingWhatsapp(contact.whatsappNumber),
                ),
                icon: const Icon(Icons.chat_outlined),
                label: Text(l10n.whatsapp),
              ),
              const Spacer(),
              IconButton(
                tooltip: l10n.edit,
                onPressed: () =>
                    context.push('/emergency-contacts/${contact.id}/edit'),
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _message(BuildContext context, String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  String _status(AppLocalizations l10n, ContactVerificationStatus status) =>
      switch (status) {
        ContactVerificationStatus.added => l10n.contactAdded,
        ContactVerificationStatus.invited => l10n.contactInvited,
        ContactVerificationStatus.verified => l10n.contactVerified,
        ContactVerificationStatus.active => l10n.active,
        ContactVerificationStatus.inactive => l10n.inactive,
        ContactVerificationStatus.removed => l10n.removed,
      };
}
