import 'package:carebridge_mobile/core/settings/app_settings.dart';
import 'package:carebridge_mobile/core/theme/carebridge_theme.dart';
import 'package:carebridge_mobile/features/care_profiles/domain/care_profile.dart';
import 'package:carebridge_mobile/features/care_profiles/presentation/care_profile_form_page.dart';
import 'package:carebridge_mobile/features/care_profiles/presentation/care_profiles_page.dart';
import 'package:carebridge_mobile/features/navigation/presentation/caregiver_home_page.dart';
import 'package:carebridge_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('profile switch updates caregiver dashboard', (tester) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    await tester.pumpWidget(
      _localizedHome(CaregiverHomePage(settings: settings), settings),
    );
    await tester.pumpAndSettle();
    expect(find.text('Care overview for Father'), findsOneWidget);

    settings.setProfile('mother');
    await tester.pumpAndSettle();
    expect(find.text('Care overview for Mother'), findsOneWidget);
    expect(find.text('Care time: Asia/Dhaka'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('caregiver creates and archives a complete care profile', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    final router = GoRouter(
      initialLocation: '/profiles',
      routes: [
        GoRoute(
          path: '/profiles',
          builder: (_, _) =>
              Scaffold(body: CareProfilesPage(settings: settings)),
        ),
        GoRoute(
          path: '/profiles/new',
          builder: (_, _) => CareProfileFormPage(settings: settings),
        ),
      ],
    );
    await tester.pumpWidget(_routerApp(router, settings));
    await tester.pumpAndSettle();
    expect(find.text('Abdul Karim'), findsOneWidget);
    expect(find.text('Salma Begum'), findsOneWidget);

    await tester.tap(find.text('Add care profile'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('profile-fullName')),
      'Rafi Ahmed',
    );
    await tester.enterText(
      find.byKey(const Key('profile-preferredName')),
      'Uncle Rafi',
    );
    await tester.enterText(
      find.byKey(const Key('profile-relationship')),
      'Uncle',
    );
    for (var i = 0; i < 6; i++) {
      await tester.drag(
        find.byKey(const Key('care-profile-form')),
        const Offset(0, -700),
      );
      await tester.pumpAndSettle();
    }
    await tester.tap(find.byKey(const Key('save-care-profile')));
    await tester.pumpAndSettle();

    expect(
      settings.careProfiles.any((item) => item.fullName == 'Rafi Ahmed'),
      isTrue,
    );
    await tester.drag(
      find.byKey(const Key('care-profiles-list')),
      const Offset(0, 1000),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('archive-profile-father')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Archive profile'));
    await tester.pumpAndSettle();
    expect(
      settings.careProfiles.singleWhere((item) => item.id == 'father').status,
      CareProfileStatus.archived,
    );
  });
}

Widget _localizedHome(Widget home, AppSettings settings) {
  return ListenableBuilder(
    listenable: settings,
    builder: (context, _) => MaterialApp(
      theme: CareBridgeTheme.light,
      localizationsDelegates: _delegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ),
  );
}

Widget _routerApp(GoRouter router, AppSettings settings) {
  return ListenableBuilder(
    listenable: settings,
    builder: (context, _) => MaterialApp.router(
      theme: CareBridgeTheme.light,
      localizationsDelegates: _delegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    ),
  );
}

const _delegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
