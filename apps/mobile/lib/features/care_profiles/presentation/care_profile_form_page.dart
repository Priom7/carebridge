import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/care_profile.dart';

class CareProfileFormPage extends StatefulWidget {
  const CareProfileFormPage({required this.settings, this.profile, super.key});
  final AppSettings settings;
  final CareProfile? profile;

  @override
  State<CareProfileFormPage> createState() => _CareProfileFormPageState();
}

class _CareProfileFormPageState extends State<CareProfileFormPage> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> fields;
  late String gender;
  late String bloodGroup;
  late String timezone;
  late String language;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    fields = {
      'fullName': TextEditingController(text: p?.fullName),
      'preferredName': TextEditingController(text: p?.preferredName),
      'relationship': TextEditingController(text: p?.relationship),
      'dateOfBirth': TextEditingController(text: p?.dateOfBirth),
      'phone': TextEditingController(text: p?.phone),
      'address': TextEditingController(text: p?.address),
      'city': TextEditingController(text: p?.city),
      'country': TextEditingController(text: p?.country ?? 'Bangladesh'),
      'conditions': TextEditingController(text: p?.medicalConditions),
      'allergies': TextEditingController(text: p?.allergies),
      'mobility': TextEditingController(text: p?.mobilityNotes),
      'doctor': TextEditingController(text: p?.doctorNotes),
      'emergency': TextEditingController(text: p?.emergencyInstructions),
      'primary': TextEditingController(
        text: p?.primaryCaregiver ?? 'Sharif Rahman',
      ),
      'secondary': TextEditingController(
        text: p?.secondaryCaregiver ?? 'Nadia Rahman',
      ),
    };
    gender = p?.gender ?? 'Male';
    bloodGroup = p?.bloodGroup ?? 'B+';
    timezone = p?.timezone ?? 'Asia/Dhaka';
    language = p?.language ?? 'Bangla';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.profile == null ? l10n.addCareProfile : l10n.editCareProfile,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            key: const Key('care-profile-form'),
            padding: const EdgeInsets.all(CareSpacing.lg),
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      child: Text(
                        widget.profile?.initials ?? '+',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: Text(l10n.addPhoto),
                    ),
                  ],
                ),
              ),
              _section(context, l10n.careProfiles, [
                _field('fullName', l10n.fullName, required: true),
                _field('preferredName', l10n.preferredName, required: true),
                _field('relationship', l10n.relationship, required: true),
                _field('dateOfBirth', l10n.dateOfBirth, hint: 'YYYY-MM-DD'),
                DropdownButtonFormField<String>(
                  initialValue: gender,
                  decoration: InputDecoration(labelText: l10n.gender),
                  items: ['Male', 'Female', 'Other']
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(
                            value == 'Male'
                                ? l10n.male
                                : value == 'Female'
                                ? l10n.female
                                : l10n.other,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => gender = value ?? gender,
                ),
                DropdownButtonFormField<String>(
                  initialValue: bloodGroup,
                  decoration: InputDecoration(labelText: l10n.bloodGroup),
                  items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                      .map(
                        (value) =>
                            DropdownMenuItem(value: value, child: Text(value)),
                      )
                      .toList(),
                  onChanged: (value) => bloodGroup = value ?? bloodGroup,
                ),
              ]),
              _section(context, l10n.contactAndLocation, [
                _field(
                  'phone',
                  l10n.phoneNumber,
                  keyboardType: TextInputType.phone,
                ),
                _field('address', l10n.address),
                _field('city', l10n.city),
                _field('country', l10n.country),
                DropdownButtonFormField<String>(
                  initialValue: timezone,
                  decoration: InputDecoration(labelText: l10n.timezone),
                  items: ['Asia/Dhaka', 'Europe/London', 'UTC']
                      .map(
                        (value) =>
                            DropdownMenuItem(value: value, child: Text(value)),
                      )
                      .toList(),
                  onChanged: (value) => timezone = value ?? timezone,
                ),
                DropdownButtonFormField<String>(
                  initialValue: language,
                  decoration: InputDecoration(
                    labelText: l10n.preferredLanguage,
                  ),
                  items: ['Bangla', 'English']
                      .map(
                        (value) =>
                            DropdownMenuItem(value: value, child: Text(value)),
                      )
                      .toList(),
                  onChanged: (value) => language = value ?? language,
                ),
              ]),
              _section(context, l10n.healthAndSafety, [
                _field('conditions', l10n.medicalConditions, lines: 2),
                _field('allergies', l10n.allergies, lines: 2),
                _field('mobility', l10n.mobilityNotes, lines: 2),
                _field('doctor', l10n.doctorNotes, lines: 2),
                _field('emergency', l10n.emergencyInstructions, lines: 3),
              ]),
              _section(context, l10n.careTeam, [
                _field('primary', l10n.primaryCaregiver),
                _field('secondary', l10n.secondaryCaregiverLabel),
              ]),
              CareButton(
                key: const Key('save-care-profile'),
                expanded: true,
                label: l10n.saveProfile,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(BuildContext context, String title, List<Widget> children) =>
      Padding(
        padding: const EdgeInsets.only(bottom: CareSpacing.lg),
        child: CareCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: CareSpacing.md),
              for (var i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
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
    String? hint,
    TextInputType? keyboardType,
  }) => TextFormField(
    key: Key('profile-$key'),
    controller: fields[key],
    maxLines: lines,
    keyboardType: keyboardType,
    decoration: InputDecoration(labelText: label, hintText: hint),
    validator: required
        ? (value) => value == null || value.trim().isEmpty
              ? AppLocalizations.of(context).requiredField
              : null
        : null,
  );

  void _save() {
    if (!formKey.currentState!.validate()) return;
    final existing = widget.profile;
    final profile = CareProfile(
      id: existing?.id ?? 'profile-${DateTime.now().millisecondsSinceEpoch}',
      fullName: fields['fullName']!.text.trim(),
      preferredName: fields['preferredName']!.text.trim(),
      relationship: fields['relationship']!.text.trim(),
      dateOfBirth: fields['dateOfBirth']!.text.trim(),
      gender: gender,
      bloodGroup: bloodGroup,
      phone: fields['phone']!.text.trim(),
      address: fields['address']!.text.trim(),
      city: fields['city']!.text.trim(),
      country: fields['country']!.text.trim(),
      timezone: timezone,
      language: language,
      medicalConditions: fields['conditions']!.text.trim(),
      allergies: fields['allergies']!.text.trim(),
      mobilityNotes: fields['mobility']!.text.trim(),
      doctorNotes: fields['doctor']!.text.trim(),
      emergencyInstructions: fields['emergency']!.text.trim(),
      primaryCaregiver: fields['primary']!.text.trim(),
      secondaryCaregiver: fields['secondary']!.text.trim(),
      status: existing?.status ?? CareProfileStatus.active,
      medicinesDue: existing?.medicinesDue ?? 0,
      missedReminders: existing?.missedReminders ?? 0,
      documentsThisWeek: existing?.documentsThisWeek ?? 0,
      upcomingAppointment: existing?.upcomingAppointment ?? '',
    );
    widget.settings.saveCareProfile(profile);
    context.pop();
  }
}
