import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/health_document.dart';

class DocumentVaultPage extends StatefulWidget {
  const DocumentVaultPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  State<DocumentVaultPage> createState() => _DocumentVaultPageState();
}

class _DocumentVaultPageState extends State<DocumentVaultPage> {
  final search = TextEditingController();
  HealthDocumentType? type;
  bool includeArchived = false;

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final source = widget.settings.documentsForSelectedProfile();
    final query = search.text.trim().toLowerCase();
    final documents = source.where((document) {
      if (document.status == HealthDocumentStatus.deleted) return false;
      if (!includeArchived &&
          document.status == HealthDocumentStatus.archived) {
        return false;
      }
      if (type != null && document.type != type) return false;
      return query.isEmpty ||
          '${document.title} ${document.doctorName} ${document.tags.join(' ')}'
              .toLowerCase()
              .contains(query);
    }).toList();
    return ListView(
      key: const Key('document-vault-list'),
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.documentVault,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            CareButton(
              label: l10n.uploadDocument,
              icon: Icons.upload_file,
              onPressed: () => context.push('/documents/upload'),
            ),
          ],
        ),
        const SizedBox(height: CareSpacing.sm),
        Text(l10n.showingDemoRecords(source.length)),
        const SizedBox(height: CareSpacing.md),
        TextField(
          controller: search,
          decoration: InputDecoration(
            labelText: l10n.searchDocuments,
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: CareSpacing.sm),
        DropdownButtonFormField<HealthDocumentType?>(
          initialValue: type,
          decoration: InputDecoration(labelText: l10n.filterDocumentType),
          items: [
            DropdownMenuItem(value: null, child: Text(l10n.allDocuments)),
            ...HealthDocumentType.values.map(
              (value) => DropdownMenuItem(
                value: value,
                child: Text(documentTypeLabel(l10n, value)),
              ),
            ),
          ],
          onChanged: (value) => setState(() => type = value),
        ),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          title: Text(l10n.includeArchived),
          value: includeArchived,
          onChanged: (value) => setState(() => includeArchived = value),
        ),
        if (documents.isEmpty)
          CareCard(child: Center(child: Text(l10n.noDocuments))),
        for (final document in documents) ...[
          InkWell(
            onTap: () => context.push('/documents/${document.id}'),
            child: CareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: CareColors.blueSoft,
                        child: Icon(
                          document.isImage
                              ? Icons.image_outlined
                              : Icons.picture_as_pdf_outlined,
                          color: CareColors.blue,
                        ),
                      ),
                      const SizedBox(width: CareSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              document.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              '${documentTypeLabel(l10n, document.type)} · ${document.documentDate}',
                            ),
                            Text(document.doctorName),
                          ],
                        ),
                      ),
                      if (document.status == HealthDocumentStatus.archived)
                        StatusBadge(
                          label: l10n.archived,
                          status: CareStatus.neutral,
                        ),
                    ],
                  ),
                  if (document.uploadStatus == DocumentUploadStatus.failed) ...[
                    const SizedBox(height: CareSpacing.sm),
                    LinearProgressIndicator(
                      value: document.uploadProgress,
                      color: CareColors.red,
                    ),
                    Row(
                      children: [
                        Expanded(child: Text(l10n.uploadFailed)),
                        TextButton(
                          onPressed: () =>
                              widget.settings.retryDocumentUpload(document.id),
                          child: Text(l10n.retryUpload),
                        ),
                      ],
                    ),
                  ],
                  Wrap(
                    spacing: CareSpacing.xs,
                    children: [
                      for (final tag in document.tags) Chip(label: Text(tag)),
                    ],
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
}

String documentTypeLabel(AppLocalizations l10n, HealthDocumentType type) =>
    switch (type) {
      HealthDocumentType.prescription => l10n.prescription,
      HealthDocumentType.bloodTest => l10n.bloodTestReport,
      HealthDocumentType.urineTest => l10n.urineTestReport,
      HealthDocumentType.ecg => 'ECG',
      HealthDocumentType.xray => 'X-ray',
      HealthDocumentType.mri => 'MRI',
      HealthDocumentType.ctScan => 'CT scan',
      HealthDocumentType.ultrasound => l10n.ultrasound,
      HealthDocumentType.dischargeSummary => l10n.dischargeSummary,
      HealthDocumentType.doctorNote => l10n.doctorNote,
      HealthDocumentType.medicinePhoto => l10n.medicinePhoto,
      HealthDocumentType.hospitalBill => l10n.hospitalBill,
      HealthDocumentType.insurance => l10n.insuranceDocument,
      HealthDocumentType.followUpNote => l10n.followUpNote,
      HealthDocumentType.other => l10n.other,
    };
