import 'package:flutter/material.dart';

import '../../features/family/domain/family_models.dart';

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
      onboardingComplete = initiallyAuthenticated;

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
}
