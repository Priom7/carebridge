import 'package:flutter/material.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';

class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({required this.settings, super.key});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final phoneRevoked = settings.revokedDeviceIds.contains('phone-bd');
    return ListView(
      padding: const EdgeInsets.all(CareSpacing.lg),
      children: [
        Text(
          l10n.accountSecurity,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: CareSpacing.lg),
        CareCard(
          child: Column(
            children: [
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.twoFactor),
                subtitle: Text(l10n.twoFactorDescription),
                value: settings.twoFactorEnabled,
                onChanged: settings.setTwoFactor,
              ),
              const Divider(),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.biometricUnlock),
                subtitle: Text(l10n.biometricDescription),
                value: settings.biometricEnabled,
                onChanged: settings.setBiometric,
              ),
            ],
          ),
        ),
        const SizedBox(height: CareSpacing.lg),
        Text(l10n.yourDevices, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: CareSpacing.sm),
        CareCard(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.laptop_mac),
                title: const Text('MacBook · London'),
                subtitle: Text(l10n.currentDevice),
                trailing: const Icon(
                  Icons.verified_user,
                  color: CareColors.green,
                ),
              ),
              if (!phoneRevoked) ...[
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.phone_android),
                  title: const Text('Android · Dhaka'),
                  subtitle: const Text('21 Jun · 14:08'),
                  trailing: TextButton(
                    onPressed: () {
                      settings.revokeDevice('phone-bd');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.deviceRevoked)),
                      );
                    },
                    child: Text(l10n.revoke),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: CareSpacing.lg),
        CareButton(
          expanded: true,
          style: CareButtonStyle.danger,
          label: l10n.logoutAllDevices,
          icon: Icons.logout,
          onPressed: () => _confirmLogout(context, l10n),
        ),
      ],
    );
  }

  Future<void> _confirmLogout(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.logoutAllDevices),
        content: Text(l10n.logoutConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.confirmLogout),
          ),
        ],
      ),
    );
    if (confirmed == true) settings.signOut();
  }
}
