import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/design_system/presentation/component_gallery_page.dart';
import '../../features/family/presentation/family_management_page.dart';
import '../../features/family/presentation/family_onboarding_page.dart';
import '../../features/auth/presentation/account_security_page.dart';
import '../../features/auth/presentation/consent_page.dart';
import '../../features/auth/presentation/forgot_password_page.dart';
import '../../features/auth/presentation/privacy_data_page.dart';
import '../../features/auth/presentation/register_page.dart';
import '../../features/auth/presentation/sign_in_page.dart';
import '../../features/auth/presentation/verify_page.dart';
import '../../features/auth/presentation/welcome_page.dart';
import '../../features/care_profiles/presentation/care_profile_form_page.dart';
import '../../features/care_profiles/presentation/care_profiles_page.dart';
import '../../features/medicines/presentation/medicine_detail_page.dart';
import '../../features/medicines/presentation/medicine_form_page.dart';
import '../../features/medicines/presentation/medicines_page.dart';
import '../../features/emergency/presentation/emergency_alert_detail_page.dart';
import '../../features/emergency/presentation/emergency_alerts_page.dart';
import '../../features/emergency/presentation/emergency_contact_form_page.dart';
import '../../features/emergency/presentation/emergency_contacts_page.dart';
import '../../features/documents/presentation/document_upload_page.dart';
import '../../features/documents/presentation/document_vault_page.dart';
import '../../features/documents/presentation/document_viewer_page.dart';
import '../../features/appointments/presentation/appointment_detail_page.dart';
import '../../features/appointments/presentation/appointment_form_page.dart';
import '../../features/appointments/presentation/appointments_page.dart';
import '../../features/appointments/presentation/doctor_form_page.dart';
import '../../features/appointments/presentation/doctors_page.dart';
import '../../features/reminders/presentation/reminder_action_page.dart';
import '../../features/reminders/presentation/reminder_history_page.dart';
import '../../features/reminders/presentation/caregiver_alert_detail_page.dart';
import '../../features/reminders/presentation/caregiver_alerts_page.dart';
import '../../features/navigation/presentation/care_destination_page.dart';
import '../../features/navigation/presentation/caregiver_home_page.dart';
import '../../features/navigation/presentation/caregiver_shell.dart';
import '../../features/navigation/presentation/more_page.dart';
import '../../features/navigation/presentation/parent_home_page.dart';
import '../../l10n/app_localizations.dart';
import '../settings/app_settings.dart';

GoRouter createAppRouter(AppSettings settings) {
  return GoRouter(
    initialLocation: '/auth/welcome',
    refreshListenable: settings,
    redirect: (context, state) {
      final path = state.matchedLocation;
      final isPublicAuth =
          path == '/auth/welcome' ||
          path == '/auth/sign-in' ||
          path == '/auth/register' ||
          path == '/auth/forgot';
      if (settings.authStatus == AuthStatus.unauthenticated) {
        return isPublicAuth ? null : '/auth/welcome';
      }
      if (settings.authStatus == AuthStatus.verificationRequired) {
        return path == '/auth/verify' ? null : '/auth/verify';
      }
      if (settings.authStatus == AuthStatus.consentRequired) {
        return path == '/auth/consent' ? null : '/auth/consent';
      }
      if (settings.authStatus == AuthStatus.authenticated &&
          path.startsWith('/auth/')) {
        return '/home';
      }
      if (settings.authStatus == AuthStatus.authenticated &&
          !settings.onboardingComplete &&
          path != '/onboarding') {
        return '/onboarding';
      }
      if (settings.authStatus == AuthStatus.authenticated &&
          settings.onboardingComplete &&
          path == '/onboarding') {
        return '/home';
      }
      final isParentHome = state.matchedLocation == '/parent';
      final isReminderRoute = state.matchedLocation.startsWith('/reminders/');
      if (settings.role == AppRole.parent &&
          !isParentHome &&
          !isReminderRoute) {
        return '/parent';
      }
      if (settings.role == AppRole.caregiver && isParentHome) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/auth/welcome', builder: (_, _) => const WelcomePage()),
      GoRoute(
        path: '/auth/sign-in',
        builder: (_, _) => SignInPage(settings: settings),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (_, _) => RegisterPage(settings: settings),
      ),
      GoRoute(
        path: '/auth/forgot',
        builder: (_, _) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/auth/verify',
        builder: (_, _) => VerifyPage(settings: settings),
      ),
      GoRoute(
        path: '/auth/consent',
        builder: (_, _) => ConsentPage(settings: settings),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (_, _) => FamilyOnboardingPage(settings: settings),
      ),
      ShellRoute(
        builder: (context, state, child) => CaregiverShell(
          settings: settings,
          location: state.uri.path,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/home',
            builder: (_, _) => CaregiverHomePage(settings: settings),
          ),
          GoRoute(
            path: '/medicines',
            builder: (_, _) => MedicinesPage(settings: settings),
          ),
          GoRoute(
            path: '/health',
            builder: (_, _) =>
                const CareDestinationPage(kind: CareDestinationKind.health),
          ),
          GoRoute(
            path: '/documents',
            builder: (_, _) => DocumentVaultPage(settings: settings),
          ),
          GoRoute(
            path: '/more',
            builder: (_, _) => MorePage(settings: settings),
          ),
          GoRoute(
            path: '/account/security',
            builder: (_, _) => AccountSecurityPage(settings: settings),
          ),
          GoRoute(
            path: '/account/privacy',
            builder: (_, _) => PrivacyDataPage(settings: settings),
          ),
          GoRoute(
            path: '/family',
            builder: (_, _) => FamilyManagementPage(settings: settings),
          ),
          GoRoute(
            path: '/profiles',
            builder: (_, _) => CareProfilesPage(settings: settings),
          ),
          GoRoute(
            path: '/caregiver-alerts',
            builder: (_, _) => CaregiverAlertsPage(settings: settings),
          ),
          GoRoute(
            path: '/emergency-contacts',
            builder: (_, _) => EmergencyContactsPage(settings: settings),
          ),
          GoRoute(
            path: '/emergency-alerts',
            builder: (_, _) => EmergencyAlertsPage(settings: settings),
          ),
          GoRoute(
            path: '/appointments',
            builder: (_, _) => AppointmentsPage(settings: settings),
          ),
        ],
      ),
      GoRoute(
        path: '/emergency-contacts/new',
        builder: (_, _) => EmergencyContactFormPage(settings: settings),
      ),
      GoRoute(
        path: '/emergency-contacts/:id/edit',
        builder: (_, state) {
          final matches = settings.emergencyContacts.where(
            (item) => item.id == state.pathParameters['id'],
          );
          return EmergencyContactFormPage(
            settings: settings,
            contact: matches.isEmpty ? null : matches.first,
          );
        },
      ),
      GoRoute(
        path: '/emergency-alerts/:id',
        builder: (_, state) => EmergencyAlertDetailPage(
          settings: settings,
          alertId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/appointments/new',
        builder: (_, _) => AppointmentFormPage(settings: settings),
      ),
      GoRoute(
        path: '/appointments/:id',
        builder: (_, state) => AppointmentDetailPage(
          settings: settings,
          appointmentId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/doctors',
        builder: (_, _) => DoctorsPage(settings: settings),
      ),
      GoRoute(
        path: '/doctors/new',
        builder: (_, _) => DoctorFormPage(settings: settings),
      ),
      GoRoute(
        path: '/documents/upload',
        builder: (_, _) => DocumentUploadPage(settings: settings),
      ),
      GoRoute(
        path: '/documents/:id',
        builder: (_, state) => DocumentViewerPage(
          settings: settings,
          documentId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: '/profiles/new',
        builder: (_, _) => CareProfileFormPage(settings: settings),
      ),
      GoRoute(
        path: '/profiles/:id/edit',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final matches = settings.careProfiles.where((item) => item.id == id);
          return CareProfileFormPage(
            settings: settings,
            profile: matches.isEmpty ? null : matches.first,
          );
        },
      ),
      GoRoute(
        path: '/medicines/new',
        builder: (_, _) => MedicineFormPage(settings: settings),
      ),
      GoRoute(
        path: '/medicines/:id',
        builder: (context, state) {
          final matches = settings.medicines.where(
            (item) => item.id == state.pathParameters['id'],
          );
          if (matches.isEmpty) {
            return Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(context).pageNotFound),
              ),
            );
          }
          return MedicineDetailPage(
            settings: settings,
            medicine: matches.first,
          );
        },
      ),
      GoRoute(
        path: '/medicines/:id/edit',
        builder: (context, state) {
          final matches = settings.medicines.where(
            (item) => item.id == state.pathParameters['id'],
          );
          return MedicineFormPage(
            settings: settings,
            medicine: matches.isEmpty ? null : matches.first,
          );
        },
      ),
      GoRoute(
        path: '/parent',
        builder: (_, _) => ParentHomePage(settings: settings),
      ),
      GoRoute(
        path: '/reminders/current',
        builder: (_, _) => ReminderActionPage(settings: settings),
      ),
      GoRoute(
        path: '/reminders/history',
        builder: (_, _) => ReminderHistoryPage(settings: settings),
      ),
      GoRoute(
        path: '/caregiver-alerts/:id',
        builder: (context, state) {
          final matches = settings.reminders.where(
            (item) => item.id == state.pathParameters['id'],
          );
          if (matches.isEmpty) {
            return Scaffold(
              body: Center(
                child: Text(AppLocalizations.of(context).pageNotFound),
              ),
            );
          }
          return CaregiverAlertDetailPage(
            settings: settings,
            reminder: matches.first,
          );
        },
      ),
      GoRoute(
        path: '/design-system',
        builder: (_, _) => ComponentGalleryPage(
          isDark: settings.isDark,
          onThemeChanged: settings.setDarkMode,
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text(AppLocalizations.of(context).pageNotFound)),
    ),
  );
}
