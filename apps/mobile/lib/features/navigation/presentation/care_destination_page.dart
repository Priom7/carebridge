import 'package:flutter/material.dart';

import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';

enum CareDestinationKind { medicines, health, documents }

class CareDestinationPage extends StatelessWidget {
  const CareDestinationPage({required this.kind, super.key});
  final CareDestinationKind kind;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (title, description, icon) = switch (kind) {
      CareDestinationKind.medicines => (
        l10n.medicineLibrary,
        l10n.medicineDescription,
        Icons.medication_outlined,
      ),
      CareDestinationKind.health => (
        l10n.healthOverview,
        l10n.healthDescription,
        Icons.monitor_heart_outlined,
      ),
      CareDestinationKind.documents => (
        l10n.documentVault,
        l10n.documentDescription,
        Icons.folder_outlined,
      ),
    };
    return ListView(
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: CareSpacing.lg),
        CareCard(
          child: Column(
            children: [
              Icon(icon, size: 64, color: CareColors.blue),
              const SizedBox(height: CareSpacing.md),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
