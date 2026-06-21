enum FamilyMemberRole { owner, secondaryCaregiver, dependent }

enum InvitationStatus { pending, accepted, revoked, expired }

class FamilyMember {
  const FamilyMember({
    required this.id,
    required this.name,
    required this.relationship,
    required this.role,
    this.canManageMedicines = false,
    this.canManageDocuments = false,
    this.canManageAppointments = false,
    this.canManageEmergencyContacts = false,
  });

  final String id;
  final String name;
  final String relationship;
  final FamilyMemberRole role;
  final bool canManageMedicines;
  final bool canManageDocuments;
  final bool canManageAppointments;
  final bool canManageEmergencyContacts;

  FamilyMember copyWith({
    FamilyMemberRole? role,
    bool? canManageMedicines,
    bool? canManageDocuments,
    bool? canManageAppointments,
    bool? canManageEmergencyContacts,
  }) => FamilyMember(
    id: id,
    name: name,
    relationship: relationship,
    role: role ?? this.role,
    canManageMedicines: canManageMedicines ?? this.canManageMedicines,
    canManageDocuments: canManageDocuments ?? this.canManageDocuments,
    canManageAppointments: canManageAppointments ?? this.canManageAppointments,
    canManageEmergencyContacts:
        canManageEmergencyContacts ?? this.canManageEmergencyContacts,
  );
}

class FamilyInvitation {
  const FamilyInvitation({
    required this.id,
    required this.email,
    required this.role,
    required this.status,
  });

  final String id;
  final String email;
  final FamilyMemberRole role;
  final InvitationStatus status;

  FamilyInvitation copyWith({InvitationStatus? status}) => FamilyInvitation(
    id: id,
    email: email,
    role: role,
    status: status ?? this.status,
  );
}
