import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(CareSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                children: [
                  Image.asset(
                    'assets/brand/carebridge_horizontal_logo.png',
                    height: 76,
                    semanticLabel: l10n.appName,
                  ),
                  const SizedBox(height: CareSpacing.xxl),
                  Image.asset(
                    'assets/brand/carebridge_symbol.png',
                    height: 170,
                    semanticLabel: l10n.appName,
                  ),
                  const SizedBox(height: CareSpacing.xl),
                  Text(
                    l10n.welcomeTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: CareSpacing.md),
                  Text(
                    l10n.welcomeBody,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: CareSpacing.xl),
                  CareButton(
                    expanded: true,
                    label: l10n.getStarted,
                    onPressed: () => context.push('/auth/register'),
                  ),
                  const SizedBox(height: CareSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Text(l10n.alreadyHaveAccount)),
                      TextButton(
                        onPressed: () => context.push('/auth/sign-in'),
                        child: Text(l10n.signIn),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
