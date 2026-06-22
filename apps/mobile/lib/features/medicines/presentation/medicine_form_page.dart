import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/medicine.dart';

class MedicineFormPage extends StatefulWidget {
  const MedicineFormPage({required this.settings, this.medicine, super.key});
  final AppSettings settings;
  final Medicine? medicine;

  @override
  State<MedicineFormPage> createState() => _MedicineFormPageState();
}

class _MedicineFormPageState extends State<MedicineFormPage> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> fields;
  late MedicineFrequency frequency;
  late String form;
  late String food;
  late bool longTerm;
  late List<String> times;
  late Set<int> days;

  @override
  void initState() {
    super.initState();
    final m = widget.medicine;
    fields = {
      'name': TextEditingController(text: m?.name),
      'generic': TextEditingController(text: m?.genericName),
      'brand': TextEditingController(text: m?.brandName),
      'strength': TextEditingController(text: m?.strength),
      'dosage': TextEditingController(text: m?.dosage),
      'quantity': TextEditingController(text: '${m?.quantityPerDose ?? 1}'),
      'start': TextEditingController(
        text: m?.schedule.startDate ?? '2026-06-21',
      ),
      'end': TextEditingController(text: m?.schedule.endDate),
      'prescribed': TextEditingController(text: m?.prescribedBy),
      'doctor': TextEditingController(text: m?.linkedDoctor),
      'prescription': TextEditingController(text: m?.linkedPrescription),
      'stock': TextEditingController(text: '${m?.stockCount ?? 30}'),
      'threshold': TextEditingController(text: '${m?.lowStockThreshold ?? 5}'),
      'notes': TextEditingController(text: m?.notes),
      'sideEffects': TextEditingController(text: m?.sideEffectNotes),
    };
    frequency = m?.schedule.frequency ?? MedicineFrequency.onceDaily;
    form = m?.form ?? 'Tablet';
    food = m?.schedule.foodInstruction ?? 'After food';
    longTerm = m?.schedule.isLongTerm ?? true;
    times = [...?m?.schedule.times];
    if (times.isEmpty) times = ['09:00'];
    days = {...?m?.schedule.daysOfWeek};
    if (days.isEmpty) days = {1, 2, 3, 4, 5, 6, 7};
  }

  @override
  void dispose() {
    for (final controller in fields.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final timezone =
        widget.settings.selectedCareProfile?.timezone ?? 'Asia/Dhaka';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.medicine == null ? l10n.addMedicine : l10n.editMedicine,
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          key: const Key('medicine-form-list'),
          padding: const EdgeInsets.all(CareSpacing.lg),
          children: [
            _section(l10n.medicineDetails, [
              _field('name', l10n.medicineName, required: true),
              _field('generic', l10n.genericName),
              _field('brand', l10n.brandName),
              _field('strength', l10n.strength, required: true),
              DropdownButtonFormField<String>(
                initialValue: form,
                decoration: InputDecoration(labelText: l10n.medicineForm),
                items:
                    [
                          'Tablet',
                          'Capsule',
                          'Syrup',
                          'Drops',
                          'Inhaler',
                          'Cream',
                          'Injection',
                          'Other',
                        ]
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                onChanged: (value) => form = value ?? form,
              ),
              _field('dosage', l10n.dosage, required: true),
              _field(
                'quantity',
                l10n.quantityPerDose,
                keyboard: TextInputType.number,
              ),
            ]),
            _section(l10n.schedule, [
              DropdownButtonFormField<MedicineFrequency>(
                initialValue: frequency,
                decoration: InputDecoration(labelText: l10n.frequency),
                items: MedicineFrequency.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(_frequencyLabel(l10n, value)),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setState(() => frequency = value ?? frequency),
              ),
              Text(
                l10n.doseTimes,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Wrap(
                spacing: CareSpacing.sm,
                runSpacing: CareSpacing.sm,
                children: [
                  for (final time in times)
                    InputChip(
                      label: Text(time),
                      onDeleted: times.length > 1
                          ? () => setState(() => times.remove(time))
                          : null,
                    ),
                  ActionChip(
                    avatar: const Icon(Icons.add, size: 18),
                    label: Text(l10n.addTime),
                    onPressed: _addTime,
                  ),
                ],
              ),
              Text(
                l10n.daysOfWeek,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Wrap(
                spacing: CareSpacing.xs,
                children: [
                  for (var day = 1; day <= 7; day++)
                    FilterChip(
                      label: Text(_dayLabel(day)),
                      selected: days.contains(day),
                      onSelected: (selected) => setState(
                        () => selected ? days.add(day) : days.remove(day),
                      ),
                    ),
                ],
              ),
              _field('start', l10n.startDate, required: true),
              _field('end', l10n.endDate),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.longTermMedicine),
                value: longTerm,
                onChanged: (value) => setState(() => longTerm = value),
              ),
              DropdownButtonFormField<String>(
                initialValue: food,
                decoration: InputDecoration(labelText: l10n.foodInstruction),
                items:
                    ['Before food', 'After food', 'With food', 'Empty stomach']
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(_foodLabel(l10n, value)),
                          ),
                        )
                        .toList(),
                onChanged: (value) => food = value ?? food,
              ),
              CareCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.schedulePreview,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: CareSpacing.xs),
                    Text(l10n.schedulePreviewBody(timezone)),
                    const SizedBox(height: CareSpacing.xs),
                    Text(
                      l10n.nextDosePreview('22 Jun 2026', times.first),
                      style: const TextStyle(
                        color: CareColors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            _section(l10n.prescriptionAndDoctor, [
              _field('prescribed', l10n.prescribedBy),
              _field('doctor', l10n.linkedDoctor),
              _field('prescription', l10n.linkedPrescription),
            ]),
            _section(l10n.stockAndNotes, [
              _field('stock', l10n.stockCount, keyboard: TextInputType.number),
              _field(
                'threshold',
                l10n.lowStockThreshold,
                keyboard: TextInputType.number,
              ),
              _field('notes', l10n.medicineNotes, lines: 2),
              _field('sideEffects', l10n.sideEffectNotes, lines: 2),
            ]),
            CareButton(
              key: const Key('save-medicine'),
              expanded: true,
              label: l10n.saveMedicine,
              onPressed: _confirmAndSave,
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) => Padding(
    padding: const EdgeInsets.only(bottom: CareSpacing.lg),
    child: CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: CareSpacing.md),
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const SizedBox(height: CareSpacing.md),
          ],
        ],
      ),
    ),
  );

  Widget _field(
    String key,
    String label, {
    bool required = false,
    int lines = 1,
    TextInputType? keyboard,
  }) => TextFormField(
    key: Key('medicine-$key'),
    controller: fields[key],
    maxLines: lines,
    keyboardType: keyboard,
    decoration: InputDecoration(labelText: label),
    validator: required
        ? (value) => value == null || value.trim().isEmpty
              ? AppLocalizations.of(context).requiredField
              : null
        : null,
  );

  Future<void> _addTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 20, minute: 0),
    );
    if (selected == null) return;
    final value =
        '${selected.hour.toString().padLeft(2, '0')}:${selected.minute.toString().padLeft(2, '0')}';
    if (!times.contains(value)) setState(() => times.add(value));
  }

  Future<void> _confirmAndSave() async {
    if (!formKey.currentState!.validate()) return;
    if (widget.medicine != null) {
      final l10n = AppLocalizations.of(context);
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(l10n.confirmSchedule),
          content: Text(l10n.scheduleChangeWarning),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(l10n.confirmSchedule),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }
    final timezone =
        widget.settings.selectedCareProfile?.timezone ?? 'Asia/Dhaka';
    final medicine = Medicine(
      id:
          widget.medicine?.id ??
          'medicine-${DateTime.now().millisecondsSinceEpoch}',
      careProfileId: widget.settings.selectedProfile,
      name: fields['name']!.text.trim(),
      genericName: fields['generic']!.text.trim(),
      brandName: fields['brand']!.text.trim(),
      strength: fields['strength']!.text.trim(),
      form: form,
      dosage: fields['dosage']!.text.trim(),
      quantityPerDose: double.tryParse(fields['quantity']!.text) ?? 1,
      prescribedBy: fields['prescribed']!.text.trim(),
      linkedDoctor: fields['doctor']!.text.trim(),
      linkedPrescription: fields['prescription']!.text.trim(),
      stockCount: int.tryParse(fields['stock']!.text) ?? 0,
      lowStockThreshold: int.tryParse(fields['threshold']!.text) ?? 0,
      notes: fields['notes']!.text.trim(),
      sideEffectNotes: fields['sideEffects']!.text.trim(),
      status: widget.medicine?.status ?? MedicineStatus.active,
      schedule: MedicineSchedule(
        frequency: frequency,
        times: times,
        daysOfWeek: days,
        startDate: fields['start']!.text.trim(),
        endDate: fields['end']!.text.trim(),
        timezone: timezone,
        foodInstruction: food,
        isLongTerm: longTerm,
      ),
    );
    widget.settings.saveMedicine(medicine);
    if (mounted) context.pop();
  }

  String _frequencyLabel(AppLocalizations l10n, MedicineFrequency value) =>
      switch (value) {
        MedicineFrequency.onceDaily => l10n.onceDaily,
        MedicineFrequency.twiceDaily => l10n.twiceDaily,
        MedicineFrequency.threeTimesDaily => l10n.threeTimesDaily,
        MedicineFrequency.fourTimesDaily => l10n.fourTimesDaily,
        MedicineFrequency.everyXHours => l10n.everyXHours,
        MedicineFrequency.specificDays => l10n.specificDays,
        MedicineFrequency.weekly => l10n.weekly,
        MedicineFrequency.monthly => l10n.monthly,
        MedicineFrequency.asNeeded => l10n.asNeeded,
      };

  String _foodLabel(AppLocalizations l10n, String value) => switch (value) {
    'Before food' => l10n.beforeFood,
    'With food' => l10n.withFood,
    'Empty stomach' => l10n.emptyStomach,
    _ => l10n.afterFood,
  };

  String _dayLabel(int day) =>
      const ['M', 'T', 'W', 'T', 'F', 'S', 'S'][day - 1];
}
