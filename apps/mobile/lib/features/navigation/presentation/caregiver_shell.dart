import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../l10n/app_localizations.dart';

class CaregiverShell extends StatelessWidget {
  const CaregiverShell({
    required this.settings,
    required this.location,
    required this.child,
    super.key,
  });

  final AppSettings settings;
  final String location;
  final Widget child;

  static const paths = [
    '/home',
    '/medicines',
    '/health',
    '/documents',
    '/more',
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final destinations = [
      (Icons.home_outlined, Icons.home, l10n.home),
      (Icons.medication_outlined, Icons.medication, l10n.medicines),
      (Icons.monitor_heart_outlined, Icons.monitor_heart, l10n.health),
      (Icons.folder_outlined, Icons.folder, l10n.documents),
      (Icons.more_horiz, Icons.more_horiz, l10n.more),
    ];
    final index = paths.indexOf(location).clamp(0, paths.length - 1);
    final isWide = MediaQuery.sizeOf(context).width >= 900;
    final content = Column(
      children: [
        _CareHeader(settings: settings),
        const Divider(height: 1),
        Expanded(child: child),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: isWide
            ? Row(
                children: [
                  NavigationRail(
                    selectedIndex: index,
                    onDestinationSelected: (value) => context.go(paths[value]),
                    labelType: NavigationRailLabelType.all,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: CareSpacing.md,
                      ),
                      child: Image.asset(
                        'assets/brand/carebridge_symbol.png',
                        width: 48,
                        semanticLabel: l10n.appName,
                      ),
                    ),
                    destinations: [
                      for (final item in destinations)
                        NavigationRailDestination(
                          icon: Icon(item.$1),
                          selectedIcon: Icon(item.$2),
                          label: Text(item.$3),
                        ),
                    ],
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: content),
                ],
              )
            : content,
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (value) => context.go(paths[value]),
              destinations: [
                for (final item in destinations)
                  NavigationDestination(
                    icon: Icon(item.$1),
                    selectedIcon: Icon(item.$2),
                    label: item.$3,
                  ),
              ],
            ),
    );
  }
}

class _CareHeader extends StatelessWidget {
  const _CareHeader({required this.settings});
  final AppSettings settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 72,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CareSpacing.md),
        child: Row(
          children: [
            if (MediaQuery.sizeOf(context).width < 900)
              Image.asset(
                'assets/brand/carebridge_horizontal_logo.png',
                width: 142,
                semanticLabel: l10n.appName,
              )
            else
              Text(
                l10n.caregiverMode,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            const Spacer(),
            PopupMenuButton<String>(
              tooltip: l10n.switchProfile,
              initialValue: settings.selectedProfile,
              onSelected: settings.setProfile,
              itemBuilder: (_) => settings.careProfiles
                  .where((profile) => profile.status.name == 'active')
                  .map(
                    (profile) => PopupMenuItem(
                      value: profile.id,
                      child: Text(profile.preferredName),
                    ),
                  )
                  .toList(),
              child: Semantics(
                button: true,
                label: l10n.switchProfile,
                child: Chip(
                  avatar: CircleAvatar(
                    child: Text(settings.selectedCareProfile?.initials ?? 'CB'),
                  ),
                  label: Text(
                    settings.selectedCareProfile?.preferredName ??
                        l10n.careProfiles,
                  ),
                  deleteIcon: const Icon(Icons.expand_more),
                  onDeleted: () {},
                ),
              ),
            ),
            const SizedBox(width: CareSpacing.xs),
            IconButton(
              tooltip: l10n.parentMode,
              onPressed: () => settings.setRole(AppRole.parent),
              icon: const Icon(Icons.accessibility_new),
            ),
          ],
        ),
      ),
    );
  }
}
