import 'package:carebridge_mobile/core/settings/app_settings.dart';
import 'package:carebridge_mobile/features/emergency/domain/emergency_models.dart';
import 'package:carebridge_mobile/features/emergency/presentation/emergency_alert_detail_page.dart';
import 'package:carebridge_mobile/features/emergency/presentation/emergency_contacts_page.dart';
import 'package:carebridge_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('demo catalog has realistic emergency fixture volumes', () {
    final settings = AppSettings(initiallyAuthenticated: true);
    expect(settings.emergencyContacts, hasLength(40));
    expect(settings.emergencyAlerts, hasLength(40));
    expect(settings.emergencyContactsForSelectedProfile(), isNotEmpty);
    expect(
      settings.emergencyContactsForSelectedProfile().every(
        (contact) => contact.careProfileId == settings.selectedProfile,
      ),
      isTrue,
    );
  });

  test('contact defaults can enforce least privilege', () {
    final settings = AppSettings(initiallyAuthenticated: true);
    const contact = EmergencyContact(
      id: 'test-contact',
      careProfileId: 'father',
      fullName: 'Rahim Ahmed',
      relationship: 'Neighbour',
      contactType: 'Neighbour',
      primaryPhone: '+880 1700 000000',
      secondaryPhone: '',
      whatsappNumber: '',
      email: '',
      address: 'Dhanmondi, Dhaka',
      distanceNote: 'Same building',
      availabilityNote: 'Evenings',
      preferredContactMethod: 'Call',
      priorityLevel: 1,
      verificationStatus: ContactVerificationStatus.added,
      canReceiveEmergencyAlerts: true,
      canReceiveMissedMedicineAlerts: false,
      canViewBasicProfile: true,
      canViewMedicalSummary: false,
      canViewDocuments: false,
      canViewLocation: false,
      notes: '',
    );
    settings.saveEmergencyContact(contact);
    expect(settings.emergencyContacts.last.canViewDocuments, isFalse);
    expect(settings.emergencyContacts.last.canReceiveEmergencyAlerts, isTrue);
  });

  testWidgets('contact list renders selected-profile fixtures', (tester) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    await tester.pumpWidget(_app(EmergencyContactsPage(settings: settings)));
    expect(find.byKey(const Key('emergency-contacts-list')), findsOneWidget);
    expect(find.textContaining('realistic local demo records'), findsOneWidget);
  });

  testWidgets('alert can be accepted and resolved with timeline updates', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    final alert = settings.triggerEmergencyAlert(reason: 'Parent needs help');
    await tester.pumpWidget(
      _app(
        ListenableBuilder(
          listenable: settings,
          builder: (_, _) =>
              EmergencyAlertDetailPage(settings: settings, alertId: alert.id),
        ),
      ),
    );
    await tester.tap(find.byKey(const Key('accept-emergency-alert')));
    await tester.pump();
    expect(settings.emergencyAlerts.last.status, EmergencyAlertStatus.accepted);
    await tester.tap(find.byKey(const Key('resolve-emergency-alert')));
    await tester.pump();
    expect(settings.emergencyAlerts.last.status, EmergencyAlertStatus.resolved);
    expect(settings.emergencyAlerts.last.timeline.last, 'Alert resolved');
  });
}

Widget _app(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);
