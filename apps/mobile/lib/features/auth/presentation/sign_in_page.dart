import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../l10n/app_localizations.dart';
import 'auth_frame.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthFrame(
      title: l10n.signInTitle,
      body: l10n.signInBody,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(
                labelText: l10n.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              validator: (value) => value != null && value.contains('@')
                  ? null
                  : l10n.invalidEmail,
            ),
            const SizedBox(height: CareSpacing.md),
            TextFormField(
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                labelText: l10n.password,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              validator: (value) =>
                  (value?.length ?? 0) >= 8 ? null : l10n.passwordRequirement,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.push('/auth/forgot'),
                child: Text(l10n.forgotPassword),
              ),
            ),
            CareButton(
              expanded: true,
              label: l10n.signIn,
              onPressed: () {
                if (formKey.currentState!.validate()) widget.settings.signIn();
              },
            ),
          ],
        ),
      ),
    );
  }
}
