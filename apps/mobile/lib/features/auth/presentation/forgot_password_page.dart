import 'package:flutter/material.dart';

import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../l10n/app_localizations.dart';
import 'auth_frame.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  bool sent = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthFrame(
      title: l10n.recoveryTitle,
      body: l10n.recoveryBody,
      child: sent
          ? Semantics(
              liveRegion: true,
              child: Container(
                padding: const EdgeInsets.all(CareSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(l10n.resetLinkSent),
              ),
            )
          : Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: l10n.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    validator: (value) => value != null && value.contains('@')
                        ? null
                        : l10n.invalidEmail,
                  ),
                  const SizedBox(height: CareSpacing.lg),
                  CareButton(
                    expanded: true,
                    label: l10n.sendResetLink,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() => sent = true);
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
