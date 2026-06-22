import 'package:carebridge_mobile/core/settings/app_settings.dart';
import 'package:carebridge_mobile/core/theme/carebridge_theme.dart';
import 'package:carebridge_mobile/features/medicines/domain/medicine.dart';
import 'package:carebridge_mobile/features/medicines/presentation/medicine_form_page.dart';
import 'package:carebridge_mobile/features/medicines/presentation/medicines_page.dart';
import 'package:carebridge_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('medicine list is profile scoped and exposes low stock', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    await tester.pumpWidget(_listApp(settings));
    await tester.pumpAndSettle();
    expect(find.text('Metformin 500mg'), findsOneWidget);
    expect(find.text('Amlodipine 5mg'), findsOneWidget);
    expect(find.text('Vitamin D3 60K'), findsNothing);

    final lowStockLabels = find.text('Low stock');
    expect(lowStockLabels, findsWidgets);
    await tester.tap(lowStockLabels.first);
    await tester.pumpAndSettle();
    expect(find.text('Amlodipine 5mg'), findsOneWidget);
    expect(find.text('Metformin 500mg'), findsNothing);

    settings.setProfile('mother');
    await tester.pumpAndSettle();
    expect(find.text('No medicines in this view'), findsOneWidget);
  });

  testWidgets('caregiver creates a scheduled medicine and changes lifecycle', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    final router = GoRouter(
      initialLocation: '/medicines',
      routes: [
        GoRoute(
          path: '/medicines',
          builder: (_, _) => Scaffold(body: MedicinesPage(settings: settings)),
        ),
        GoRoute(
          path: '/medicines/new',
          builder: (_, _) => MedicineFormPage(settings: settings),
        ),
      ],
    );
    await tester.pumpWidget(_routerApp(router, settings));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add medicine'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('medicine-name')),
      'Atorvastatin 10mg',
    );
    await tester.enterText(find.byKey(const Key('medicine-strength')), '10 mg');
    await tester.enterText(
      find.byKey(const Key('medicine-dosage')),
      '1 tablet',
    );
    for (
      var i = 0;
      i < 8 && find.text('Upcoming dose preview').evaluate().isEmpty;
      i++
    ) {
      await tester.drag(
        find.byKey(const Key('medicine-form-list')),
        const Offset(0, -750),
      );
      await tester.pumpAndSettle();
    }
    expect(find.text('Upcoming dose preview'), findsOneWidget);
    expect(find.textContaining('Asia/Dhaka'), findsWidgets);
    for (
      var i = 0;
      i < 10 && find.byKey(const Key('save-medicine')).evaluate().isEmpty;
      i++
    ) {
      await tester.drag(
        find.byKey(const Key('medicine-form-list')),
        const Offset(0, -750),
      );
      await tester.pumpAndSettle();
    }
    await tester.tap(find.byKey(const Key('save-medicine')));
    await tester.pumpAndSettle();

    final created = settings.medicines.lastWhere(
      (item) => item.name == 'Atorvastatin 10mg',
    );
    expect(created.schedule.times, ['09:00']);
    expect(created.schedule.timezone, 'Asia/Dhaka');
    settings.setMedicineStatus(created.id, MedicineStatus.paused);
    expect(
      settings.medicines.singleWhere((item) => item.id == created.id).status,
      MedicineStatus.paused,
    );
    settings.setMedicineStatus(created.id, MedicineStatus.completed);
    expect(
      settings.medicines.singleWhere((item) => item.id == created.id).status,
      MedicineStatus.completed,
    );
  });
}

Widget _listApp(AppSettings settings) => ListenableBuilder(
  listenable: settings,
  builder: (context, _) => MaterialApp(
    theme: CareBridgeTheme.light,
    localizationsDelegates: _delegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: MedicinesPage(settings: settings)),
  ),
);

Widget _routerApp(GoRouter router, AppSettings settings) => ListenableBuilder(
  listenable: settings,
  builder: (context, _) => MaterialApp.router(
    theme: CareBridgeTheme.light,
    localizationsDelegates: _delegates,
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: router,
  ),
);

const _delegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
