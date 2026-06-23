import 'package:carebridge_mobile/core/settings/app_settings.dart';
import 'package:carebridge_mobile/features/documents/domain/health_document.dart';
import 'package:carebridge_mobile/features/documents/presentation/document_vault_page.dart';
import 'package:carebridge_mobile/features/documents/presentation/document_viewer_page.dart';
import 'package:carebridge_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('document fixtures cover volume, types, failures, and permissions', () {
    final settings = AppSettings(initiallyAuthenticated: true);
    expect(settings.documents, hasLength(40));
    expect(settings.documents.map((item) => item.type).toSet(), hasLength(15));
    expect(
      settings.documents.any(
        (item) => item.uploadStatus == DocumentUploadStatus.failed,
      ),
      isTrue,
    );
    expect(
      settings.documents.any((item) => item.visibleTo.length == 1),
      isTrue,
    );
    expect(
      settings.documentsForSelectedProfile().every(
        (item) => item.careProfileId == 'father',
      ),
      isTrue,
    );
  });

  test('failed upload retries and document lifecycle remains audited', () {
    final settings = AppSettings(initiallyAuthenticated: true);
    final failed = settings.documents.firstWhere(
      (item) => item.uploadStatus == DocumentUploadStatus.failed,
    );
    settings.retryDocumentUpload(failed.id);
    expect(
      settings.documents
          .firstWhere((item) => item.id == failed.id)
          .uploadStatus,
      DocumentUploadStatus.ready,
    );
    settings.setDocumentStatus(failed.id, HealthDocumentStatus.archived);
    final archived = settings.documents.firstWhere(
      (item) => item.id == failed.id,
    );
    expect(archived.status, HealthDocumentStatus.archived);
    expect(archived.accessHistory.last.action, 'Archived');
  });

  testWidgets('vault renders profile-scoped demo documents', (tester) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    await tester.pumpWidget(
      _app(Scaffold(body: DocumentVaultPage(settings: settings))),
    );
    expect(find.byKey(const Key('document-vault-list')), findsOneWidget);
    expect(find.textContaining('realistic local demo records'), findsOneWidget);
    expect(find.text('Upload document'), findsOneWidget);
  });

  testWidgets('secure viewer records access and exposes document history', (
    tester,
  ) async {
    final settings = AppSettings(initiallyAuthenticated: true);
    final document = settings.documentsForSelectedProfile().first;
    final count = document.accessHistory.length;
    await tester.pumpWidget(
      _app(DocumentViewerPage(settings: settings, documentId: document.id)),
    );
    expect(find.byKey(const Key('document-viewer')), findsOneWidget);
    expect(
      settings.documents
          .firstWhere((item) => item.id == document.id)
          .accessHistory
          .length,
      count + 1,
    );
    await tester.scrollUntilVisible(
      find.text('Document access history'),
      300,
      scrollable: find.descendant(
        of: find.byKey(const Key('document-viewer')),
        matching: find.byType(Scrollable),
      ),
    );
    expect(find.text('Document access history'), findsOneWidget);
  });
}

Widget _app(Widget child) => MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);
