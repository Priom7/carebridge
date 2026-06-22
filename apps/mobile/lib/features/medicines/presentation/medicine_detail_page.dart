import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/medicine.dart';

class MedicineDetailPage extends StatelessWidget {
  const MedicineDetailPage({
    required this.settings,
    required this.medicine,
    super.key,
  });
  final AppSettings settings;
  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.medicineDetails),
        actions: [
          IconButton(
            tooltip: l10n.editMedicine,
            onPressed: () => context.push('/medicines/${medicine.id}/edit'),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(CareSpacing.lg),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundColor: CareColors.blueSoft,
                  child: Icon(
                    Icons.medication,
                    size: 42,
                    color: CareColors.blue,
                  ),
                ),
                const SizedBox(height: CareSpacing.md),
                Text(
                  medicine.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text('${medicine.form} · ${medicine.strength}'),
              ],
            ),
          ),
          const SizedBox(height: CareSpacing.lg),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.schedule,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: CareSpacing.sm),
                for (final time in medicine.schedule.times)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.schedule, color: CareColors.blue),
                    title: Text(time),
                    subtitle: Text(
                      '${medicine.schedule.foodInstruction} · ${medicine.schedule.timezone}',
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: CareSpacing.md),
          CareCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.stockAndNotes,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: CareSpacing.sm),
                Text(l10n.tabletsLeft(medicine.stockCount)),
                if (medicine.notes.isNotEmpty) ...[
                  const SizedBox(height: CareSpacing.sm),
                  Text(medicine.notes),
                ],
                if (medicine.sideEffectNotes.isNotEmpty) ...[
                  const SizedBox(height: CareSpacing.sm),
                  Text(medicine.sideEffectNotes),
                ],
              ],
            ),
          ),
          const SizedBox(height: CareSpacing.lg),
          Wrap(
            spacing: CareSpacing.sm,
            runSpacing: CareSpacing.sm,
            children: [
              if (medicine.status == MedicineStatus.active)
                CareButton(
                  label: l10n.pauseMedicine,
                  style: CareButtonStyle.secondary,
                  onPressed: () => settings.setMedicineStatus(
                    medicine.id,
                    MedicineStatus.paused,
                  ),
                ),
              if (medicine.status == MedicineStatus.paused)
                CareButton(
                  label: l10n.resumeMedicine,
                  onPressed: () => settings.setMedicineStatus(
                    medicine.id,
                    MedicineStatus.active,
                  ),
                ),
              CareButton(
                label: l10n.completeMedicine,
                style: CareButtonStyle.success,
                onPressed: () => settings.setMedicineStatus(
                  medicine.id,
                  MedicineStatus.completed,
                ),
              ),
              CareButton(
                label: l10n.stopMedicine,
                style: CareButtonStyle.danger,
                onPressed: () => settings.setMedicineStatus(
                  medicine.id,
                  MedicineStatus.stopped,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
