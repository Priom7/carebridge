import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';

class FamilyOnboardingPage extends StatefulWidget {
  const FamilyOnboardingPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  State<FamilyOnboardingPage> createState() => _FamilyOnboardingPageState();
}

class _FamilyOnboardingPageState extends State<FamilyOnboardingPage> {
  final familyName = TextEditingController(text: 'Sharif Family Care');
  final inviteEmail = TextEditingController();
  int step = 0;
  bool addFather = true;
  bool addMother = true;

  @override
  void dispose() {
    familyName.dispose();
    inviteEmail.dispose();
    super.dispose();
  }

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
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: ListView(
              key: const Key('family-onboarding-list'),
              padding: const EdgeInsets.all(CareSpacing.lg),
              children: [
                Semantics(
                  label: l10n.stepProgress(step + 1, 4),
                  child: LinearProgressIndicator(value: (step + 1) / 4),
                ),
                const SizedBox(height: CareSpacing.sm),
                Text(
                  l10n.stepProgress(step + 1, 4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: CareSpacing.xl),
                AnimatedSwitcher(
                  duration: CareMotion.standard,
                  child: _stepContent(l10n),
                ),
                const SizedBox(height: CareSpacing.xl),
                Row(
                  children: [
                    if (step > 0)
                      Expanded(
                        child: CareButton(
                          label: l10n.previous,
                          style: CareButtonStyle.secondary,
                          onPressed: () => setState(() => step -= 1),
                        ),
                      ),
                    if (step > 0) const SizedBox(width: CareSpacing.sm),
                    Expanded(
                      child: CareButton(
                        key: const Key('onboarding-next'),
                        label: step == 3
                            ? l10n.createFamily
                            : l10n.continueAction,
                        onPressed: _advance,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _stepContent(AppLocalizations l10n) {
    return switch (step) {
      0 => Column(
        key: const ValueKey('family-name'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.onboardingTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: CareSpacing.sm),
          Text(
            l10n.onboardingIntro,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: CareSpacing.lg),
          TextField(
            key: const Key('family-name-field'),
            controller: familyName,
            decoration: InputDecoration(
              labelText: l10n.familyName,
              hintText: l10n.familyNameHint,
              prefixIcon: const Icon(Icons.family_restroom),
            ),
          ),
        ],
      ),
      1 => Column(
        key: const ValueKey('care-profiles'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.whoDoYouCareFor,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: CareSpacing.lg),
          CheckboxListTile(
            key: const Key('add-father'),
            contentPadding: EdgeInsets.zero,
            value: addFather,
            onChanged: (value) => setState(() => addFather = value ?? false),
            title: Text(l10n.addFather),
            secondary: const CircleAvatar(child: Text('AK')),
          ),
          CheckboxListTile(
            key: const Key('add-mother'),
            contentPadding: EdgeInsets.zero,
            value: addMother,
            onChanged: (value) => setState(() => addMother = value ?? false),
            title: Text(l10n.addMother),
            secondary: const CircleAvatar(child: Text('SB')),
          ),
        ],
      ),
      2 => Column(
        key: const ValueKey('invite'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.inviteCaregiver,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: CareSpacing.sm),
          Text(l10n.inviteCaregiverBody),
          const SizedBox(height: CareSpacing.lg),
          TextField(
            key: const Key('invite-email-field'),
            controller: inviteEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: l10n.inviteEmail,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: CareSpacing.lg),
          Text(
            l10n.permissionPreview,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: CareSpacing.sm),
          CareCard(
            child: Column(
              children: [
                _PermissionPreview(
                  icon: Icons.medication_outlined,
                  label: l10n.manageMedicines,
                  enabled: true,
                ),
                _PermissionPreview(
                  icon: Icons.folder_outlined,
                  label: l10n.manageDocuments,
                  enabled: false,
                ),
                _PermissionPreview(
                  icon: Icons.calendar_month_outlined,
                  label: l10n.manageAppointments,
                  enabled: true,
                ),
                _PermissionPreview(
                  icon: Icons.contact_phone_outlined,
                  label: l10n.manageEmergencyContacts,
                  enabled: true,
                ),
              ],
            ),
          ),
        ],
      ),
      _ => Column(
        key: const ValueKey('review'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.reviewFamily,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: CareSpacing.lg),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  familyName.text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: CareSpacing.md),
                if (addFather)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(child: Text('AK')),
                    title: const Text('Abdul Karim'),
                    subtitle: Text(l10n.father),
                  ),
                if (addMother)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(child: Text('SB')),
                    title: const Text('Salma Begum'),
                    subtitle: Text(l10n.mother),
                  ),
                if (inviteEmail.text.trim().isNotEmpty)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.mark_email_unread_outlined),
                    title: Text(inviteEmail.text.trim()),
                    subtitle: Text(l10n.secondaryCaregiver),
                  ),
              ],
            ),
          ),
        ],
      ),
    };
  }

  void _advance() {
    if (step == 0 && familyName.text.trim().isEmpty) return;
    if (step < 3) {
      setState(() => step += 1);
      return;
    }
    widget.settings.createFamilyGroup(
      name: familyName.text.trim(),
      addFather: addFather,
      addMother: addMother,
      inviteEmail: inviteEmail.text,
    );
  }
}

class _PermissionPreview extends StatelessWidget {
  const _PermissionPreview({
    required this.icon,
    required this.label,
    required this.enabled,
  });
  final IconData icon;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon),
    title: Text(label),
    trailing: Icon(
      enabled ? Icons.check_circle : Icons.remove_circle_outline,
      color: enabled ? CareColors.green : CareColors.slate,
    ),
  );
}
