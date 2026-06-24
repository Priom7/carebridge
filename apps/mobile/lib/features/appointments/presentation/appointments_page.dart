import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/appointment_models.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final appointments = settings.appointmentsForSelectedProfile();
    return ListView(
      key: const Key('appointments-list'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.appointments,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            CareButton(
              label: l10n.addAppointment,
              icon: Icons.add,
              onPressed: () => context.push('/appointments/new'),
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.sm),
        Row(
          children: [
            Expanded(child: Text(l10n.showingDemoRecords(appointments.length))),
            TextButton.icon(
              onPressed: () => context.push('/doctors'),
              icon: const Icon(Icons.medical_services_outlined),
              label: Text(l10n.doctors),
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.md),
        for (final appointment in appointments) ...[
          InkWell(
            onTap: () => context.push('/appointments/${appointment.id}'),
            child: CareCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: CareColors.tealSoft,
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: CareColors.teal,
                    ),
                  ),
                  const SizedBox(width: CareSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.reason,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          settings.doctorById(appointment.doctorId)?.name ??
                              l10n.unknownDoctor,
                        ),
                        Text(
                          '${_date(appointment.dateTime)} · ${appointment.timezone}',
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(
                    label: appointmentStatusLabel(l10n, appointment.status),
                    status:
                        appointment.status == AppointmentStatus.missed ||
                            appointment.status == AppointmentStatus.cancelled
                        ? CareStatus.warning
                        : appointment.status == AppointmentStatus.completed
                        ? CareStatus.active
                        : CareStatus.neutral,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: CareSpacing.sm),
        ],
      ],
    );
  }

  String _date(DateTime value) =>
      '${value.day}/${value.month}/${value.year} ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
}

String appointmentStatusLabel(
  AppLocalizations l10n,
  AppointmentStatus status,
) => switch (status) {
  AppointmentStatus.scheduled => l10n.scheduled,
  AppointmentStatus.reminderSent => l10n.reminderSent,
  AppointmentStatus.completed => l10n.completed,
  AppointmentStatus.missed => l10n.missed,
  AppointmentStatus.cancelled => l10n.cancelled,
  AppointmentStatus.rescheduled => l10n.rescheduled,
  AppointmentStatus.followUpRequired => l10n.followUpRequired,
};
