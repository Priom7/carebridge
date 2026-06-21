import 'package:flutter/material.dart';

import '../../../core/theme/carebridge_tokens.dart';
import '../../../l10n/app_localizations.dart';

class AuthFrame extends StatelessWidget {
  const AuthFrame({
    required this.title,
    required this.body,
    required this.child,
    this.showBack = true,
    super.key,
  });

  final String title;
  final String body;
  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBack
          ? AppBar(
              leading: BackButton(
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            )
          : null,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(CareSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/brand/carebridge_horizontal_logo.png',
                    height: 64,
                    semanticLabel: AppLocalizations.of(context).appName,
                  ),
                  const SizedBox(height: CareSpacing.xl),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: CareSpacing.sm),
                  Text(
                    body,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: CareSpacing.xl),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
