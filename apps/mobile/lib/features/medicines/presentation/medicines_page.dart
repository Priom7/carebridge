import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/medicine.dart';

enum MedicineView { all, active, lowStock, completed }

class MedicinesPage extends StatefulWidget {
  const MedicinesPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  State<MedicinesPage> createState() => _MedicinesPageState();
}

class _MedicinesPageState extends State<MedicinesPage> {
  MedicineView view = MedicineView.active;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final source = widget.settings.medicinesForSelectedProfile();
    final medicines = source
        .where(
          (medicine) => switch (view) {
            MedicineView.all => true,
            MedicineView.active => medicine.status == MedicineStatus.active,
            MedicineView.lowStock =>
              medicine.isLowStock && medicine.status == MedicineStatus.active,
            MedicineView.completed =>
              medicine.status == MedicineStatus.completed,
          },
        )
        .toList();
    return ListView(
      key: const Key('medicines-list'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.medicines,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            CareButton(
              label: l10n.addMedicine,
              icon: Icons.add,
              onPressed: () => context.push('/medicines/new'),
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.md),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<MedicineView>(
            segments: [
              ButtonSegment(
                value: MedicineView.all,
                label: Text(l10n.allMedicines),
              ),
              ButtonSegment(
                value: MedicineView.active,
                label: Text(l10n.active),
              ),
              ButtonSegment(
                value: MedicineView.lowStock,
                label: Text(l10n.lowStock),
              ),
              ButtonSegment(
                value: MedicineView.completed,
                label: Text(l10n.completed),
              ),
            ],
            selected: {view},
            onSelectionChanged: (values) => setState(() => view = values.first),
          ),
        ),
        const SizedBox(height: CareSpacing.lg),
        if (medicines.isEmpty)
          CareCard(
            child: Column(
              children: [
                const Icon(
                  Icons.medication_outlined,
                  size: 52,
                  color: CareColors.slate,
                ),
                const SizedBox(height: CareSpacing.sm),
                Text(l10n.noMedicines),
              ],
            ),
          )
        else
          for (final medicine in medicines) ...[
            _MedicineCard(medicine: medicine),
            const SizedBox(height: CareSpacing.sm),
          ],
      ],
    );
  }
}

class _MedicineCard extends StatelessWidget {
  const _MedicineCard({required this.medicine});
  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = medicine.isLowStock
        ? StatusBadge(label: l10n.lowStock, status: CareStatus.warning)
        : StatusBadge(
            label: _statusLabel(l10n),
            status: medicine.status == MedicineStatus.active
                ? CareStatus.active
                : CareStatus.neutral,
          );
    return InkWell(
      onTap: () => context.push('/medicines/${medicine.id}'),
      borderRadius: BorderRadius.circular(CareRadius.md),
      child: CareCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: CareColors.blueSoft,
                  child: Icon(Icons.medication, color: CareColors.blue),
                ),
                const SizedBox(width: CareSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${medicine.dosage} · ${medicine.schedule.foodInstruction}',
                      ),
                    ],
                  ),
                ),
                status,
              ],
            ),
            const SizedBox(height: CareSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(medicine.schedule.times.join('  ·  ')),
                Text(l10n.tabletsLeft(medicine.stockCount)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n) => switch (medicine.status) {
    MedicineStatus.active => l10n.active,
    MedicineStatus.paused => l10n.paused,
    MedicineStatus.completed => l10n.completed,
    MedicineStatus.stopped => l10n.stopped,
  };
}
