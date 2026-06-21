import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';

class PrivacyDataPage extends StatelessWidget {
  const PrivacyDataPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Text(
          l10n.privacyAndData,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: CareSpacing.lg),
        CareCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.exportData,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CareSpacing.xs),
              Text(l10n.exportDescription),
              const SizedBox(height: CareSpacing.md),
              if (settings.exportRequested)
                Semantics(
                  liveRegion: true,
                  child: Text(
                    l10n.exportQueued,
                    style: const TextStyle(
                      color: CareColors.green,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              else
                CareButton(
                  label: l10n.requestExport,
                  icon: Icons.download_outlined,
                  onPressed: settings.requestExport,
                ),
            ],
          ),
        ),
        const SizedBox(height: CareSpacing.lg),
        CareCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.deleteAccount,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: CareColors.red),
              ),
              const SizedBox(height: CareSpacing.xs),
              Text(l10n.deleteDescription),
              const SizedBox(height: CareSpacing.md),
              CareButton(
                label: l10n.deleteAccount,
                style: CareButtonStyle.danger,
                icon: Icons.delete_forever_outlined,
                onPressed: () => showDialog<void>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: Text(l10n.deleteAccount),
                    content: Text(l10n.deleteWarning),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text(l10n.cancel),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          settings.signOut();
                        },
                        child: Text(l10n.confirmDelete),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
