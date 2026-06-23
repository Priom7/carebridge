import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/emergency_models.dart';

class EmergencyContactFormPage extends StatefulWidget {
  const EmergencyContactFormPage({
    required this.settings,
    this.contact,
    super.key,
  });
  final AppSettings settings;
  final EmergencyContact? contact;

  @override
  State<EmergencyContactFormPage> createState() =>
      _EmergencyContactFormPageState();
}

class _EmergencyContactFormPageState extends State<EmergencyContactFormPage> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> fields;
  late int priority;
  late bool emergency;
  late bool missed;
  late bool basic;
  late bool medical;
  late bool documents;
  late bool location;

  @override
  void initState() {
    super.initState();
    final c = widget.contact;
    fields = {
      'name': TextEditingController(text: c?.fullName),
      'relationship': TextEditingController(text: c?.relationship),
      'type': TextEditingController(text: c?.contactType ?? 'Neighbour'),
      'phone': TextEditingController(text: c?.primaryPhone),
      'secondary': TextEditingController(text: c?.secondaryPhone),
      'whatsapp': TextEditingController(text: c?.whatsappNumber),
      'email': TextEditingController(text: c?.email),
      'address': TextEditingController(text: c?.address),
      'distance': TextEditingController(text: c?.distanceNote),
      'availability': TextEditingController(text: c?.availabilityNote),
      'method': TextEditingController(
        text: c?.preferredContactMethod ?? 'Call',
      ),
      'notes': TextEditingController(text: c?.notes),
    };
    priority = c?.priorityLevel ?? 1;
    emergency = c?.canReceiveEmergencyAlerts ?? true;
    missed = c?.canReceiveMissedMedicineAlerts ?? false;
    basic = c?.canViewBasicProfile ?? true;
    medical = c?.canViewMedicalSummary ?? false;
    documents = c?.canViewDocuments ?? false;
    location = c?.canViewLocation ?? false;
  }

  @override
  void dispose() {
    for (final field in fields.values) {
      field.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contact == null
              ? l10n.addEmergencyContact
              : l10n.editEmergencyContact,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            key: const Key('emergency-contact-form'),
            padding: const EdgeInsets.all(CareSpacing.lg),
            children: [
              CareCard(
                child: Column(
                  children: [
                    _field('name', l10n.contactName, required: true),
                    _gap,
                    _field('relationship', l10n.relationship, required: true),
                    _gap,
                    _field('type', l10n.contactType),
                    _gap,
                    _field(
                      'phone',
                      l10n.primaryPhone,
                      required: true,
                      phone: true,
                    ),
                    _gap,
                    _field('secondary', l10n.secondaryPhone, phone: true),
                    _gap,
                    _field('whatsapp', l10n.whatsappNumber, phone: true),
                    _gap,
                    _field('email', l10n.emailAddress),
                    _gap,
                    _field('address', l10n.address),
                    _gap,
                    _field('distance', l10n.distance),
                    _gap,
                    _field('availability', l10n.availability),
                    _gap,
                    _field('method', l10n.preferredContactMethod),
                    _gap,
                    DropdownButtonFormField<int>(
                      initialValue: priority,
                      decoration: InputDecoration(
                        labelText: l10n.priorityLevel,
                      ),
                      items: [1, 2, 3, 4]
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text('${l10n.priorityLevel} $value'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => priority = value ?? priority,
                    ),
                    _gap,
                    _field('notes', l10n.contactNotes, lines: 3),
                  ],
                ),
              ),
              const SizedBox(height: CareSpacing.lg),
              CareCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.emergencyPermissions,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(l10n.permissionWarning),
                    _switch(
                      l10n.receiveEmergencyAlert,
                      emergency,
                      (v) => emergency = v,
                    ),
                    _switch(
                      l10n.receiveMissedMedicineAlert,
                      missed,
                      (v) => missed = v,
                    ),
                    _switch(l10n.viewBasicProfile, basic, (v) => basic = v),
                    _switch(
                      l10n.viewMedicalSummary,
                      medical,
                      (v) => medical = v,
                    ),
                    _switch(
                      l10n.viewDocumentsPermission,
                      documents,
                      (v) => documents = v,
                    ),
                    _switch(l10n.viewLocation, location, (v) => location = v),
                  ],
                ),
              ),
              const SizedBox(height: CareSpacing.lg),
              CareButton(
                key: const Key('save-emergency-contact'),
                expanded: true,
                label: l10n.saveContact,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: CareSpacing.md);
  Widget _field(
    String key,
    String label, {
    bool required = false,
    bool phone = false,
    int lines = 1,
  }) => TextFormField(
    controller: fields[key],
    maxLines: lines,
    keyboardType: phone ? TextInputType.phone : null,
    decoration: InputDecoration(labelText: label),
    validator: required
        ? (value) => value == null || value.trim().isEmpty
              ? '$label is required'
              : null
        : null,
  );
  Widget _switch(String title, bool value, ValueChanged<bool> assign) =>
      StatefulBuilder(
        builder: (context, setLocalState) => SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          value: value,
          onChanged: (next) {
            setLocalState(() => value = next);
            setState(() => assign(next));
          },
        ),
      );

  void _save() {
    if (!formKey.currentState!.validate()) return;
    final c = widget.contact;
    widget.settings.saveEmergencyContact(
      EmergencyContact(
        id: c?.id ?? 'contact-live-${DateTime.now().microsecondsSinceEpoch}',
        careProfileId: widget.settings.selectedProfile,
        fullName: fields['name']!.text.trim(),
        relationship: fields['relationship']!.text.trim(),
        contactType: fields['type']!.text.trim(),
        primaryPhone: fields['phone']!.text.trim(),
        secondaryPhone: fields['secondary']!.text.trim(),
        whatsappNumber: fields['whatsapp']!.text.trim(),
        email: fields['email']!.text.trim(),
        address: fields['address']!.text.trim(),
        distanceNote: fields['distance']!.text.trim(),
        availabilityNote: fields['availability']!.text.trim(),
        preferredContactMethod: fields['method']!.text.trim(),
        priorityLevel: priority,
        verificationStatus:
            c?.verificationStatus ?? ContactVerificationStatus.added,
        canReceiveEmergencyAlerts: emergency,
        canReceiveMissedMedicineAlerts: missed,
        canViewBasicProfile: basic,
        canViewMedicalSummary: medical,
        canViewDocuments: documents,
        canViewLocation: location,
        notes: fields['notes']!.text.trim(),
      ),
    );
    context.pop();
  }
}
