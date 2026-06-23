import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/health_document.dart';
import 'document_vault_page.dart';

class DocumentUploadPage extends StatefulWidget {
  const DocumentUploadPage({required this.settings, super.key});
  final AppSettings settings;
  @override
  State<DocumentUploadPage> createState() => _DocumentUploadPageState();
}

class _DocumentUploadPageState extends State<DocumentUploadPage> {
  final key = GlobalKey<FormState>();
  final fields = <String, TextEditingController>{
    for (final name in [
      'title',
      'doctor',
      'hospital',
      'date',
      'tags',
      'notes',
      'medicine',
      'appointment',
      'condition',
    ])
      name: TextEditingController(),
  };
  HealthDocumentType type = HealthDocumentType.prescription;
  String fileName = '';
  String mimeType = '';
  int fileSize = 0;
  double progress = 0;
  String error = '';
  bool shareNadia = false;

  @override
  void dispose() {
    for (final field in fields.values) {
      field.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.uploadDocument)),
      body: SafeArea(
        child: Form(
          key: key,
          child: ListView(
            key: const Key('document-upload-form'),
            padding: const EdgeInsets.all(CareSpacing.lg),
            children: [
              CareCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.chooseFile,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: CareSpacing.sm),
                    Wrap(
                      spacing: CareSpacing.sm,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () => _pick(
                            'carebridge_report.pdf',
                            'application/pdf',
                            850000,
                          ),
                          icon: const Icon(Icons.picture_as_pdf_outlined),
                          label: Text(l10n.choosePdf),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _pick(
                            'prescription_photo.jpg',
                            'image/jpeg',
                            1200000,
                          ),
                          icon: const Icon(Icons.photo_library_outlined),
                          label: Text(l10n.chooseImage),
                        ),
                        OutlinedButton.icon(
                          onPressed: () =>
                              _pick('camera_capture.jpg', 'image/jpeg', 980000),
                          icon: const Icon(Icons.camera_alt_outlined),
                          label: Text(l10n.takePhoto),
                        ),
                      ],
                    ),
                    if (fileName.isNotEmpty) ...[
                      const SizedBox(height: CareSpacing.sm),
                      Text(
                        '$fileName · ${(fileSize / 1000000).toStringAsFixed(1)} MB',
                      ),
                      LinearProgressIndicator(value: progress),
                    ],
                    if (error.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: CareSpacing.sm),
                        child: Text(
                          error,
                          style: const TextStyle(color: CareColors.red),
                        ),
                      ),
                    const SizedBox(height: CareSpacing.sm),
                    Wrap(
                      spacing: CareSpacing.sm,
                      children: [
                        TextButton(
                          onPressed: () => setState(
                            () => error = l10n.cameraPermissionDenied,
                          ),
                          child: Text(l10n.simulateCameraDenied),
                        ),
                        TextButton(
                          onPressed: () => _pick(
                            'oversized_scan.tiff',
                            'image/tiff',
                            30000000,
                          ),
                          child: Text(l10n.simulateInvalidFile),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CareSpacing.lg),
              CareCard(
                child: Column(
                  children: [
                    _field('title', l10n.documentTitle, required: true),
                    _gap,
                    DropdownButtonFormField<HealthDocumentType>(
                      initialValue: type,
                      decoration: InputDecoration(labelText: l10n.documentType),
                      items: HealthDocumentType.values
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(documentTypeLabel(l10n, value)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => type = value ?? type,
                    ),
                    _gap,
                    _field('doctor', l10n.doctorName),
                    _gap,
                    _field('hospital', l10n.hospitalClinic),
                    _gap,
                    _field('date', l10n.documentDate, hint: 'YYYY-MM-DD'),
                    _gap,
                    _field('tags', l10n.tags, hint: 'routine, cardiology'),
                    _gap,
                    _field('medicine', l10n.linkedMedicine),
                    _gap,
                    _field('appointment', l10n.linkedAppointment),
                    _gap,
                    _field('condition', l10n.linkedCondition),
                    _gap,
                    _field('notes', l10n.notes, lines: 3),
                  ],
                ),
              ),
              const SizedBox(height: CareSpacing.lg),
              CareCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.visibilityPermissions,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: CareSpacing.xs),
                    Text(l10n.documentPermissionWarning),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Sharif Rahman'),
                      subtitle: Text(l10n.ownerRequired),
                      value: true,
                      onChanged: null,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Nadia Rahman'),
                      value: shareNadia,
                      onChanged: (value) =>
                          setState(() => shareNadia = value ?? false),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CareSpacing.lg),
              CareButton(
                key: const Key('save-document'),
                expanded: true,
                label: l10n.uploadAndSave,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _gap = SizedBox(height: CareSpacing.md);
  Widget _field(
    String name,
    String label, {
    bool required = false,
    int lines = 1,
    String? hint,
  }) => TextFormField(
    controller: fields[name],
    maxLines: lines,
    decoration: InputDecoration(labelText: label, hintText: hint),
    validator: required
        ? (value) => value == null || value.trim().isEmpty
              ? '$label is required'
              : null
        : null,
  );

  void _pick(String name, String mime, int bytes) {
    final l10n = AppLocalizations.of(context);
    if (!['application/pdf', 'image/jpeg', 'image/png'].contains(mime)) {
      setState(() => error = l10n.unsupportedFileType);
      return;
    }
    if (bytes > 20 * 1000 * 1000) {
      setState(() => error = l10n.fileTooLarge);
      return;
    }
    setState(() {
      fileName = name;
      mimeType = mime;
      fileSize = bytes;
      progress = .72;
      error = '';
    });
  }

  void _save() {
    final l10n = AppLocalizations.of(context);
    if (!key.currentState!.validate()) return;
    if (fileName.isEmpty) {
      setState(() => error = l10n.chooseFileFirst);
      return;
    }
    final now = DateTime.now();
    widget.settings.saveDocument(
      HealthDocument(
        id: 'document-live-${now.microsecondsSinceEpoch}',
        careProfileId: widget.settings.selectedProfile,
        title: fields['title']!.text.trim(),
        type: type,
        doctorName: fields['doctor']!.text.trim(),
        hospitalName: fields['hospital']!.text.trim(),
        documentDate: fields['date']!.text.trim(),
        tags: fields['tags']!.text
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
            .toList(),
        fileName: fileName,
        fileSizeBytes: fileSize,
        mimeType: mimeType,
        notes: fields['notes']!.text.trim(),
        uploadedBy: 'Sharif Rahman',
        visibleTo: ['Sharif Rahman', if (shareNadia) 'Nadia Rahman'],
        linkedMedicine: fields['medicine']!.text.trim(),
        linkedAppointment: fields['appointment']!.text.trim(),
        linkedCondition: fields['condition']!.text.trim(),
        status: HealthDocumentStatus.active,
        uploadStatus: DocumentUploadStatus.ready,
        uploadProgress: 1,
        accessHistory: const [
          DocumentAccessEvent(
            actor: 'Sharif Rahman',
            action: 'Uploaded',
            timestamp: 'Just now',
          ),
        ],
      ),
    );
    context.pop();
  }
}
