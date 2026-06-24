import 'package:flutter/material.dart';

import '../demo/demo_fixtures.dart';
import '../../features/family/domain/family_models.dart';
import '../../features/medicines/domain/medicine.dart';
import '../../features/reminders/domain/reminder_event.dart';
import '../../features/reminders/domain/alarm_request.dart';
import '../../features/care_profiles/domain/care_profile.dart';
import '../../features/emergency/domain/emergency_models.dart';
import '../../features/documents/domain/health_document.dart';
import '../../features/appointments/domain/appointment_models.dart';

enum AppRole { caregiver, parent }

enum AuthStatus {
  unauthenticated,
  verificationRequired,
  consentRequired,
  authenticated,
}

class AppSettings extends ChangeNotifier {
  AppSettings({bool initiallyAuthenticated = false})
    : authStatus = initiallyAuthenticated
          ? AuthStatus.authenticated
          : AuthStatus.unauthenticated,
      onboardingComplete = initiallyAuthenticated {
    if (initiallyAuthenticated) _seedDemoProfiles();
  }

  AuthStatus authStatus;
  bool onboardingComplete;
  ThemeMode themeMode = ThemeMode.light;
  Locale locale = const Locale('en');
  AppRole role = AppRole.caregiver;
  double textScale = 1;
  String selectedProfile = 'father';
  bool twoFactorEnabled = false;
  bool biometricEnabled = false;
  bool exportRequested = false;
  final Set<String> revokedDeviceIds = {};
  String familyGroupName = '';
  final List<FamilyMember> familyMembers = [];
  final List<FamilyInvitation> familyInvitations = [];
  final List<String> familyActivity = [];
  final List<CareProfile> careProfiles = [];
  final List<Medicine> medicines = [];
  final List<ReminderEvent> reminders = [];
  final List<AlarmRequest> alarmRequests = [];
  final List<EmergencyContact> emergencyContacts = [];
  final List<EmergencyAlert> emergencyAlerts = [];
  final List<HealthDocument> documents = [];
  final List<Doctor> doctors = [];
  final List<Appointment> appointments = [];
  final List<String> timelineEvents = [];
  bool demoOffline = false;

  bool get isDark => themeMode == ThemeMode.dark;

  void setDarkMode(bool value) {
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setLocale(Locale value) {
    locale = value;
    notifyListeners();
  }

  void setRole(AppRole value) {
    role = value;
    notifyListeners();
  }

  void setTextScale(double value) {
    textScale = value;
    notifyListeners();
  }

  void setProfile(String value) {
    selectedProfile = value;
    notifyListeners();
  }

  void beginRegistration() {
    authStatus = AuthStatus.verificationRequired;
    notifyListeners();
  }

  void completeVerification() {
    authStatus = AuthStatus.consentRequired;
    notifyListeners();
  }

  void completeConsent() {
    authStatus = AuthStatus.authenticated;
    onboardingComplete = false;
    notifyListeners();
  }

  void signIn() {
    if (careProfiles.isEmpty) {
      _seedDemoProfiles();
    }
    authStatus = AuthStatus.authenticated;
    onboardingComplete = true;
    notifyListeners();
  }

  void signOut() {
    authStatus = AuthStatus.unauthenticated;
    role = AppRole.caregiver;
    notifyListeners();
  }

  void setTwoFactor(bool value) {
    twoFactorEnabled = value;
    notifyListeners();
  }

  void setBiometric(bool value) {
    biometricEnabled = value;
    notifyListeners();
  }

  void revokeDevice(String id) {
    revokedDeviceIds.add(id);
    notifyListeners();
  }

  void requestExport() {
    exportRequested = true;
    notifyListeners();
  }

  void createFamilyGroup({
    required String name,
    required bool addFather,
    required bool addMother,
    String? inviteEmail,
  }) {
    familyGroupName = name;
    familyMembers
      ..clear()
      ..add(
        const FamilyMember(
          id: 'owner',
          name: 'Sharif Rahman',
          relationship: 'Self',
          role: FamilyMemberRole.owner,
          canManageMedicines: true,
          canManageDocuments: true,
          canManageAppointments: true,
          canManageEmergencyContacts: true,
        ),
      );
    if (addFather) {
      familyMembers.add(
        const FamilyMember(
          id: 'father',
          name: 'Abdul Karim',
          relationship: 'Father',
          role: FamilyMemberRole.dependent,
        ),
      );
    }
    if (addMother) {
      familyMembers.add(
        const FamilyMember(
          id: 'mother',
          name: 'Salma Begum',
          relationship: 'Mother',
          role: FamilyMemberRole.dependent,
        ),
      );
    }
    familyInvitations.clear();
    careProfiles.clear();
    if (addFather) careProfiles.add(_fatherProfile());
    if (addMother) careProfiles.add(_motherProfile());
    if (careProfiles.isNotEmpty) selectedProfile = careProfiles.first.id;
    if (inviteEmail != null && inviteEmail.trim().isNotEmpty) {
      familyInvitations.add(
        FamilyInvitation(
          id: 'invite-1',
          email: inviteEmail.trim(),
          role: FamilyMemberRole.secondaryCaregiver,
          status: InvitationStatus.pending,
        ),
      );
    }
    familyActivity
      ..clear()
      ..add('Family group created')
      ..addAll(addFather ? ['Father profile added'] : const [])
      ..addAll(addMother ? ['Mother profile added'] : const [])
      ..addAll(
        inviteEmail != null && inviteEmail.trim().isNotEmpty
            ? ['Caregiver invitation sent']
            : const [],
      );
    onboardingComplete = true;
    notifyListeners();
  }

  void revokeInvitation(String id) {
    final index = familyInvitations.indexWhere((item) => item.id == id);
    if (index < 0) return;
    familyInvitations[index] = familyInvitations[index].copyWith(
      status: InvitationStatus.revoked,
    );
    familyActivity.insert(0, 'Caregiver invitation revoked');
    notifyListeners();
  }

  void acceptInvitation(String id) {
    final index = familyInvitations.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final invitation = familyInvitations[index];
    familyInvitations[index] = invitation.copyWith(
      status: InvitationStatus.accepted,
    );
    if (!familyMembers.any((member) => member.id == 'sibling')) {
      familyMembers.add(
        const FamilyMember(
          id: 'sibling',
          name: 'Nadia Rahman',
          relationship: 'Sister',
          role: FamilyMemberRole.secondaryCaregiver,
          canManageMedicines: true,
          canManageAppointments: true,
          canManageEmergencyContacts: true,
        ),
      );
    }
    familyActivity.insert(0, 'Caregiver invitation accepted');
    notifyListeners();
  }

  void updateMemberPermissions(
    String id, {
    required bool medicines,
    required bool documents,
    required bool appointments,
    required bool emergencyContacts,
  }) {
    final index = familyMembers.indexWhere((item) => item.id == id);
    if (index < 0) return;
    familyMembers[index] = familyMembers[index].copyWith(
      canManageMedicines: medicines,
      canManageDocuments: documents,
      canManageAppointments: appointments,
      canManageEmergencyContacts: emergencyContacts,
    );
    familyActivity.insert(0, 'Member permissions updated');
    notifyListeners();
  }

  void transferOwnership(String newOwnerId) {
    final currentOwner = familyMembers.indexWhere(
      (item) => item.role == FamilyMemberRole.owner,
    );
    final newOwner = familyMembers.indexWhere((item) => item.id == newOwnerId);
    if (currentOwner < 0 || newOwner < 0 || currentOwner == newOwner) return;
    familyMembers[currentOwner] = familyMembers[currentOwner].copyWith(
      role: FamilyMemberRole.secondaryCaregiver,
    );
    familyMembers[newOwner] = familyMembers[newOwner].copyWith(
      role: FamilyMemberRole.owner,
    );
    familyActivity.insert(0, 'Family ownership transferred');
    notifyListeners();
  }

  void removeMember(String id) {
    final index = familyMembers.indexWhere((item) => item.id == id);
    if (index < 0 || familyMembers[index].role == FamilyMemberRole.owner) {
      return;
    }
    familyMembers.removeAt(index);
    familyActivity.insert(0, 'Member access revoked');
    notifyListeners();
  }

  CareProfile? get selectedCareProfile {
    final active = careProfiles.where(
      (profile) =>
          profile.id == selectedProfile &&
          profile.status == CareProfileStatus.active,
    );
    return active.isEmpty ? null : active.first;
  }

  void saveCareProfile(CareProfile profile) {
    final index = careProfiles.indexWhere((item) => item.id == profile.id);
    if (index < 0) {
      careProfiles.add(profile);
      selectedProfile = profile.id;
      familyActivity.insert(0, 'Care profile added');
    } else {
      careProfiles[index] = profile;
      familyActivity.insert(0, 'Care profile updated');
    }
    notifyListeners();
  }

  List<Medicine> medicinesForSelectedProfile() => medicines
      .where((medicine) => medicine.careProfileId == selectedProfile)
      .toList();

  void saveMedicine(Medicine medicine) {
    final index = medicines.indexWhere((item) => item.id == medicine.id);
    if (index < 0) {
      medicines.add(medicine);
    } else {
      medicines[index] = medicine;
    }
    notifyListeners();
  }

  void setMedicineStatus(String id, MedicineStatus status) {
    final index = medicines.indexWhere((item) => item.id == id);
    if (index < 0) return;
    medicines[index] = medicines[index].copyWith(status: status);
    notifyListeners();
  }

  ReminderEvent? dueReminderForSelectedProfile() {
    final matches = reminders.where(
      (item) =>
          item.careProfileId == selectedProfile &&
          (item.status == ReminderStatus.due ||
              item.status == ReminderStatus.snoozed),
    );
    return matches.isEmpty ? null : matches.first;
  }

  void setDemoOffline(bool value) {
    demoOffline = value;
    notifyListeners();
  }

  void actOnReminder(
    String id,
    ReminderStatus status, {
    int snoozeMinutes = 15,
  }) {
    final index = reminders.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final now = DateTime.now();
    reminders[index] = reminders[index].copyWith(
      status: status,
      actionedAt:
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
      snoozedUntil: status == ReminderStatus.snoozed
          ? now.add(Duration(minutes: snoozeMinutes)).toIso8601String()
          : '',
      queuedOffline: demoOffline,
      note: status == ReminderStatus.escalated
          ? 'Parent requested help.'
          : null,
    );
    notifyListeners();
  }

  AlarmRequest? latestAlarmForReminder(String reminderId) {
    final matches =
        alarmRequests.where((item) => item.reminderId == reminderId).toList()
          ..sort((a, b) => b.requestedAt.compareTo(a.requestedAt));
    return matches.isEmpty ? null : matches.first;
  }

  bool canSendAlarm(String reminderId) {
    final latest = latestAlarmForReminder(reminderId);
    if (latest == null) return true;
    return DateTime.now().difference(latest.requestedAt).inSeconds >= 30;
  }

  void sendRemoteAlarm(String reminderId, {required String type}) {
    final reminder = reminders.firstWhere((item) => item.id == reminderId);
    alarmRequests.add(
      AlarmRequest(
        id: 'alarm-live-${alarmRequests.length + 1}',
        reminderId: reminderId,
        careProfileId: reminder.careProfileId,
        requestedBy: 'Sharif Rahman',
        type: type,
        status: AlarmDeliveryStatus.delivered,
        requestedAt: DateTime.now(),
        deliveredAt: 'Just now',
      ),
    );
    notifyListeners();
  }

  void resolveReminder(String id) {
    actOnReminder(id, ReminderStatus.resolved);
  }

  List<EmergencyContact> emergencyContactsForSelectedProfile() =>
      emergencyContacts
          .where((contact) => contact.careProfileId == selectedProfile)
          .toList()
        ..sort((a, b) => a.priorityLevel.compareTo(b.priorityLevel));

  List<EmergencyAlert> emergencyAlertsForSelectedProfile() =>
      emergencyAlerts
          .where((alert) => alert.careProfileId == selectedProfile)
          .toList()
        ..sort((a, b) => b.triggeredAt.compareTo(a.triggeredAt));

  void saveEmergencyContact(EmergencyContact contact) {
    final index = emergencyContacts.indexWhere((item) => item.id == contact.id);
    if (index < 0) {
      emergencyContacts.add(contact);
    } else {
      emergencyContacts[index] = contact;
    }
    notifyListeners();
  }

  void setEmergencyContactStatus(String id, ContactVerificationStatus status) {
    final index = emergencyContacts.indexWhere((item) => item.id == id);
    if (index < 0) return;
    emergencyContacts[index] = emergencyContacts[index].copyWith(
      verificationStatus: status,
    );
    notifyListeners();
  }

  EmergencyAlert triggerEmergencyAlert({required String reason}) {
    final now = DateTime.now();
    final alert = EmergencyAlert(
      id: 'emergency-live-${now.microsecondsSinceEpoch}',
      careProfileId: selectedProfile,
      triggeredBy: role == AppRole.parent ? 'Parent' : 'Caregiver',
      reason: reason,
      status: EmergencyAlertStatus.active,
      triggeredAt: now,
      acceptedBy: '',
      resolvedAt: '',
      timeline: ['Alert triggered', 'Priority 1 contacts notified'],
    );
    emergencyAlerts.add(alert);
    notifyListeners();
    return alert;
  }

  void notifyPriorityOne(String id) {
    _updateEmergencyAlert(
      id,
      (alert) => alert.copyWith(
        timeline: [...alert.timeline, 'Priority 1 contacts notified again'],
      ),
    );
  }

  void acceptEmergencyAlert(String id, String contactName) {
    _updateEmergencyAlert(
      id,
      (alert) => alert.copyWith(
        status: EmergencyAlertStatus.accepted,
        acceptedBy: contactName,
        timeline: [...alert.timeline, '$contactName is going to help'],
      ),
    );
  }

  void resolveEmergencyAlert(String id) {
    final now = DateTime.now();
    _updateEmergencyAlert(
      id,
      (alert) => alert.copyWith(
        status: EmergencyAlertStatus.resolved,
        resolvedAt:
            '${now.day}/${now.month}/${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
        timeline: [...alert.timeline, 'Alert resolved'],
      ),
    );
  }

  void _updateEmergencyAlert(
    String id,
    EmergencyAlert Function(EmergencyAlert alert) update,
  ) {
    final index = emergencyAlerts.indexWhere((item) => item.id == id);
    if (index < 0) return;
    emergencyAlerts[index] = update(emergencyAlerts[index]);
    notifyListeners();
  }

  List<HealthDocument> documentsForSelectedProfile() =>
      documents
          .where((document) => document.careProfileId == selectedProfile)
          .toList()
        ..sort((a, b) => b.documentDate.compareTo(a.documentDate));

  void saveDocument(HealthDocument document) {
    final index = documents.indexWhere((item) => item.id == document.id);
    if (index < 0) {
      documents.add(document);
    } else {
      documents[index] = document;
    }
    notifyListeners();
  }

  void retryDocumentUpload(String id) {
    _updateDocument(
      id,
      (document) => document.copyWith(
        uploadStatus: DocumentUploadStatus.ready,
        uploadProgress: 1,
        accessHistory: [
          ...document.accessHistory,
          const DocumentAccessEvent(
            actor: 'Sharif Rahman',
            action: 'Upload retried successfully',
            timestamp: 'Just now',
          ),
        ],
      ),
    );
  }

  void recordDocumentAccess(String id, String action) {
    _updateDocument(
      id,
      (document) => document.copyWith(
        accessHistory: [
          ...document.accessHistory,
          DocumentAccessEvent(
            actor: 'Sharif Rahman',
            action: action,
            timestamp: 'Just now',
          ),
        ],
      ),
    );
  }

  void setDocumentStatus(String id, HealthDocumentStatus status) {
    _updateDocument(
      id,
      (document) => document.copyWith(
        status: status,
        accessHistory: [
          ...document.accessHistory,
          DocumentAccessEvent(
            actor: 'Sharif Rahman',
            action: status == HealthDocumentStatus.archived
                ? 'Archived'
                : 'Deleted',
            timestamp: 'Just now',
          ),
        ],
      ),
    );
  }

  void _updateDocument(
    String id,
    HealthDocument Function(HealthDocument document) update,
  ) {
    final index = documents.indexWhere((item) => item.id == id);
    if (index < 0) return;
    documents[index] = update(documents[index]);
    notifyListeners();
  }

  List<Doctor> doctorsForSelectedProfile() => doctors
      .where((doctor) => doctor.linkedCareProfileIds.contains(selectedProfile))
      .toList();

  List<Appointment> appointmentsForSelectedProfile() =>
      appointments
          .where((appointment) => appointment.careProfileId == selectedProfile)
          .toList()
        ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

  Doctor? doctorById(String id) {
    final matches = doctors.where((doctor) => doctor.id == id);
    return matches.isEmpty ? null : matches.first;
  }

  void saveDoctor(Doctor doctor) {
    final index = doctors.indexWhere((item) => item.id == doctor.id);
    if (index < 0) {
      doctors.add(doctor);
    } else {
      doctors[index] = doctor;
    }
    notifyListeners();
  }

  bool hasAppointmentConflict(DateTime dateTime, {String? excludingId}) =>
      appointments.any(
        (item) =>
            item.id != excludingId &&
            item.careProfileId == selectedProfile &&
            item.status != AppointmentStatus.cancelled &&
            item.dateTime.difference(dateTime).abs().inMinutes < 60,
      );

  void saveAppointment(Appointment appointment) {
    final index = appointments.indexWhere((item) => item.id == appointment.id);
    if (index < 0) {
      appointments.add(appointment);
      timelineEvents.insert(0, 'Appointment scheduled: ${appointment.reason}');
    } else {
      appointments[index] = appointment;
      timelineEvents.insert(0, 'Appointment updated: ${appointment.reason}');
    }
    notifyListeners();
  }

  void rescheduleAppointment(String id, DateTime dateTime) {
    _updateAppointment(
      id,
      (item) => item.copyWith(
        dateTime: dateTime,
        status: AppointmentStatus.rescheduled,
      ),
    );
    timelineEvents.insert(0, 'Appointment rescheduled');
  }

  void completeAppointment(
    String id, {
    required String summary,
    required bool followUpRequired,
    required String followUpDate,
  }) {
    _updateAppointment(
      id,
      (item) => item.copyWith(
        status: followUpRequired
            ? AppointmentStatus.followUpRequired
            : AppointmentStatus.completed,
        visitSummary: summary,
        followUpRequired: followUpRequired,
        followUpDate: followUpDate,
      ),
    );
    timelineEvents.insert(0, 'Appointment completed and visit notes added');
  }

  void setAppointmentStatus(String id, AppointmentStatus status) {
    _updateAppointment(id, (item) => item.copyWith(status: status));
  }

  void _updateAppointment(
    String id,
    Appointment Function(Appointment appointment) update,
  ) {
    final index = appointments.indexWhere((item) => item.id == id);
    if (index < 0) return;
    appointments[index] = update(appointments[index]);
    notifyListeners();
  }

  void archiveCareProfile(String id) {
    final index = careProfiles.indexWhere((item) => item.id == id);
    if (index < 0) return;
    careProfiles[index] = careProfiles[index].copyWith(
      status: CareProfileStatus.archived,
    );
    final active = careProfiles.where(
      (profile) => profile.status == CareProfileStatus.active,
    );
    selectedProfile = active.isEmpty ? '' : active.first.id;
    familyActivity.insert(0, 'Care profile archived');
    notifyListeners();
  }

  void _seedDemoProfiles() {
    familyGroupName = 'Sharif Family Care';
    careProfiles
      ..add(_fatherProfile())
      ..add(_motherProfile())
      ..addAll(DemoFixtures.extraCareProfiles());
    familyMembers.addAll(DemoFixtures.familyMembers());
    familyInvitations.addAll(DemoFixtures.invitations());
    medicines
      ..add(_metformin())
      ..add(_amlodipine())
      ..add(_vitaminD())
      ..addAll(DemoFixtures.medicines());
    reminders.addAll(DemoFixtures.reminders());
    alarmRequests.addAll(DemoFixtures.alarmRequests());
    emergencyContacts.addAll(DemoFixtures.emergencyContacts());
    emergencyAlerts.addAll(DemoFixtures.emergencyAlerts());
    documents.addAll(DemoFixtures.documents());
    doctors.addAll(DemoFixtures.doctors());
    appointments.addAll(DemoFixtures.appointments());
  }

  static CareProfile _fatherProfile() => const CareProfile(
    id: 'father',
    fullName: 'Abdul Karim',
    preferredName: 'Father',
    relationship: 'Father',
    dateOfBirth: '1967-03-12',
    gender: 'Male',
    bloodGroup: 'B+',
    phone: '+880 1712 345678',
    address: 'Dhanmondi',
    city: 'Dhaka',
    country: 'Bangladesh',
    timezone: 'Asia/Dhaka',
    language: 'Bangla',
    medicalConditions: 'High blood pressure, diabetes',
    allergies: 'No known allergies',
    mobilityNotes: 'Walks slowly; use the lift when possible.',
    doctorNotes: 'Monitor blood pressure each morning.',
    emergencyInstructions: 'Call neighbour Rahim, then primary caregiver.',
    primaryCaregiver: 'Sharif Rahman',
    secondaryCaregiver: 'Nadia Rahman',
    medicinesDue: 4,
    missedReminders: 1,
    documentsThisWeek: 2,
    upcomingAppointment: '25 June · Cardiologist',
  );

  static CareProfile _motherProfile() => const CareProfile(
    id: 'mother',
    fullName: 'Salma Begum',
    preferredName: 'Mother',
    relationship: 'Mother',
    dateOfBirth: '1970-08-24',
    gender: 'Female',
    bloodGroup: 'O+',
    phone: '+880 1812 345678',
    address: 'Dhanmondi',
    city: 'Dhaka',
    country: 'Bangladesh',
    timezone: 'Asia/Dhaka',
    language: 'Bangla',
    medicalConditions: 'Arthritis',
    allergies: 'Penicillin',
    mobilityNotes: 'Avoid long stairs.',
    doctorNotes: 'Follow up if knee pain increases.',
    emergencyInstructions: 'Call primary caregiver and local cousin.',
    primaryCaregiver: 'Sharif Rahman',
    secondaryCaregiver: 'Nadia Rahman',
    medicinesDue: 3,
    missedReminders: 0,
    documentsThisWeek: 1,
    upcomingAppointment: '2 July · Orthopaedics',
  );

  static Medicine _metformin() => const Medicine(
    id: 'med-metformin',
    careProfileId: 'father',
    name: 'Metformin 500mg',
    genericName: 'Metformin',
    brandName: 'Metformin',
    strength: '500 mg',
    form: 'Tablet',
    dosage: '1 tablet',
    quantityPerDose: 1,
    prescribedBy: 'Dr. Anjali Mehta',
    linkedDoctor: 'Dr. Anjali Mehta',
    linkedPrescription: 'Prescription_May21.pdf',
    stockCount: 12,
    lowStockThreshold: 5,
    notes: 'Take after breakfast and dinner.',
    sideEffectNotes: 'Report persistent nausea to doctor.',
    status: MedicineStatus.active,
    schedule: MedicineSchedule(
      frequency: MedicineFrequency.twiceDaily,
      times: ['09:00', '20:00'],
      daysOfWeek: {1, 2, 3, 4, 5, 6, 7},
      startDate: '2026-06-01',
      endDate: '',
      timezone: 'Asia/Dhaka',
      foodInstruction: 'After food',
      isLongTerm: true,
    ),
  );

  static Medicine _amlodipine() => const Medicine(
    id: 'med-amlodipine',
    careProfileId: 'father',
    name: 'Amlodipine 5mg',
    genericName: 'Amlodipine',
    brandName: 'Amlodipine',
    strength: '5 mg',
    form: 'Tablet',
    dosage: '1 tablet',
    quantityPerDose: 1,
    prescribedBy: 'Dr. Anjali Mehta',
    linkedDoctor: 'Dr. Anjali Mehta',
    linkedPrescription: 'Prescription_May21.pdf',
    stockCount: 4,
    lowStockThreshold: 5,
    notes: 'Take every morning.',
    sideEffectNotes: '',
    status: MedicineStatus.active,
    schedule: MedicineSchedule(
      frequency: MedicineFrequency.onceDaily,
      times: ['09:00'],
      daysOfWeek: {1, 2, 3, 4, 5, 6, 7},
      startDate: '2026-06-01',
      endDate: '',
      timezone: 'Asia/Dhaka',
      foodInstruction: 'After food',
      isLongTerm: true,
    ),
  );

  static Medicine _vitaminD() => const Medicine(
    id: 'med-vitamin-d',
    careProfileId: 'mother',
    name: 'Vitamin D3 60K',
    genericName: 'Cholecalciferol',
    brandName: 'Vitamin D3',
    strength: '60,000 IU',
    form: 'Capsule',
    dosage: '1 capsule',
    quantityPerDose: 1,
    prescribedBy: 'Dr. Neha Kapoor',
    linkedDoctor: 'Dr. Neha Kapoor',
    linkedPrescription: '',
    stockCount: 8,
    lowStockThreshold: 2,
    notes: 'Every Sunday after breakfast.',
    sideEffectNotes: '',
    status: MedicineStatus.active,
    schedule: MedicineSchedule(
      frequency: MedicineFrequency.weekly,
      times: ['09:00'],
      daysOfWeek: {7},
      startDate: '2026-06-01',
      endDate: '2026-08-31',
      timezone: 'Asia/Dhaka',
      foodInstruction: 'After food',
      isLongTerm: false,
    ),
  );
}
