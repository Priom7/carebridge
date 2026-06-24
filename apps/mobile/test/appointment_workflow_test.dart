import 'package:carebridge_mobile/core/settings/app_settings.dart';
import 'package:carebridge_mobile/features/appointments/domain/appointment_models.dart';
import 'package:carebridge_mobile/features/appointments/presentation/appointment_detail_page.dart';
import 'package:carebridge_mobile/features/appointments/presentation/appointments_page.dart';
import 'package:carebridge_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('doctor and appointment fixtures cover scale and every status', () {
    final settings = AppSettings(initiallyAuthenticated: true);
    expect(settings.doctors, hasLength(30));
    expect(settings.appointments, hasLength(40));
    expect(
      settings.appointments.map((item) => item.status).toSet(),
      hasLength(AppointmentStatus.values.length),
    );
    expect(
      settings.appointmentsForSelectedProfile().every(
        (item) => item.careProfileId == 'father',
      ),
      isTrue,
    );
  });

  test('conflicts are detected and reschedule completion enters timeline', () {
    final settings = AppSettings(initiallyAuthenticated: true);
    final appointment = settings.appointmentsForSelectedProfile().first;
    expect(settings.hasAppointmentConflict(appointment.dateTime), isTrue);
    final next = DateTime(2027, 1, 5, 10);
    settings.rescheduleAppointment(appointment.id, next);
    expect(
      settings.appointments
          .firstWhere((item) => item.id == appointment.id)
          .status,
      AppointmentStatus.rescheduled,
    );
    settings.completeAppointment(
      appointment.id,
      summary: 'Continue current treatment.',
      followUpRequired: true,
      followUpDate: '2027-03-05',
    );
    final completed = settings.appointments.firstWhere(
      (item) => item.id == appointment.id,
    );
    expect(completed.status, AppointmentStatus.followUpRequired);
    expect(completed.visitSummary, isNotEmpty);
    expect(settings.timelineEvents.first, contains('completed'));
  });

  testWidgets('appointment list renders profile fixtures and doctor access', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    await tester.pumpWidget(
      _app(Scaffold(body: AppointmentsPage(settings: settings))),
    );
    expect(find.byKey(const Key('appointments-list')), findsOneWidget);
    expect(find.text('Add appointment'), findsOneWidget);
    expect(find.text('Doctors'), findsOneWidget);
  });

  testWidgets('visit pack is explicit preview and completion is actionable', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    final appointment = settings.appointmentsForSelectedProfile().first;
    await tester.pumpWidget(
      _app(
        AppointmentDetailPage(
          settings: settings,
          appointmentId: appointment.id,
        ),
      ),
    );
    expect(find.text('Doctor visit pack'), findsOneWidget);
    expect(find.textContaining('PDF export will be available'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('complete-appointment')),
      400,
      scrollable: find.descendant(
        of: find.byKey(const Key('appointment-detail')),
        matching: find.byType(Scrollable),
      ),
    );
    await tester.tap(find.byKey(const Key('complete-appointment')));
    await tester.pump();
    expect(
      settings.appointments
          .firstWhere((item) => item.id == appointment.id)
          .status,
      AppointmentStatus.completed,
    );
  });
}

Widget _app(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);
