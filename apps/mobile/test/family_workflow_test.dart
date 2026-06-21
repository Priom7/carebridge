import 'package:carebridge_mobile/core/settings/app_settings.dart';
import 'package:carebridge_mobile/core/theme/carebridge_theme.dart';
import 'package:carebridge_mobile/features/family/domain/family_models.dart';
import 'package:carebridge_mobile/features/family/presentation/family_management_page.dart';
import 'package:carebridge_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'invited caregiver accepts, gains permissions, and becomes owner',
    (tester) async {
      final settings = AppSettings(initiallyAuthenticated: true)
        ..createFamilyGroup(
          name: 'Sharif Family Care',
          addFather: true,
          addMother: true,
          inviteEmail: 'nadia@example.com',
        );

      await tester.pumpWidget(_testApp(settings));
      await tester.pumpAndSettle();
      expect(find.text('Pending'), findsOneWidget);
      await tester.ensureVisible(find.text('Simulate acceptance'));
      await tester.tap(find.text('Simulate acceptance'));
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(const Key('family-management-list')),
        const Offset(0, 1000),
      );
      await tester.pumpAndSettle();
      expect(find.text('Nadia Rahman'), findsOneWidget);
      expect(
        settings.familyInvitations.single.status,
        InvitationStatus.accepted,
      );

      final memberMenu = find.byTooltip('Edit permissions');
      await tester.ensureVisible(memberMenu);
      await tester.tap(memberMenu);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit permissions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Manage documents'));
      await tester.tap(find.text('Save permissions'));
      await tester.pumpAndSettle();
      expect(
        settings.familyMembers
            .singleWhere((item) => item.id == 'sibling')
            .canManageDocuments,
        isTrue,
      );

      await tester.tap(find.byTooltip('Edit permissions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Transfer ownership'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Transfer to Nadia Rahman'));
      await tester.pumpAndSettle();
      expect(
        settings.familyMembers.singleWhere((item) => item.id == 'sibling').role,
        FamilyMemberRole.owner,
      );
    },
  );

  testWidgets('pending invitation can be revoked with confirmation', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true)
      ..createFamilyGroup(
        name: 'Sharif Family Care',
        addFather: true,
        addMother: false,
        inviteEmail: 'helper@example.com',
      );
    await tester.pumpWidget(_testApp(settings));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Revoke invitation'));
    await tester.tap(find.text('Revoke invitation'));
    await tester.pumpAndSettle();
    expect(
      find.text('This invite link will stop working immediately.'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Revoke invitation'));
    await tester.pumpAndSettle();
    expect(settings.familyInvitations.single.status, InvitationStatus.revoked);
    await tester.drag(
      find.byKey(const Key('family-management-list')),
      const Offset(0, -1000),
    );
    await tester.pumpAndSettle();
    expect(find.text('Revoked'), findsOneWidget);
  });
}

Widget _testApp(AppSettings settings) {
  return ListenableBuilder(
    listenable: settings,
    builder: (context, _) => MaterialApp(
      theme: CareBridgeTheme.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: FamilyManagementPage(settings: settings),
    ),
  );
}
