import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/care_profile.dart';

class CareProfilesPage extends StatelessWidget {
  const CareProfilesPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final active = settings.careProfiles
        .where((item) => item.status == CareProfileStatus.active)
        .toList();
    final archived = settings.careProfiles
        .where((item) => item.status == CareProfileStatus.archived)
        .toList();
    return ListView(
      key: const Key('care-profiles-list'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.careProfiles,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            CareButton(
              label: l10n.addCareProfile,
              icon: Icons.person_add_alt_1,
              onPressed: () => context.push('/profiles/new'),
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.lg),
        Text(
          l10n.activeProfiles,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: CareSpacing.sm),
        if (active.isEmpty)
          CareCard(
            child: Column(
              children: [
                const Icon(Icons.people_outline, size: 48),
                const SizedBox(height: CareSpacing.sm),
                Text(l10n.noActiveProfiles),
              ],
            ),
          )
        else
          for (final profile in active) ...[
            _ProfileCard(profile: profile, settings: settings),
            const SizedBox(height: CareSpacing.sm),
          ],
        if (archived.isNotEmpty) ...[
          const SizedBox(height: CareSpacing.lg),
          Text(
            l10n.archivedProfiles,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: CareSpacing.sm),
          for (final profile in archived) ...[
            _ProfileCard(profile: profile, settings: settings),
            const SizedBox(height: CareSpacing.sm),
          ],
        ],
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.profile, required this.settings});
  final CareProfile profile;
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CareCard(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(radius: 26, child: Text(profile.initials)),
              const SizedBox(width: CareSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.fullName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${profile.relationship} · ${profile.city}, ${profile.country}',
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: profile.status == CareProfileStatus.active
                    ? l10n.active
                    : l10n.archivedProfiles,
                status: profile.status == CareProfileStatus.active
                    ? CareStatus.active
                    : CareStatus.neutral,
              ),
            ],
          ),
          const SizedBox(height: CareSpacing.md),
          Row(
            children: [
              Expanded(child: Text(l10n.careProfileTimezone(profile.timezone))),
              TextButton.icon(
                key: Key('edit-profile-${profile.id}'),
                onPressed: () => context.push('/profiles/${profile.id}/edit'),
                icon: const Icon(Icons.edit_outlined),
                label: Text(l10n.editCareProfile),
              ),
              if (profile.status == CareProfileStatus.active)
                IconButton(
                  key: Key('archive-profile-${profile.id}'),
                  tooltip: l10n.archiveProfile,
                  onPressed: () => _confirmArchive(context),
                  icon: const Icon(Icons.archive_outlined),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _confirmArchive(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.archiveProfile),
        content: Text(l10n.archiveProfileWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.archiveProfile),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      settings.archiveCareProfile(profile.id);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.profileArchived)));
      }
    }
  }
}
