import 'package:carebridge_mobile/app.dart';
import 'package:carebridge_mobile/core/theme/carebridge_theme.dart';
import 'package:carebridge_mobile/features/design_system/presentation/component_gallery_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('caregiver can navigate top-level destinations', (tester) async {
    await tester.pumpWidget(const CareBridgeApp(initiallyAuthenticated: true));
    await tester.pumpAndSettle();

    expect(find.text('Care overview for Father'), findsOneWidget);
    await tester.tap(find.text('Medicines'));
    await tester.pumpAndSettle();
    expect(find.text('Metformin 500mg'), findsOneWidget);

    await tester.tap(find.text('Health'));
    await tester.pumpAndSettle();
    expect(find.text('Health overview'), findsOneWidget);

    await tester.tap(find.text('Documents'));
    await tester.pumpAndSettle();
    expect(find.text('Document vault'), findsOneWidget);
  });

  testWidgets('mode switch opens simplified accessible parent home', (
    tester,
  ) async {
    await tester.pumpWidget(const CareBridgeApp(initiallyAuthenticated: true));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Parent mode'));
    await tester.pumpAndSettle();

    expect(find.text('Good morning, Father'), findsOneWidget);
    await tester.drag(
      find.byKey(const Key('parent-home-list')),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.text('Need help'), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('parent-need-help-button'))).height,
      greaterThanOrEqualTo(64),
    );
  });

  testWidgets('language and 200 percent text scale can be selected', (
    tester,
  ) async {
    await tester.pumpWidget(const CareBridgeApp(initiallyAuthenticated: true));
    await tester.pumpAndSettle();

    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byKey(const Key('more-page-list')),
      const Offset(0, -700),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('বাংলা'));
    await tester.pumpAndSettle();
    expect(find.text('আরও'), findsOneWidget);

    await tester.ensureVisible(find.text('অতি বড়'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('অতি বড়'));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byKey(const Key('more-page-list')),
      const Offset(0, 1000),
    );
    await tester.pumpAndSettle();
    expect(find.text('আরও যত্নের সরঞ্জাম'), findsOneWidget);
    final textContext = tester.element(find.text('আরও যত্নের সরঞ্জাম'));
    expect(MediaQuery.textScalerOf(textContext).scale(10), closeTo(20, .01));
    expect(tester.takeException(), isNull);
  });

  testWidgets('component gallery keeps 64px parent controls', (tester) async {
    var dark = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: CareBridgeTheme.light,
        home: StatefulBuilder(
          builder: (context, setState) => ComponentGalleryPage(
            isDark: dark,
            onThemeChanged: (value) => setState(() => dark = value),
          ),
        ),
      ),
    );

    await tester.ensureVisible(find.text('Parent-friendly controls'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Parent-friendly controls'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('taken-reminder-button')));
    await tester.pumpAndSettle();
    expect(
      tester.getSize(find.byKey(const Key('taken-reminder-button'))).height,
      greaterThanOrEqualTo(64),
    );
  });

  testWidgets('registration verifies consent and reaches dashboard', (
    tester,
  ) async {
    await tester.pumpWidget(const CareBridgeApp());
    await tester.pumpAndSettle();

    expect(find.text('Care that connects hearts, every day.'), findsOneWidget);
    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    expect(fields, findsNWidgets(5));
    await tester.enterText(fields.at(0), 'Sharif Rahman');
    await tester.enterText(fields.at(1), 'sharif@example.com');
    await tester.enterText(fields.at(2), '+447700900123');
    await tester.enterText(fields.at(3), 'carebridge123');
    await tester.enterText(fields.at(4), 'carebridge123');
    await tester.ensureVisible(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Verify your email'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('verification-code')),
      '123456',
    );
    await tester.tap(find.text('Verify'));
    await tester.pumpAndSettle();

    expect(find.text('Your care data, your choice'), findsOneWidget);
    await tester.tap(find.byKey(const Key('terms-consent')));
    await tester.tap(find.byKey(const Key('health-consent')));
    await tester.tap(find.text('Finish setup'));
    await tester.pumpAndSettle();

    expect(find.text('Create your family care circle'), findsOneWidget);
    await tester.tap(find.byKey(const Key('onboarding-next')));
    await tester.pumpAndSettle();
    expect(find.text('Who do you care for?'), findsOneWidget);
    await tester.tap(find.byKey(const Key('onboarding-next')));
    await tester.pumpAndSettle();
    expect(find.text('Invite another caregiver'), findsOneWidget);
    await tester.enterText(
      find.byKey(const Key('invite-email-field')),
      'nadia@example.com',
    );
    await tester.drag(
      find.byKey(const Key('family-onboarding-list')),
      const Offset(0, -1000),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('onboarding-next')));
    await tester.pumpAndSettle();
    expect(find.text('Review your care circle'), findsOneWidget);
    await tester.drag(
      find.byKey(const Key('family-onboarding-list')),
      const Offset(0, -1000),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('onboarding-next')));
    await tester.pumpAndSettle();
    expect(find.text('Care overview for Father'), findsOneWidget);
  });

  testWidgets('password recovery remains account-enumeration safe', (
    tester,
  ) async {
    await tester.pumpWidget(const CareBridgeApp());
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sign in'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'unknown@example.com');
    await tester.tap(find.text('Send reset link'));
    await tester.pumpAndSettle();
    expect(
      find.text('If an account exists, a reset link has been sent.'),
      findsOneWidget,
    );
  });

  testWidgets('account security revokes a device and queues export', (
    tester,
  ) async {
    await tester.pumpWidget(const CareBridgeApp(initiallyAuthenticated: true));
    await tester.pumpAndSettle();
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Account and security'));
    await tester.tap(find.text('Account and security'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Two-factor authentication'));
    await tester.pumpAndSettle();
    final twoFactor = tester.widget<SwitchListTile>(
      find.widgetWithText(SwitchListTile, 'Two-factor authentication'),
    );
    expect(twoFactor.value, isTrue);
    await tester.ensureVisible(find.text('Revoke'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Revoke'));
    await tester.pumpAndSettle();
    expect(find.text('Device access revoked'), findsOneWidget);

    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Privacy and data'));
    await tester.tap(find.text('Privacy and data'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Request export'));
    await tester.pumpAndSettle();
    expect(find.text('Your export request is queued.'), findsOneWidget);
  });
}
