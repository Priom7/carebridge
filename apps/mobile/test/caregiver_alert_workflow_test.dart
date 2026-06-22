import 'package:carebridge_mobile/core/settings/app_settings.dart';
import 'package:carebridge_mobile/core/theme/carebridge_theme.dart';
import 'package:carebridge_mobile/features/reminders/domain/alarm_request.dart';
import 'package:carebridge_mobile/features/reminders/domain/reminder_event.dart';
import 'package:carebridge_mobile/features/reminders/presentation/caregiver_alert_detail_page.dart';
import 'package:carebridge_mobile/features/reminders/presentation/caregiver_alerts_page.dart';
import 'package:carebridge_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'caregiver sees missed alerts and sends a rate-limited remote ring',
    (tester) async {
      final settings = AppSettings(initiallyAuthenticated: true);
      expect(settings.alarmRequests.length, 40);
      await tester.pumpWidget(
        _app(Scaffold(body: CaregiverAlertsPage(settings: settings)), settings),
      );
      await tester.pumpAndSettle();
      expect(find.text('Caregiver alerts'), findsOneWidget);
      expect(
        find.text('Showing 40 realistic local demo records'),
        findsOneWidget,
      );

      final missed = settings.reminders.firstWhere(
        (item) =>
            item.careProfileId == 'father' &&
            item.status == ReminderStatus.missed,
      );
      await tester.pumpWidget(
        _app(
          CaregiverAlertDetailPage(settings: settings, reminder: missed),
          settings,
        ),
      );
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(const Key('caregiver-alert-detail')),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('remote-ring-button')));
      await tester.pumpAndSettle();

      expect(settings.alarmRequests.length, 41);
      expect(settings.alarmRequests.last.status, AlarmDeliveryStatus.delivered);
      expect(
        find.text('Remote ring delivered to the parent device.'),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key('remote-ring-button')));
      await tester.pumpAndSettle();
      expect(
        find.text('Please wait before sending another alarm.'),
        findsOneWidget,
      );
    },
  );

  test('caregiver can resolve a missed alert', () {
    final settings = AppSettings(initiallyAuthenticated: true);
    final missed = settings.reminders.firstWhere(
      (item) => item.status == ReminderStatus.missed,
    );
    settings.resolveReminder(missed.id);
    expect(
      settings.reminders.singleWhere((item) => item.id == missed.id).status,
      ReminderStatus.resolved,
    );
  });
}

Widget _app(Widget home, AppSettings settings) => ListenableBuilder(
  listenable: settings,
  builder: (context, _) => MaterialApp(
    theme: CareBridgeTheme.light,
    localizationsDelegates: _delegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

const _delegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
