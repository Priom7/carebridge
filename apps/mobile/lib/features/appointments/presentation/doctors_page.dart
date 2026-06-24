import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/theme/carebridge_tokens.dart';
import '../../../core/widgets/care_button.dart';
import '../../../core/widgets/care_card.dart';
import '../../../l10n/app_localizations.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({required this.settings, super.key});
  final AppSettings settings;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final doctors = settings.doctorsForSelectedProfile();
    return Scaffold(
      appBar: AppBar(title: Text(l10n.doctors)),
      body: ListView(
        key: const Key('doctors-list'),
        padding: const EdgeInsets.all(CareSpacing.lg),
        children: [
          CareButton(
            label: l10n.addDoctor,
            icon: Icons.add,
            onPressed: () => context.push('/doctors/new'),
          ),
          const SizedBox(height: CareSpacing.md),
          Text(l10n.showingDemoRecords(doctors.length)),
          const SizedBox(height: CareSpacing.md),
          for (final doctor in doctors) ...[
            CareCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.medical_services_outlined),
                  ),
                  const SizedBox(width: CareSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text('${doctor.speciality} · ${doctor.hospital}'),
                        Text(doctor.visitingHours),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.call,
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.callingContact(doctor.phone)),
                      ),
                    ),
                    icon: const Icon(Icons.call_outlined),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CareSpacing.sm),
          ],
        ],
      ),
    );
  }
}
