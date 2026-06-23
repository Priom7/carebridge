import '../../features/care_profiles/domain/care_profile.dart';
import '../../features/family/domain/family_models.dart';
import '../../features/emergency/domain/emergency_models.dart';
import '../../features/documents/domain/health_document.dart';
import '../../features/medicines/domain/medicine.dart';
import '../../features/reminders/domain/reminder_event.dart';
import '../../features/reminders/domain/alarm_request.dart';

abstract final class DemoFixtures {
  static const _firstNames = [
    'Amina',
    'Rahim',
    'Farida',
    'Jamal',
    'Nasrin',
    'Kamal',
    'Rokeya',
    'Hasan',
    'Mariam',
    'Tariq',
    'Shirin',
    'Imran',
    'Laila',
    'Kabir',
    'Nadia',
    'Rashed',
  ];
  static const _lastNames = [
    'Ahmed',
    'Rahman',
    'Karim',
    'Begum',
    'Hossain',
    'Uddin',
  ];
  static const _medicineNames = [
    'Losartan',
    'Atorvastatin',
    'Omeprazole',
    'Aspirin',
    'Bisoprolol',
    'Levothyroxine',
    'Glimepiride',
    'Calcium',
    'Vitamin B12',
    'Pantoprazole',
  ];

  static List<CareProfile> extraCareProfiles({
    int count = 30,
  }) => List.generate(count, (index) {
    final number = index + 3;
    final first = _firstNames[index % _firstNames.length];
    final last = _lastNames[index % _lastNames.length];
    final relationship = const [
      'Grandmother',
      'Grandfather',
      'Aunt',
      'Uncle',
      'Neighbour',
    ][index % 5];
    return CareProfile(
      id: 'profile-$number',
      fullName: '$first $last',
      preferredName: '$relationship $first',
      relationship: relationship,
      dateOfBirth:
          '${1948 + (index % 35)}-${(index % 12 + 1).toString().padLeft(2, '0')}-15',
      gender: index.isEven ? 'Female' : 'Male',
      bloodGroup: const ['A+', 'B+', 'O+', 'AB+'][index % 4],
      phone: '+880 17${(10000000 + index * 7919).toString().padLeft(8, '0')}',
      address: '${20 + index} Lake View Road',
      city: index % 4 == 0 ? 'Chattogram' : 'Dhaka',
      country: 'Bangladesh',
      timezone: 'Asia/Dhaka',
      language: index % 4 == 0 ? 'English' : 'Bangla',
      medicalConditions: const [
        'Hypertension',
        'Type 2 diabetes',
        'Arthritis',
        'High cholesterol',
        'No recorded conditions',
      ][index % 5],
      allergies: index % 6 == 0 ? 'Penicillin' : 'No known allergies',
      mobilityNotes: index % 3 == 0
          ? 'Uses a walking stick outdoors.'
          : 'Independent mobility.',
      doctorNotes: 'Routine follow-up every ${3 + index % 4} months.',
      emergencyInstructions:
          'Call primary caregiver, then Priority 1 local contact.',
      primaryCaregiver: 'Sharif Rahman',
      secondaryCaregiver: 'Nadia Rahman',
      medicinesDue: 1 + index % 5,
      missedReminders: index % 4 == 0 ? 1 : 0,
      documentsThisWeek: index % 3,
      upcomingAppointment: '${1 + index % 28} July · General medicine',
    );
  });

  static List<FamilyMember> familyMembers({int count = 30}) =>
      List.generate(count, (index) {
        final first = _firstNames[index % _firstNames.length];
        final last = _lastNames[(index + 2) % _lastNames.length];
        return FamilyMember(
          id: 'demo-member-$index',
          name: '$first $last',
          relationship: const [
            'Cousin',
            'Neighbour',
            'Aunt',
            'Uncle',
            'Sibling',
          ][index % 5],
          role: index % 7 == 0
              ? FamilyMemberRole.secondaryCaregiver
              : FamilyMemberRole.dependent,
          canManageMedicines: index % 7 == 0,
          canManageAppointments: index % 7 == 0,
          canManageEmergencyContacts: index % 14 == 0,
        );
      });

  static List<FamilyInvitation> invitations({int count = 30}) => List.generate(
    count,
    (index) => FamilyInvitation(
      id: 'demo-invite-$index',
      email: 'caregiver${index + 1}@example.test',
      role: FamilyMemberRole.secondaryCaregiver,
      status: InvitationStatus.values[index % InvitationStatus.values.length],
    ),
  );

  static List<Medicine> medicines({int count = 47}) =>
      List.generate(count, (index) {
        final base = _medicineNames[index % _medicineNames.length];
        final profileId = index % 6 == 0
            ? 'father'
            : index % 7 == 0
            ? 'mother'
            : 'profile-${3 + index % 30}';
        final stock = 2 + index % 29;
        return Medicine(
          id: 'demo-medicine-$index',
          careProfileId: profileId,
          name: '$base ${5 + (index % 10) * 5}mg',
          genericName: base,
          brandName: '$base Care',
          strength: '${5 + (index % 10) * 5} mg',
          form: index % 4 == 0 ? 'Capsule' : 'Tablet',
          dosage: '1 ${index % 4 == 0 ? 'capsule' : 'tablet'}',
          quantityPerDose: 1,
          prescribedBy:
              'Dr. ${_firstNames[(index + 5) % _firstNames.length]} Ahmed',
          linkedDoctor: 'Family physician',
          linkedPrescription: 'Demo_Prescription_${index + 1}.pdf',
          stockCount: stock,
          lowStockThreshold: 5,
          notes: index.isEven
              ? 'Take at the same time each day.'
              : 'Drink a full glass of water.',
          sideEffectNotes: index % 5 == 0
              ? 'Discuss persistent dizziness with doctor.'
              : '',
          status: MedicineStatus.values[index % MedicineStatus.values.length],
          schedule: MedicineSchedule(
            frequency: index.isEven
                ? MedicineFrequency.onceDaily
                : MedicineFrequency.twiceDaily,
            times: index.isEven ? const ['09:00'] : const ['09:00', '20:00'],
            daysOfWeek: const {1, 2, 3, 4, 5, 6, 7},
            startDate: '2026-06-01',
            endDate: index % 3 == 0 ? '2026-08-31' : '',
            timezone: 'Asia/Dhaka',
            foodInstruction: index.isEven ? 'After food' : 'With food',
            isLongTerm: index % 3 != 0,
          ),
        );
      });

  static List<ReminderEvent> reminders({int count = 50}) {
    final now = DateTime(2026, 6, 21, 20);
    return List.generate(count, (index) {
      final status = index == 0
          ? ReminderStatus.due
          : ReminderStatus.values[2 + index % 7];
      final medicine = index.isEven ? 'Metformin 500mg' : 'Amlodipine 5mg';
      return ReminderEvent(
        id: 'reminder-$index',
        careProfileId: index != 0 && index % 5 == 0 ? 'mother' : 'father',
        medicineId: index.isEven ? 'med-metformin' : 'med-amlodipine',
        medicineName: medicine,
        dosage: '1 tablet',
        scheduledAt: now.subtract(Duration(hours: index * 8)),
        timezone: 'Asia/Dhaka',
        status: status,
        foodInstruction: 'After food',
        actionedAt: status == ReminderStatus.taken ? '09:04' : '',
        note: index % 9 == 0 ? 'Confirmed after caregiver call.' : '',
      );
    });
  }

  static List<AlarmRequest> alarmRequests({int count = 40}) => List.generate(
    count,
    (index) => AlarmRequest(
      id: 'alarm-$index',
      reminderId: 'reminder-${1 + index % 49}',
      careProfileId: index % 5 == 0 ? 'mother' : 'father',
      requestedBy: index % 3 == 0 ? 'Nadia Rahman' : 'Sharif Rahman',
      type: index.isEven ? 'remote_ring' : 'reminder_push',
      status:
          AlarmDeliveryStatus.values[index % AlarmDeliveryStatus.values.length],
      requestedAt: DateTime(
        2026,
        6,
        21,
        19,
      ).subtract(Duration(hours: index * 3)),
      deliveredAt: index % 6 == 5 ? '' : '19:02',
      openedAt: index % 3 == 0 ? '19:04' : '',
      actionedAt: index % 4 == 0 ? '19:06' : '',
      failureReason: index % 6 == 5 ? 'Device unavailable' : '',
    ),
  );

  static List<EmergencyContact> emergencyContacts({int count = 40}) =>
      List.generate(count, (index) {
        final first = _firstNames[(index + 3) % _firstNames.length];
        final last = _lastNames[index % _lastNames.length];
        return EmergencyContact(
          id: 'contact-$index',
          careProfileId: index % 6 == 0 ? 'mother' : 'father',
          fullName: '$first $last',
          relationship: const [
            'Neighbour',
            'Cousin',
            'Brother',
            'Doctor',
            'Driver',
          ][index % 5],
          contactType: const [
            'Neighbour',
            'Relative',
            'Relative',
            'Doctor',
            'Driver',
          ][index % 5],
          primaryPhone:
              '+880 18${(10000000 + index * 3571).toString().padLeft(8, '0')}',
          secondaryPhone: index % 4 == 0
              ? '+880 19${(10000000 + index * 1777).toString().padLeft(8, '0')}'
              : '',
          whatsappNumber:
              '+880 18${(10000000 + index * 3571).toString().padLeft(8, '0')}',
          email: 'contact${index + 1}@example.test',
          address: '${10 + index} Dhanmondi Road, Dhaka',
          distanceNote: index % 3 == 0
              ? 'Same building'
              : '${1 + index % 8} km away',
          availabilityNote: index.isEven
              ? 'Morning and evening'
              : 'Available after 6 PM',
          preferredContactMethod: index % 3 == 0 ? 'Call' : 'WhatsApp',
          priorityLevel: 1 + index % 4,
          verificationStatus: ContactVerificationStatus
              .values[index % ContactVerificationStatus.values.length],
          canReceiveEmergencyAlerts: true,
          canReceiveMissedMedicineAlerts: index % 3 != 0,
          canViewBasicProfile: true,
          canViewMedicalSummary: index % 5 == 3,
          canViewDocuments: false,
          canViewLocation: index % 4 == 0,
          notes: 'Fictional local demo contact ${index + 1}.',
        );
      });

  static List<EmergencyAlert> emergencyAlerts({int count = 40}) =>
      List.generate(
        count,
        (index) => EmergencyAlert(
          id: 'emergency-$index',
          careProfileId: index % 6 == 0 ? 'mother' : 'father',
          triggeredBy: index.isEven ? 'Parent' : 'Reminder escalation',
          reason: index % 4 == 0
              ? 'Need Help selected'
              : 'Missed medicine requires attention',
          status: EmergencyAlertStatus
              .values[index % EmergencyAlertStatus.values.length],
          triggeredAt: DateTime(
            2026,
            6,
            22,
            18,
          ).subtract(Duration(hours: index * 6)),
          acceptedBy: index % 3 == 1 ? 'Rahim Ahmed' : '',
          resolvedAt: index % 3 == 2 ? '22 Jun · 18:35' : '',
          timeline: [
            'Alert triggered',
            if (index % 3 != 0) 'Primary caregiver notified',
            if (index % 3 == 1) 'Local contact accepted',
            if (index % 3 == 2) 'Alert resolved',
          ],
        ),
      );

  static List<HealthDocument> documents({
    int count = 40,
  }) => List.generate(count, (index) {
    final type =
        HealthDocumentType.values[index % HealthDocumentType.values.length];
    final isImage = index % 3 == 0;
    return HealthDocument(
      id: 'document-$index',
      careProfileId: index % 6 == 0 ? 'mother' : 'father',
      title: const [
        'Cardiology prescription',
        'Quarterly blood panel',
        'ECG report',
        'Chest X-ray',
        'Hospital discharge summary',
        'Diabetes follow-up note',
      ][index % 6],
      type: type,
      doctorName: const [
        'Dr. Anjali Mehta',
        'Dr. Farhan Khan',
        'Dr. Neha Kapoor',
      ][index % 3],
      hospitalName: const [
        'Square Hospital',
        'Labaid Diagnostics',
        'United Hospital',
      ][index % 3],
      documentDate:
          '2026-${(1 + index % 6).toString().padLeft(2, '0')}-${(2 + index % 26).toString().padLeft(2, '0')}',
      tags: [
        if (index.isEven) 'routine',
        if (index % 3 == 0) 'cardiology',
        '2026',
      ],
      fileName: 'fictional_document_${index + 1}.${isImage ? 'jpg' : 'pdf'}',
      fileSizeBytes: 280000 + index * 73000,
      mimeType: isImage ? 'image/jpeg' : 'application/pdf',
      notes: 'Fictional local demo document for workflow testing only.',
      uploadedBy: index % 4 == 0 ? 'Nadia Rahman' : 'Sharif Rahman',
      visibleTo: index % 5 == 0
          ? ['Sharif Rahman']
          : ['Sharif Rahman', 'Nadia Rahman'],
      linkedMedicine: type == HealthDocumentType.prescription
          ? 'Metformin 500mg'
          : '',
      linkedAppointment: index % 4 == 0 ? 'Cardiology follow-up' : '',
      linkedCondition: index.isEven ? 'High blood pressure' : 'Diabetes',
      status: HealthDocumentStatus
          .values[index % HealthDocumentStatus.values.length],
      uploadStatus: index % 9 == 8
          ? DocumentUploadStatus.failed
          : DocumentUploadStatus.ready,
      uploadProgress: index % 9 == 8 ? 0.42 : 1,
      accessHistory: [
        DocumentAccessEvent(
          actor: index % 4 == 0 ? 'Nadia Rahman' : 'Sharif Rahman',
          action: 'Uploaded',
          timestamp: '22 Jun 2026 · 10:15',
        ),
        const DocumentAccessEvent(
          actor: 'Sharif Rahman',
          action: 'Viewed securely',
          timestamp: '22 Jun 2026 · 10:20',
        ),
      ],
    );
  });
}
