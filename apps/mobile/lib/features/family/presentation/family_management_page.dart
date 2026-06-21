import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/family_models.dart';

class FamilyManagementPage extends StatelessWidget {
  const FamilyManagementPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      key: const Key('family-management-list'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Text(
          l10n.manageFamily,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: CareSpacing.xs),
        Text(
          settings.familyGroupName.isEmpty
              ? 'Sharif Family Care'
              : settings.familyGroupName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: CareSpacing.lg),
        Text(
          l10n.membersAndRoles,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: CareSpacing.sm),
        for (final member in settings.familyMembers) ...[
          _MemberCard(member: member, settings: settings),
          const SizedBox(height: CareSpacing.sm),
        ],
        const SizedBox(height: CareSpacing.md),
        Text(
          l10n.pendingInvitations,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: CareSpacing.sm),
        if (settings.familyInvitations.isEmpty)
          CareCard(child: Text(l10n.noInvitations))
        else
          for (final invitation in settings.familyInvitations)
            _InvitationCard(invitation: invitation, settings: settings),
        const SizedBox(height: CareSpacing.lg),
        Text(
          l10n.familyActivity,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: CareSpacing.sm),
        CareCard(
          child: Column(
            children: [
              for (final activity in settings.familyActivity)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.history),
                  title: Text(_activityLabel(l10n, activity)),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _activityLabel(AppLocalizations l10n, String activity) {
    if (activity.contains('ownership')) {
      return l10n.ownershipTransferredActivity;
    }
    if (activity.contains('access')) return l10n.memberRemovedActivity;
    if (activity.contains('permissions')) {
      return l10n.permissionsUpdatedActivity;
    }
    if (activity.contains('accepted')) return l10n.inviteAcceptedActivity;
    if (activity.contains('revoked')) return l10n.inviteRevokedActivity;
    if (activity.contains('invitation')) return l10n.inviteSentActivity;
    if (activity.contains('profile')) return l10n.profileAddedActivity;
    return l10n.familyCreatedActivity;
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member, required this.settings});
  final FamilyMember member;
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final role = switch (member.role) {
      FamilyMemberRole.owner => l10n.owner,
      FamilyMemberRole.secondaryCaregiver => l10n.secondaryCaregiver,
      FamilyMemberRole.dependent => l10n.dependent,
    };
    return CareCard(
      child: Row(
        children: [
          CircleAvatar(
            child: Text(
              member.name.split(' ').map((part) => part[0]).take(2).join(),
            ),
          ),
          const SizedBox(width: CareSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('${member.relationship} · $role'),
              ],
            ),
          ),
          if (member.role == FamilyMemberRole.secondaryCaregiver)
            PopupMenuButton<String>(
              tooltip: l10n.editPermissions,
              onSelected: (value) {
                if (value == 'permissions') _showPermissions(context);
                if (value == 'transfer') _confirmTransfer(context);
                if (value == 'remove') _confirmRemove(context);
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'permissions',
                  child: Text(l10n.editPermissions),
                ),
                PopupMenuItem(
                  value: 'transfer',
                  child: Text(l10n.transferOwnership),
                ),
                PopupMenuItem(value: 'remove', child: Text(l10n.removeAccess)),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _showPermissions(BuildContext context) async {
    var medicines = member.canManageMedicines;
    var documents = member.canManageDocuments;
    var appointments = member.canManageAppointments;
    var emergency = member.canManageEmergencyContacts;
    final l10n = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.editPermissions),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  value: medicines,
                  onChanged: (value) => setState(() => medicines = value),
                  title: Text(l10n.manageMedicines),
                ),
                SwitchListTile(
                  value: documents,
                  onChanged: (value) => setState(() => documents = value),
                  title: Text(l10n.manageDocuments),
                ),
                SwitchListTile(
                  value: appointments,
                  onChanged: (value) => setState(() => appointments = value),
                  title: Text(l10n.manageAppointments),
                ),
                SwitchListTile(
                  value: emergency,
                  onChanged: (value) => setState(() => emergency = value),
                  title: Text(l10n.manageEmergencyContacts),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                settings.updateMemberPermissions(
                  member.id,
                  medicines: medicines,
                  documents: documents,
                  appointments: appointments,
                  emergencyContacts: emergency,
                );
                Navigator.pop(dialogContext);
              },
              child: Text(l10n.savePermissions),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmTransfer(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.transferOwnership),
        content: Text(l10n.transferWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.transferTo(member.name)),
          ),
        ],
      ),
    );
    if (confirmed == true) settings.transferOwnership(member.id);
  }

  Future<void> _confirmRemove(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.removeAccess),
        content: Text(l10n.removeAccessWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.removeAccess),
          ),
        ],
      ),
    );
    if (confirmed == true) settings.removeMember(member.id);
  }
}

class _InvitationCard extends StatelessWidget {
  const _InvitationCard({required this.invitation, required this.settings});
  final FamilyInvitation invitation;
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, status) = switch (invitation.status) {
      InvitationStatus.pending => (l10n.pending, CareStatus.warning),
      InvitationStatus.accepted => (l10n.accepted, CareStatus.active),
      InvitationStatus.revoked => (l10n.revoked, CareStatus.missed),
      InvitationStatus.expired => (l10n.expired, CareStatus.neutral),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: CareSpacing.sm),
      child: CareCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.email_outlined),
                const SizedBox(width: CareSpacing.sm),
                Expanded(
                  child: Text(
                    invitation.email,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                StatusBadge(label: label, status: status),
              ],
            ),
            if (invitation.status == InvitationStatus.pending) ...[
              const SizedBox(height: CareSpacing.md),
              Wrap(
                spacing: CareSpacing.sm,
                runSpacing: CareSpacing.sm,
                children: [
                  CareButton(
                    label: l10n.acceptDemoInvite,
                    style: CareButtonStyle.secondary,
                    onPressed: () => settings.acceptInvitation(invitation.id),
                  ),
                  CareButton(
                    label: l10n.revokeInvitation,
                    style: CareButtonStyle.danger,
                    onPressed: () => _confirmRevoke(context),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _confirmRevoke(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.revokeInvitation),
        content: Text(l10n.revokeInviteWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.revokeInvitation),
          ),
        ],
      ),
    );
    if (confirmed == true) settings.revokeInvitation(invitation.id);
  }
}
