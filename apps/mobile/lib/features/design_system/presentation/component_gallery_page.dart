import 'package:flutter/material.dart';

import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../core/widgets/status_badge.dart';

class ComponentGalleryPage extends StatefulWidget {
  const ComponentGalleryPage({
    required this.isDark,
    required this.onThemeChanged,
    super.key,
  });

  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<ComponentGalleryPage> createState() => _ComponentGalleryPageState();
}

class _ComponentGalleryPageState extends State<ComponentGalleryPage> {
  bool _parentMode = false;
  bool _notifications = true;
  int _navigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 840;
    final content = CustomScrollView(
      key: const Key('component-gallery-scroll'),
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 72,
          title: Image.asset(
            'assets/brand/carebridge_horizontal_logo.png',
            width: 176,
            semanticLabel: 'CareBridge — Bridging care across distance',
          ),
          actions: [
            IconButton(
              tooltip: widget.isDark ? 'Use light theme' : 'Use dark theme',
              onPressed: () => widget.onThemeChanged(!widget.isDark),
              icon: Icon(
                widget.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
              ),
            ),
            const SizedBox(width: CareSpacing.xs),
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            wide ? CareSpacing.xl : CareSpacing.md,
            CareSpacing.lg,
            wide ? CareSpacing.xl : CareSpacing.md,
            CareSpacing.xxl,
          ),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Hero(parentMode: _parentMode),
                    const SizedBox(height: CareSpacing.xl),
                    _Section(
                      eyebrow: 'FOUNDATIONS',
                      title: 'A calm system for urgent moments',
                      description:
                          'Blue builds trust, teal signals connection, and status colors only appear when they carry meaning.',
                      child: const _FoundationGrid(),
                    ),
                    _Section(
                      eyebrow: 'ACTIONS',
                      title: 'Buttons and controls',
                      description:
                          'Every primary action is at least 48px. Parent mode raises critical targets to 64px.',
                      child: _Controls(
                        parentMode: _parentMode,
                        notifications: _notifications,
                        onParentModeChanged: (value) =>
                            setState(() => _parentMode = value),
                        onNotificationsChanged: (value) =>
                            setState(() => _notifications = value),
                      ),
                    ),
                    const _Section(
                      eyebrow: 'STATUS',
                      title: 'Clear without alarm fatigue',
                      description:
                          'Color is always paired with text, so meaning survives low vision and grayscale.',
                      child: _StatusExamples(),
                    ),
                    const _Section(
                      eyebrow: 'CARE COMPONENTS',
                      title: 'Reusable patterns',
                      description:
                          'The first components already model medicine, family, and wellbeing workflows from the PRD.',
                      child: _CarePatterns(),
                    ),
                    _Section(
                      eyebrow: 'PARENT MODE',
                      title: 'One decision at a time',
                      description:
                          'The reminder surface favors comprehension, large targets, and immediate human support.',
                      child: _ReminderPreview(parentMode: _parentMode),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      body: wide
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: _navigationIndex,
                  onDestinationSelected: (value) =>
                      setState(() => _navigationIndex = value),
                  labelType: NavigationRailLabelType.all,
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(vertical: CareSpacing.md),
                    child: Icon(Icons.favorite_rounded, color: CareColors.blue),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.palette_outlined),
                      selectedIcon: Icon(Icons.palette),
                      label: Text('System'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Care'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.accessibility_new_outlined),
                      selectedIcon: Icon(Icons.accessibility_new),
                      label: Text('Parent'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: content),
              ],
            )
          : content,
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _navigationIndex,
              onDestinationSelected: (value) =>
                  setState(() => _navigationIndex = value),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.palette_outlined),
                  selectedIcon: Icon(Icons.palette),
                  label: 'System',
                ),
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Care',
                ),
                NavigationDestination(
                  icon: Icon(Icons.accessibility_new_outlined),
                  selectedIcon: Icon(Icons.accessibility_new),
                  label: 'Parent',
                ),
              ],
            ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.parentMode});
  final bool parentMode;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CareSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [scheme.primary, CareColors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(CareRadius.lg),
      ),
      child: Wrap(
        spacing: CareSpacing.xl,
        runSpacing: CareSpacing.lg,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 630),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CAREBRIDGE DESIGN SYSTEM 1.0',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white.withValues(alpha: .85),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: CareSpacing.md),
                Text(
                  'Care that feels close, even from far away.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: CareSpacing.md),
                Text(
                  'A reusable foundation for caregiver detail and ${parentMode ? 'simplified parent decisions' : 'everyday family coordination'}.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: .9),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/brand/carebridge_symbol.png',
            width: 130,
            height: 130,
            semanticLabel: 'CareBridge family heart symbol',
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.child,
  });
  final String eyebrow;
  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: CareSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: CareColors.teal,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: CareSpacing.xs),
          Text(title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: CareSpacing.xs),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: CareSpacing.lg),
          child,
        ],
      ),
    );
  }
}

class _FoundationGrid extends StatelessWidget {
  const _FoundationGrid();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: CareSpacing.md,
      runSpacing: CareSpacing.md,
      children: const [
        _ColorTile(name: 'Trust', value: '#075CD6', color: CareColors.blue),
        _ColorTile(
          name: 'Connection',
          value: '#09A9A2',
          color: CareColors.teal,
        ),
        _ColorTile(name: 'Taken', value: '#16A66A', color: CareColors.green),
        _ColorTile(
          name: 'Attention',
          value: '#F3A51C',
          color: CareColors.amber,
        ),
        _ColorTile(name: 'Emergency', value: '#E33B45', color: CareColors.red),
      ],
    );
  }
}

class _ColorTile extends StatelessWidget {
  const _ColorTile({
    required this.name,
    required this.value,
    required this.color,
  });
  final String name;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: CareCard(
        padding: const EdgeInsets.all(CareSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(CareRadius.sm),
              ),
            ),
            const SizedBox(width: CareSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(value, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.parentMode,
    required this.notifications,
    required this.onParentModeChanged,
    required this.onNotificationsChanged,
  });
  final bool parentMode;
  final bool notifications;
  final ValueChanged<bool> onParentModeChanged;
  final ValueChanged<bool> onNotificationsChanged;

  @override
  Widget build(BuildContext context) {
    return CareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: CareSpacing.sm,
            runSpacing: CareSpacing.sm,
            children: [
              CareButton(
                label: 'Save medicine',
                icon: Icons.check,
                onPressed: () {},
              ),
              CareButton(
                label: 'Snooze 15 min',
                icon: Icons.snooze,
                style: CareButtonStyle.secondary,
                onPressed: () {},
              ),
              CareButton(
                label: 'Taken',
                icon: Icons.done,
                style: CareButtonStyle.success,
                onPressed: () {},
              ),
              CareButton(
                label: 'Need help',
                icon: Icons.sos,
                style: CareButtonStyle.danger,
                onPressed: () {},
              ),
              const CareButton(label: 'Unavailable', onPressed: null),
            ],
          ),
          const SizedBox(height: CareSpacing.lg),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Medicine name',
              hintText: 'For example, Metformin',
              prefixIcon: Icon(Icons.medication_outlined),
            ),
          ),
          const SizedBox(height: CareSpacing.md),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Parent-friendly controls'),
            subtitle: const Text('Larger actions and simpler language'),
            value: parentMode,
            onChanged: onParentModeChanged,
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Reminder notifications'),
            subtitle: const Text(
              'Health details stay hidden on the lock screen',
            ),
            value: notifications,
            onChanged: onNotificationsChanged,
          ),
        ],
      ),
    );
  }
}

class _StatusExamples extends StatelessWidget {
  const _StatusExamples();
  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: CareSpacing.sm,
      runSpacing: CareSpacing.sm,
      children: [
        StatusBadge(label: 'Active', status: CareStatus.active),
        StatusBadge(label: 'Due now', status: CareStatus.due),
        StatusBadge(label: 'Low stock', status: CareStatus.warning),
        StatusBadge(label: 'Missed', status: CareStatus.missed),
        StatusBadge(label: 'Paused', status: CareStatus.neutral),
      ],
    );
  }
}

class _CarePatterns extends StatelessWidget {
  const _CarePatterns();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth >= 820
            ? (constraints.maxWidth - 32) / 3
            : constraints.maxWidth;
        return Wrap(
          spacing: CareSpacing.md,
          runSpacing: CareSpacing.md,
          children: [
            SizedBox(
              width: width,
              child: const _MetricCard(
                icon: Icons.medication_outlined,
                value: '3',
                label: 'Medicines today',
                color: CareColors.green,
              ),
            ),
            SizedBox(
              width: width,
              child: const _MetricCard(
                icon: Icons.notifications_active_outlined,
                value: '1',
                label: 'Needs attention',
                color: CareColors.red,
              ),
            ),
            SizedBox(
              width: width,
              child: const _MetricCard(
                icon: Icons.calendar_today_outlined,
                value: '25 Jun',
                label: 'Next appointment',
                color: CareColors.blue,
              ),
            ),
            SizedBox(width: width, child: const _MedicineCard()),
            SizedBox(width: width, child: const _FamilyCard()),
            SizedBox(width: width, child: const _EmptyCard()),
          ],
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => CareCard(
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .12),
            borderRadius: BorderRadius.circular(CareRadius.sm),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: CareSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            Text(label),
          ],
        ),
      ],
    ),
  );
}

class _MedicineCard extends StatelessWidget {
  const _MedicineCard();
  @override
  Widget build(BuildContext context) => CareCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(
              backgroundColor: CareColors.blueSoft,
              child: Icon(Icons.medication, color: CareColors.blue),
            ),
            const SizedBox(width: CareSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Metformin 500mg',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text('1 tablet · After breakfast'),
                ],
              ),
            ),
            const StatusBadge(label: 'Active', status: CareStatus.active),
          ],
        ),
        const SizedBox(height: CareSpacing.md),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Next dose · 9:00 AM'), Text('12 tablets left')],
        ),
      ],
    ),
  );
}

class _FamilyCard extends StatelessWidget {
  const _FamilyCard();
  @override
  Widget build(BuildContext context) => CareCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CircleAvatar(child: Text('AK')),
            const SizedBox(width: CareSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Abdul Karim',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text('Father · Bangladesh time'),
                ],
              ),
            ),
            const Icon(Icons.circle, color: CareColors.green, size: 12),
          ],
        ),
        const SizedBox(height: CareSpacing.md),
        const Text(
          'All morning medicines taken',
          style: TextStyle(
            color: CareColors.green,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard();
  @override
  Widget build(BuildContext context) => CareCard(
    child: Column(
      children: [
        const Icon(
          Icons.folder_open_outlined,
          size: 42,
          color: CareColors.slate,
        ),
        const SizedBox(height: CareSpacing.sm),
        Text('No reports yet', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: CareSpacing.xs),
        const Text(
          'Upload a prescription or report to keep everything together.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: CareSpacing.md),
        CareButton(
          label: 'Upload document',
          style: CareButtonStyle.secondary,
          icon: Icons.upload_file,
          onPressed: () {},
        ),
      ],
    ),
  );
}

class _ReminderPreview extends StatelessWidget {
  const _ReminderPreview({required this.parentMode});
  final bool parentMode;
  @override
  Widget build(BuildContext context) {
    final large = parentMode;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: CareCard(
          padding: EdgeInsets.all(large ? CareSpacing.xl : CareSpacing.lg),
          child: Column(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: const BoxDecoration(
                  color: CareColors.blueSoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_active,
                  color: CareColors.blue,
                  size: 38,
                ),
              ),
              const SizedBox(height: CareSpacing.lg),
              Text(
                'Time for your medicine',
                style: (large
                    ? Theme.of(context).textTheme.headlineMedium
                    : Theme.of(context).textTheme.titleLarge),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CareSpacing.xs),
              Text(
                'Amlodipine 5mg',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Text('1 tablet · 8:00 AM'),
              const SizedBox(height: CareSpacing.lg),
              CareButton(
                key: const Key('taken-reminder-button'),
                expanded: true,
                large: large,
                label: 'I took it',
                style: CareButtonStyle.success,
                icon: Icons.done,
                onPressed: () {},
              ),
              const SizedBox(height: CareSpacing.sm),
              CareButton(
                expanded: true,
                large: large,
                label: 'Remind me in 15 minutes',
                style: CareButtonStyle.secondary,
                icon: Icons.snooze,
                onPressed: () {},
              ),
              const SizedBox(height: CareSpacing.sm),
              CareButton(
                expanded: true,
                large: large,
                label: 'I need help',
                style: CareButtonStyle.danger,
                icon: Icons.support_agent,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
