import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/appointment_models.dart';

class AppointmentFormPage extends StatefulWidget {
  const AppointmentFormPage({required this.settings, super.key});
  final AppSettings settings;
  @override
  State<AppointmentFormPage> createState() => _AppointmentFormPageState();
}

class _AppointmentFormPageState extends State<AppointmentFormPage> {
  final key = GlobalKey<FormState>();
  final fields = <String, TextEditingController>{
    for (final name in [
      'date',
      'time',
      'location',
      'reason',
      'questions',
      'reports',
      'notes',
      'attachments',
    ])
      name: TextEditingController(),
  };
  String timezone = 'Asia/Dhaka';
  String? doctorId;
  String error = '';
  @override
  void initState() {
    super.initState();
    fields['date']!.text = '2026-07-15';
    fields['time']!.text = '17:00';
    final doctors = widget.settings.doctorsForSelectedProfile();
    doctorId = doctors.isEmpty ? null : doctors.first.id;
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
    final doctors = widget.settings.doctorsForSelectedProfile();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addAppointment)),
      body: SafeArea(
        child: Form(
          key: key,
          child: ListView(
            key: const Key('appointment-form'),
            padding: const EdgeInsets.all(CareSpacing.lg),
            children: [
              DropdownButtonFormField<String>(
                initialValue: doctorId,
                decoration: InputDecoration(labelText: l10n.doctorName),
                items: doctors
                    .map(
                      (doctor) => DropdownMenuItem(
                        value: doctor.id,
                        child: Text('${doctor.name} · ${doctor.speciality}'),
                      ),
                    )
                    .toList(),
                onChanged: (value) => doctorId = value,
              ),
              const SizedBox(height: CareSpacing.md),
              _field(
                'date',
                l10n.appointmentDate,
                required: true,
                hint: 'YYYY-MM-DD',
              ),
              _gap,
              _field(
                'time',
                l10n.appointmentTime,
                required: true,
                hint: 'HH:MM',
              ),
              _gap,
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
              _gap,
              _field('location', l10n.location, required: true),
              _gap,
              _field('reason', l10n.reasonForVisit, required: true),
              _gap,
              _field(
                'questions',
                l10n.questionsForDoctor,
                lines: 3,
                hint: l10n.onePerLine,
              ),
              _gap,
              _field(
                'reports',
                l10n.requiredReports,
                lines: 2,
                hint: l10n.onePerLine,
              ),
              _gap,
              _field('attachments', l10n.attachments, hint: 'report.pdf'),
              _gap,
              _field('notes', l10n.caregiverNotes, lines: 3),
              if (error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: CareSpacing.sm),
                  child: Text(
                    error,
                    style: const TextStyle(color: CareColors.red),
                  ),
                ),
              CareButton(
                key: const Key('save-appointment'),
                expanded: true,
                label: l10n.scheduleAppointment,
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
    String name,
    String label, {
    bool required = false,
    int lines = 1,
    String? hint,
  }) => TextFormField(
    controller: fields[name],
    maxLines: lines,
    decoration: InputDecoration(labelText: label, hintText: hint),
    validator: required
        ? (value) => value == null || value.trim().isEmpty
              ? '$label is required'
              : null
        : null,
  );
  void _save() {
    final l10n = AppLocalizations.of(context);
    if (!key.currentState!.validate() || doctorId == null) return;
    final value = DateTime.tryParse(
      '${fields['date']!.text.trim()}T${fields['time']!.text.trim()}:00',
    );
    if (value == null) {
      setState(() => error = l10n.invalidAppointmentDate);
      return;
    }
    if (value.isBefore(DateTime.now())) {
      setState(() => error = l10n.pastAppointmentError);
      return;
    }
    if (widget.settings.hasAppointmentConflict(value)) {
      setState(() => error = l10n.appointmentConflict);
      return;
    }
    widget.settings.saveAppointment(
      Appointment(
        id: 'appointment-live-${DateTime.now().microsecondsSinceEpoch}',
        careProfileId: widget.settings.selectedProfile,
        doctorId: doctorId!,
        dateTime: value,
        timezone: timezone,
        location: fields['location']!.text.trim(),
        reason: fields['reason']!.text.trim(),
        questions: _lines('questions'),
        requiredReports: _lines('reports'),
        status: AppointmentStatus.scheduled,
        followUpRequired: false,
        followUpDate: '',
        visitSummary: '',
        attachments: _lines('attachments'),
        caregiverNotes: fields['notes']!.text.trim(),
      ),
    );
    context.pop();
  }

  List<String> _lines(String name) => fields[name]!.text
      .split(RegExp('[,\n]'))
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .toList();
}
