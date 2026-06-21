import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/widgets/care_button.dart';
import '../../../l10n/app_localizations.dart';
import 'auth_frame.dart';

class ConsentPage extends StatefulWidget {
  const ConsentPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  State<ConsentPage> createState() => _ConsentPageState();
}

class _ConsentPageState extends State<ConsentPage> {
  bool terms = false;
  bool health = false;
  bool notifications = true;
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthFrame(
      showBack: false,
      title: l10n.consentTitle,
      body: l10n.consentBody,
      child: Column(
        children: [
          CheckboxListTile(
            key: const Key('terms-consent'),
            contentPadding: EdgeInsets.zero,
            value: terms,
            onChanged: (value) => setState(() => terms = value ?? false),
            title: Text(l10n.acceptTerms),
          ),
          CheckboxListTile(
            key: const Key('health-consent'),
            contentPadding: EdgeInsets.zero,
            value: health,
            onChanged: (value) => setState(() => health = value ?? false),
            title: Text(l10n.healthDataConsent),
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: notifications,
            onChanged: (value) =>
                setState(() => notifications = value ?? false),
            title: Text(l10n.notificationConsent),
          ),
          if (showError)
            Semantics(
              liveRegion: true,
              child: Text(
                l10n.requiredConsent,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          const SizedBox(height: 16),
          CareButton(
            expanded: true,
            label: l10n.finishSetup,
            onPressed: () {
              if (terms && health) {
                widget.settings.completeConsent();
              } else {
                setState(() => showError = true);
              }
            },
          ),
        ],
      ),
    );
  }
}
