import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../l10n/app_localizations.dart';
import 'auth_frame.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final code = TextEditingController();
  String? error;

  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthFrame(
      showBack: false,
      title: l10n.verificationTitle,
      body: l10n.verificationBody,
      child: Column(
        children: [
          TextField(
            key: const Key('verification-code'),
            controller: code,
            keyboardType: TextInputType.number,
            maxLength: 6,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: l10n.verificationCode,
              errorText: error,
            ),
          ),
          const SizedBox(height: CareSpacing.md),
          CareButton(
            expanded: true,
            label: l10n.verify,
            onPressed: () {
              if (code.text == '123456') {
                widget.settings.completeVerification();
              } else {
                setState(() => error = l10n.invalidCode);
              }
            },
          ),
          TextButton(
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.codeResent))),
            child: Text(l10n.resendCode),
          ),
        ],
      ),
    );
  }
}
