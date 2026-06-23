enum ContactVerificationStatus {
  added,
  invited,
  verified,
  active,
  inactive,
  removed,
}

enum EmergencyAlertStatus { active, accepted, resolved }

class EmergencyContact {
  const EmergencyContact({
    required this.id,
    required this.careProfileId,
    required this.fullName,
    required this.relationship,
    required this.contactType,
    required this.primaryPhone,
    required this.secondaryPhone,
    required this.whatsappNumber,
    required this.email,
    required this.address,
    required this.distanceNote,
    required this.availabilityNote,
    required this.preferredContactMethod,
    required this.priorityLevel,
    required this.verificationStatus,
    required this.canReceiveEmergencyAlerts,
    required this.canReceiveMissedMedicineAlerts,
    required this.canViewBasicProfile,
    required this.canViewMedicalSummary,
    required this.canViewDocuments,
    required this.canViewLocation,
    required this.notes,
  });

  final String id;
  final String careProfileId;
  final String fullName;
  final String relationship;
  final String contactType;
  final String primaryPhone;
  final String secondaryPhone;
  final String whatsappNumber;
  final String email;
  final String address;
  final String distanceNote;
  final String availabilityNote;
  final String preferredContactMethod;
  final int priorityLevel;
  final ContactVerificationStatus verificationStatus;
  final bool canReceiveEmergencyAlerts;
  final bool canReceiveMissedMedicineAlerts;
  final bool canViewBasicProfile;
  final bool canViewMedicalSummary;
  final bool canViewDocuments;
  final bool canViewLocation;
  final String notes;

  String get initials => fullName
      .split(' ')
      .where((part) => part.isNotEmpty)
      .map((part) => part[0])
      .take(2)
      .join();

  EmergencyContact copyWith({ContactVerificationStatus? verificationStatus}) =>
      EmergencyContact(
        id: id,
        careProfileId: careProfileId,
        fullName: fullName,
        relationship: relationship,
        contactType: contactType,
        primaryPhone: primaryPhone,
        secondaryPhone: secondaryPhone,
        whatsappNumber: whatsappNumber,
        email: email,
        address: address,
        distanceNote: distanceNote,
        availabilityNote: availabilityNote,
        preferredContactMethod: preferredContactMethod,
        priorityLevel: priorityLevel,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        canReceiveEmergencyAlerts: canReceiveEmergencyAlerts,
        canReceiveMissedMedicineAlerts: canReceiveMissedMedicineAlerts,
        canViewBasicProfile: canViewBasicProfile,
        canViewMedicalSummary: canViewMedicalSummary,
        canViewDocuments: canViewDocuments,
        canViewLocation: canViewLocation,
        notes: notes,
      );
}

class EmergencyAlert {
  const EmergencyAlert({
    required this.id,
    required this.careProfileId,
    required this.triggeredBy,
    required this.reason,
    required this.status,
    required this.triggeredAt,
    required this.acceptedBy,
    required this.resolvedAt,
    required this.timeline,
  });

  final String id;
  final String careProfileId;
  final String triggeredBy;
  final String reason;
  final EmergencyAlertStatus status;
  final DateTime triggeredAt;
  final String acceptedBy;
  final String resolvedAt;
  final List<String> timeline;

  EmergencyAlert copyWith({
    EmergencyAlertStatus? status,
    String? acceptedBy,
    String? resolvedAt,
    List<String>? timeline,
  }) => EmergencyAlert(
    id: id,
    careProfileId: careProfileId,
    triggeredBy: triggeredBy,
    reason: reason,
    status: status ?? this.status,
    triggeredAt: triggeredAt,
    acceptedBy: acceptedBy ?? this.acceptedBy,
    resolvedAt: resolvedAt ?? this.resolvedAt,
    timeline: timeline ?? this.timeline,
  );
}
