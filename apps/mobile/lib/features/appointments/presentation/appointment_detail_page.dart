import 'package:flutter/material.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import 'appointments_page.dart';

class AppointmentDetailPage extends StatefulWidget {
  const AppointmentDetailPage({
    required this.settings,
    required this.appointmentId,
    super.key,
  });
  final AppSettings settings;
  final String appointmentId;
  @override
  State<AppointmentDetailPage> createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {
  final summary = TextEditingController();
  final followUpDate = TextEditingController(text: '2026-09-15');
  bool followUp = false;
  @override
  void dispose() {
    summary.dispose();
    followUpDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final matches = widget.settings.appointments.where(
      (item) => item.id == widget.appointmentId,
    );
    if (matches.isEmpty) {
      return Scaffold(body: Center(child: Text(l10n.pageNotFound)));
    }
    final appointment = matches.first;
    final doctor = widget.settings.doctorById(appointment.doctorId);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.appointmentDetails)),
      body: SafeArea(
        child: ListView(
          key: const Key('appointment-detail'),
          padding: const EdgeInsets.all(CareSpacing.lg),
          children: [
            CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          appointment.reason,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      StatusBadge(
                        label: appointmentStatusLabel(l10n, appointment.status),
                        status: CareStatus.neutral,
                      ),
                    ],
                  ),
                  Text(doctor?.name ?? l10n.unknownDoctor),
                  Text('${appointment.dateTime} · ${appointment.timezone}'),
                  Text(appointment.location),
                  if (appointment.visitSummary.isNotEmpty)
                    Text('${l10n.visitSummary}: ${appointment.visitSummary}'),
                  if (appointment.followUpDate.isNotEmpty)
                    Text('${l10n.followUpDate}: ${appointment.followUpDate}'),
                ],
              ),
            ),
            const SizedBox(height: CareSpacing.lg),
            Text(
              l10n.doctorVisitPack,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(l10n.visitPackFutureNote),
            const SizedBox(height: CareSpacing.sm),
            CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _section(
                    l10n.currentMedicines,
                    widget.settings
                        .medicinesForSelectedProfile()
                        .take(4)
                        .map((item) => item.name),
                  ),
                  _section(l10n.questionsForDoctor, appointment.questions),
                  _section(l10n.requiredReports, appointment.requiredReports),
                  _section(l10n.attachments, appointment.attachments),
                  _section(l10n.caregiverNotes, [appointment.caregiverNotes]),
                ],
              ),
            ),
            const SizedBox(height: CareSpacing.md),
            CareButton(
              expanded: true,
              label: l10n.rescheduleSevenDays,
              style: CareButtonStyle.secondary,
              onPressed: () {
                final next = appointment.dateTime.add(const Duration(days: 7));
                if (widget.settings.hasAppointmentConflict(
                  next,
                  excludingId: appointment.id,
                )) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.appointmentConflict)),
                  );
                } else {
                  widget.settings.rescheduleAppointment(appointment.id, next);
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: CareSpacing.lg),
            Text(
              l10n.completeVisit,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextField(
              controller: summary,
              maxLines: 3,
              decoration: InputDecoration(labelText: l10n.visitSummary),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.followUpRequired),
              value: followUp,
              onChanged: (value) => setState(() => followUp = value),
            ),
            if (followUp)
              TextField(
                controller: followUpDate,
                decoration: InputDecoration(
                  labelText: l10n.followUpDate,
                  hintText: 'YYYY-MM-DD',
                ),
              ),
            const SizedBox(height: CareSpacing.sm),
            CareButton(
              key: const Key('complete-appointment'),
              expanded: true,
              label: l10n.saveVisitNotes,
              onPressed: () {
                widget.settings.completeAppointment(
                  appointment.id,
                  summary: summary.text.trim(),
                  followUpRequired: followUp,
                  followUpDate: followUp ? followUpDate.text.trim() : '',
                );
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, Iterable<String> values) {
    final items = values.where((value) => value.isNotEmpty).toList();
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: CareSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          for (final item in items) Text('• $item'),
        ],
      ),
    );
  }
}
