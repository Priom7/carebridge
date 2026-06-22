import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';

class CaregiverHomePage extends StatelessWidget {
  const CaregiverHomePage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profile = settings.selectedCareProfile;
    if (profile == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(CareSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.people_outline,
                size: 64,
                color: CareColors.slate,
              ),
              const SizedBox(height: CareSpacing.md),
              Text(
                l10n.noActiveProfiles,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CareSpacing.md),
              CareButton(
                label: l10n.addCareProfile,
                icon: Icons.person_add,
                onPressed: () => context.push('/profiles/new'),
              ),
            ],
          ),
        ),
      );
    }

    final incomplete =
        profile.phone.isEmpty ||
        profile.timezone.isEmpty ||
        profile.emergencyInstructions.isEmpty;
    return ListView(
      key: const Key('caregiver-dashboard'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 30, child: Text(profile.initials)),
            const SizedBox(width: CareSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dashboardFor(profile.preferredName),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: CareSpacing.xs),
                  Text(l10n.careProfileTimezone(profile.timezone)),
                ],
              ),
            ),
            IconButton(
              tooltip: l10n.editCareProfile,
              onPressed: () => context.push('/profiles/${profile.id}/edit'),
              icon: const Icon(Icons.edit_outlined),
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.sm),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: CareSpacing.sm,
              vertical: CareSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: CareColors.tealSoft,
              borderRadius: BorderRadius.circular(CareRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.science_outlined,
                  size: 18,
                  color: CareColors.teal,
                ),
                const SizedBox(width: CareSpacing.xs),
                Flexible(
                  child: Text(
                    l10n.demoDatasetSummary(
                      settings.careProfiles.length,
                      settings.medicines.length,
                      settings.reminders.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (incomplete) ...[
          const SizedBox(height: CareSpacing.md),
          MaterialBanner(
            content: Text(l10n.partialProfile),
            leading: const Icon(Icons.info_outline),
            actions: [
              TextButton(
                onPressed: () => context.push('/profiles/${profile.id}/edit'),
                child: Text(l10n.completeProfile),
              ),
            ],
          ),
        ],
        const SizedBox(height: CareSpacing.lg),
        Wrap(
          spacing: CareSpacing.md,
          runSpacing: CareSpacing.md,
          children: [
            _Summary(
              value: '${profile.medicinesDue}',
              label: l10n.medicinesDue,
              icon: Icons.medication,
              color: CareColors.green,
            ),
            _Summary(
              value: '${profile.missedReminders}',
              label: l10n.needsAttention,
              icon: Icons.notifications_active,
              color: profile.missedReminders > 0
                  ? CareColors.red
                  : CareColors.green,
            ),
            _Summary(
              value: '${profile.documentsThisWeek}',
              label: l10n.documentsThisWeek,
              icon: Icons.description_outlined,
              color: CareColors.blue,
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.lg),
        CareCard(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              backgroundColor: CareColors.blueSoft,
              child: Icon(Icons.calendar_month, color: CareColors.blue),
            ),
            title: Text(l10n.nextAppointment),
            subtitle: Text(
              profile.upcomingAppointment.isEmpty
                  ? '—'
                  : profile.upcomingAppointment,
            ),
            trailing: const Icon(Icons.chevron_right),
          ),
        ),
        const SizedBox(height: CareSpacing.lg),
        Text(l10n.quickActions, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: CareSpacing.sm),
        Wrap(
          spacing: CareSpacing.sm,
          runSpacing: CareSpacing.sm,
          children: [
            CareButton(
              label: l10n.addMedicine,
              icon: Icons.add,
              onPressed: () => context.push('/medicines/new'),
            ),
            CareButton(
              label: l10n.uploadReport,
              icon: Icons.upload_file,
              style: CareButtonStyle.secondary,
              onPressed: () {},
            ),
            CareButton(
              label: l10n.addEmergencyContact,
              icon: Icons.contact_phone,
              style: CareButtonStyle.secondary,
              onPressed: () {},
            ),
            CareButton(
              label: l10n.viewTimeline,
              icon: Icons.timeline,
              style: CareButtonStyle.quiet,
              onPressed: () {},
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(CareRadius.sm),
            ),
            child: Icon(icon, color: color),
          ),
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
