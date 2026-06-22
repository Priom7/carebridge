import 'package:carebridge_mobile/core/settings/app_settings.dart';
import 'package:carebridge_mobile/core/theme/carebridge_theme.dart';
import 'package:carebridge_mobile/features/reminders/domain/reminder_event.dart';
import 'package:carebridge_mobile/features/reminders/presentation/reminder_action_page.dart';
import 'package:carebridge_mobile/features/reminders/presentation/reminder_history_page.dart';
import 'package:carebridge_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fixture catalog provides realistic list-scale data', () {
    final settings = AppSettings(initiallyAuthenticated: true);
    expect(settings.careProfiles.length, inInclusiveRange(30, 50));
    expect(settings.familyMembers.length, inInclusiveRange(30, 50));
    expect(settings.familyInvitations.length, inInclusiveRange(30, 50));
    expect(settings.medicines.length, inInclusiveRange(30, 50));
    expect(settings.reminders.length, inInclusiveRange(30, 50));
    expect(settings.alarmRequests.length, inInclusiveRange(30, 50));
    expect(
      settings.careProfiles.map((item) => item.fullName).toSet().length,
      greaterThan(20),
    );
  });

  test('real sign-in path loads the complete demo fixture catalog', () {
    final settings = AppSettings()..signIn();
    expect(settings.careProfiles.length, inInclusiveRange(30, 50));
    expect(settings.medicines.length, 50);
    expect(settings.reminders.length, 50);
  });

  testWidgets(
    'parent takes a due medicine while offline and action is queued',
    (tester) async {
      final settings = AppSettings(initiallyAuthenticated: true);
      await tester.pumpWidget(
        _app(ReminderActionPage(settings: settings), settings),
      );
      await tester.pumpAndSettle();
      expect(find.text('Time for your medicine'), findsOneWidget);
      expect(find.text('Metformin 500mg'), findsOneWidget);

      await tester.tap(find.text('Demo offline mode'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const Key('reminder-taken')));
      await tester.tap(find.byKey(const Key('reminder-taken')));
      await tester.pumpAndSettle();

      final event = settings.reminders.singleWhere(
        (item) => item.id == 'reminder-0',
      );
      expect(event.status, ReminderStatus.taken);
      expect(event.queuedOffline, isTrue);
      expect(
        find.text('Saved offline — this action will sync when connected.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('need help escalates immediately and history remains populated', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    await tester.pumpWidget(
      _app(ReminderActionPage(settings: settings), settings),
    );
    await tester.pumpAndSettle();
    await tester.drag(
      find.byKey(const Key('reminder-action-list')),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('reminder-help')));
    await tester.pumpAndSettle();
    expect(settings.reminders.first.status, ReminderStatus.escalated);
    expect(find.text('Help request sent to your caregiver'), findsOneWidget);

    await tester.pumpWidget(
      _app(ReminderHistoryPage(settings: settings), settings),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('realistic local demo records'), findsOneWidget);
    expect(find.text('Escalated'), findsWidgets);
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
