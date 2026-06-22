import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/brand/carebridge_horizontal_logo.png',
          width: 170,
          semanticLabel: l10n.appName,
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: l10n.accessibilitySettings,
            onSelected: (value) {
              if (value == 'language') {
                settings.setLocale(
                  settings.locale.languageCode == 'en'
                      ? const Locale('bn')
                      : const Locale('en'),
                );
              }
              if (value == 'caregiver') {
                settings.setRole(AppRole.caregiver);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'language', child: Text(l10n.language)),
              PopupMenuItem(
                value: 'caregiver',
                child: Text(l10n.backToCaregiver),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          key: const Key('parent-home-list'),
          padding: const EdgeInsets.all(CareSpacing.lg),
          children: [
            Text(
              l10n.parentGreeting,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CareSpacing.xs),
            Text(
              l10n.parentPrompt,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CareSpacing.lg),
            CareCard(
              child: Column(
                children: [
                  const Icon(
                    Icons.medication,
                    color: CareColors.blue,
                    size: 44,
                  ),
                  const SizedBox(height: CareSpacing.sm),
                  Text(
                    l10n.nextMedicine,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: CareSpacing.lg),
            CareButton(
              expanded: true,
              large: true,
              label: l10n.myMedicines,
              icon: Icons.medication_outlined,
              onPressed: () => context.push('/reminders/current'),
            ),
            const SizedBox(height: CareSpacing.md),
            CareButton(
              expanded: true,
              large: true,
              label: l10n.logVitals,
              icon: Icons.monitor_heart_outlined,
              style: CareButtonStyle.secondary,
              onPressed: () {},
            ),
            const SizedBox(height: CareSpacing.md),
            CareButton(
              expanded: true,
              large: true,
              label: l10n.callCaregiver,
              icon: Icons.call,
              style: CareButtonStyle.success,
              onPressed: () {},
            ),
            const SizedBox(height: CareSpacing.md),
            CareButton(
              key: const Key('parent-need-help-button'),
              expanded: true,
              large: true,
              label: l10n.needHelp,
              icon: Icons.sos,
              style: CareButtonStyle.danger,
              onPressed: () => context.push('/reminders/current'),
            ),
          ],
        ),
      ),
    );
  }
}
