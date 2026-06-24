import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/appointment_models.dart';

class DoctorFormPage extends StatefulWidget {
  const DoctorFormPage({required this.settings, super.key});
  final AppSettings settings;
  @override
  State<DoctorFormPage> createState() => _DoctorFormPageState();
}

class _DoctorFormPageState extends State<DoctorFormPage> {
  final key = GlobalKey<FormState>();
  final fields = <String, TextEditingController>{
    for (final name in [
      'name',
      'speciality',
      'hospital',
      'phone',
      'email',
      'address',
      'hours',
      'notes',
    ])
      name: TextEditingController(),
  };
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
    final labels = {
      'name': l10n.doctorName,
      'speciality': l10n.speciality,
      'hospital': l10n.hospitalClinic,
      'phone': l10n.phoneNumber,
      'email': l10n.emailAddress,
      'address': l10n.address,
      'hours': l10n.visitingHours,
      'notes': l10n.notes,
    };
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addDoctor)),
      body: SafeArea(
        child: Form(
          key: key,
          child: ListView(
            padding: const EdgeInsets.all(CareSpacing.lg),
            children: [
              for (final name in fields.keys)
                Padding(
                  padding: const EdgeInsets.only(bottom: CareSpacing.md),
                  child: TextFormField(
                    controller: fields[name],
                    maxLines: name == 'notes' ? 3 : 1,
                    decoration: InputDecoration(labelText: labels[name]),
                    validator: name == 'name' || name == 'speciality'
                        ? (value) => value == null || value.trim().isEmpty
                              ? '${labels[name]} is required'
                              : null
                        : null,
                  ),
                ),
              CareButton(
                key: const Key('save-doctor'),
                expanded: true,
                label: l10n.saveDoctor,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (!key.currentState!.validate()) return;
    widget.settings.saveDoctor(
      Doctor(
        id: 'doctor-live-${DateTime.now().microsecondsSinceEpoch}',
        name: fields['name']!.text.trim(),
        speciality: fields['speciality']!.text.trim(),
        hospital: fields['hospital']!.text.trim(),
        phone: fields['phone']!.text.trim(),
        email: fields['email']!.text.trim(),
        address: fields['address']!.text.trim(),
        visitingHours: fields['hours']!.text.trim(),
        notes: fields['notes']!.text.trim(),
        linkedCareProfileIds: [widget.settings.selectedProfile],
      ),
    );
    context.pop();
  }
}
