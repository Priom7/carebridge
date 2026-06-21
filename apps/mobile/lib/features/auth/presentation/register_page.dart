import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../l10n/app_localizations.dart';
import 'auth_frame.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmation = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    confirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String? required(String? value) =>
        value == null || value.trim().isEmpty ? l10n.requiredField : null;
    return AuthFrame(
      title: l10n.createAccount,
      body: l10n.welcomeBody,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              decoration: InputDecoration(
                labelText: l10n.fullName,
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: required,
            ),
            const SizedBox(height: CareSpacing.md),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(
                labelText: l10n.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (required(value) case final error?) return error;
                return value!.contains('@') ? null : l10n.invalidEmail;
              },
            ),
            const SizedBox(height: CareSpacing.md),
            TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.telephoneNumber],
              decoration: InputDecoration(
                labelText: l10n.phoneNumber,
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              validator: required,
            ),
            const SizedBox(height: CareSpacing.md),
            TextFormField(
              controller: password,
              obscureText: true,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              decoration: InputDecoration(
                labelText: l10n.password,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              validator: (value) =>
                  (value?.length ?? 0) >= 8 ? null : l10n.passwordRequirement,
            ),
            const SizedBox(height: CareSpacing.md),
            TextFormField(
              controller: confirmation,
              obscureText: true,
              autofillHints: const [AutofillHints.newPassword],
              decoration: InputDecoration(
                labelText: l10n.confirmPassword,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              validator: (value) =>
                  value == password.text ? null : l10n.passwordsDoNotMatch,
            ),
            const SizedBox(height: CareSpacing.lg),
            CareButton(
              expanded: true,
              label: l10n.continueAction,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  widget.settings.beginRegistration();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
