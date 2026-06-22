import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../l10n/app_localizations.dart';

class MorePage extends StatelessWidget {
  const MorePage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      key: const Key('more-page-list'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Text(
          l10n.moreCareTools,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: CareSpacing.md),
        ListTile(
          leading: const Icon(Icons.family_restroom_outlined),
          title: Text(l10n.manageFamily),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/family'),
        ),
        ListTile(
          leading: const Icon(Icons.people_outline),
          title: Text(l10n.careProfiles),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/profiles'),
        ),
        ListTile(
          leading: const Icon(Icons.contact_phone_outlined),
          title: Text(l10n.emergencyContacts),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: const Icon(Icons.notifications_active_outlined),
          title: Text(l10n.caregiverAlerts),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/caregiver-alerts'),
        ),
        ListTile(
          leading: const Icon(Icons.calendar_month_outlined),
          title: Text(l10n.appointments),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: Text(l10n.settings),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: const Icon(Icons.security_outlined),
          title: Text(l10n.accountSecurity),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/account/security'),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: Text(l10n.privacyAndData),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/account/privacy'),
        ),
        ListTile(
          leading: const Icon(Icons.palette_outlined),
          title: Text(l10n.designSystem),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => context.push('/design-system'),
        ),
        const Divider(),
        Text(
          l10n.accessibilitySettings,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: CareSpacing.sm),
        SegmentedButton<Locale>(
          segments: [
            ButtonSegment(value: const Locale('en'), label: Text(l10n.english)),
            ButtonSegment(value: const Locale('bn'), label: Text(l10n.bangla)),
          ],
          selected: {settings.locale},
          onSelectionChanged: (values) => settings.setLocale(values.first),
        ),
        const SizedBox(height: CareSpacing.md),
        Text(l10n.textSize, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: CareSpacing.sm),
        SegmentedButton<double>(
          key: const Key('text-scale-control'),
          segments: [
            ButtonSegment(value: 1, label: Text(l10n.standard)),
            ButtonSegment(value: 1.5, label: Text(l10n.large)),
            ButtonSegment(value: 2, label: Text(l10n.extraLarge)),
          ],
          selected: {settings.textScale},
          onSelectionChanged: (values) => settings.setTextScale(values.first),
        ),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.darkMode),
          value: settings.isDark,
          onChanged: settings.setDarkMode,
        ),
      ],
    );
  }
}
