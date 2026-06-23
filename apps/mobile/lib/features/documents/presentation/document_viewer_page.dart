import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/health_document.dart';
import 'document_vault_page.dart';

class DocumentViewerPage extends StatefulWidget {
  const DocumentViewerPage({
    required this.settings,
    required this.documentId,
    super.key,
  });
  final AppSettings settings;
  final String documentId;
  @override
  State<DocumentViewerPage> createState() => _DocumentViewerPageState();
}

class _DocumentViewerPageState extends State<DocumentViewerPage>
    with WidgetsBindingObserver {
  bool privacyCover = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.settings.recordDocumentAccess(widget.documentId, 'Viewed securely');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) =>
      setState(() => privacyCover = state != AppLifecycleState.resumed);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final matches = widget.settings.documents.where(
      (item) => item.id == widget.documentId,
    );
    if (matches.isEmpty) {
      return Scaffold(body: Center(child: Text(l10n.pageNotFound)));
    }
    final document = matches.first;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text(l10n.secureDocumentViewer)),
          body: SafeArea(
            child: ListView(
              key: const Key('document-viewer'),
              padding: const EdgeInsets.all(CareSpacing.lg),
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: CareColors.blueSoft,
                    borderRadius: BorderRadius.circular(CareRadius.lg),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        document.isImage
                            ? Icons.image_outlined
                            : Icons.picture_as_pdf_outlined,
                        size: 72,
                        color: CareColors.blue,
                      ),
                      const SizedBox(height: CareSpacing.md),
                      Text(
                        document.fileName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(l10n.localSecurePreview),
                    ],
                  ),
                ),
                const SizedBox(height: CareSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: CareButton(
                        label: l10n.download,
                        icon: Icons.download_outlined,
                        style: CareButtonStyle.secondary,
                        onPressed: () =>
                            _action(l10n.downloadedSecurely, 'Downloaded'),
                      ),
                    ),
                    const SizedBox(width: CareSpacing.sm),
                    Expanded(
                      child: CareButton(
                        label: l10n.share,
                        icon: Icons.share_outlined,
                        style: CareButtonStyle.secondary,
                        onPressed: () =>
                            _action(l10n.sharePermissionChecked, 'Shared'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: CareSpacing.lg),
                CareCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '${documentTypeLabel(l10n, document.type)} · ${document.documentDate}',
                      ),
                      const Divider(),
                      _detail(l10n.doctorName, document.doctorName),
                      _detail(l10n.hospitalClinic, document.hospitalName),
                      _detail(l10n.uploadedBy, document.uploadedBy),
                      _detail(
                        l10n.visibilityPermissions,
                        document.visibleTo.join(', '),
                      ),
                      _detail(l10n.linkedMedicine, document.linkedMedicine),
                      _detail(
                        l10n.linkedAppointment,
                        document.linkedAppointment,
                      ),
                      _detail(l10n.linkedCondition, document.linkedCondition),
                      _detail(l10n.notes, document.notes),
                    ],
                  ),
                ),
                const SizedBox(height: CareSpacing.lg),
                Text(
                  l10n.documentHistory,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                CareCard(
                  child: Column(
                    children: [
                      for (final event in document.accessHistory.reversed)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.history),
                          title: Text(event.action),
                          subtitle: Text('${event.actor} · ${event.timestamp}'),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: CareSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: CareButton(
                        label: l10n.archiveDocument,
                        style: CareButtonStyle.secondary,
                        onPressed: () => widget.settings.setDocumentStatus(
                          document.id,
                          HealthDocumentStatus.archived,
                        ),
                      ),
                    ),
                    const SizedBox(width: CareSpacing.sm),
                    Expanded(
                      child: CareButton(
                        label: l10n.deleteDocument,
                        style: CareButtonStyle.danger,
                        onPressed: () => _confirmDelete(document.id),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (privacyCover)
          Positioned.fill(
            child: ColoredBox(
              color: CareColors.ink,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      size: 64,
                      color: Colors.white,
                    ),
                    const SizedBox(height: CareSpacing.md),
                    Text(
                      l10n.documentHiddenForPrivacy,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _detail(String label, String value) => value.isEmpty
      ? const SizedBox.shrink()
      : Padding(
          padding: const EdgeInsets.only(top: CareSpacing.sm),
          child: Text('$label: $value'),
        );
  void _action(String message, String action) {
    widget.settings.recordDocumentAccess(widget.documentId, action);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _confirmDelete(String id) async {
    final l10n = AppLocalizations.of(context);
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.deleteDocument),
            content: Text(l10n.deleteDocumentWarning),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(l10n.deleteDocument),
              ),
            ],
          ),
        ) ??
        false;
    if (confirmed) {
      widget.settings.setDocumentStatus(id, HealthDocumentStatus.deleted);
    }
  }
}
