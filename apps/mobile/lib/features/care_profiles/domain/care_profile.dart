enum CareProfileStatus { active, archived }

class CareProfile {
  const CareProfile({
    required this.id,
    required this.fullName,
    required this.preferredName,
    required this.relationship,
    required this.dateOfBirth,
    required this.gender,
    required this.bloodGroup,
    required this.phone,
    required this.address,
    required this.city,
    required this.country,
    required this.timezone,
    required this.language,
    required this.medicalConditions,
    required this.allergies,
    required this.mobilityNotes,
    required this.doctorNotes,
    required this.emergencyInstructions,
    required this.primaryCaregiver,
    required this.secondaryCaregiver,
    this.status = CareProfileStatus.active,
    this.medicinesDue = 0,
    this.missedReminders = 0,
    this.documentsThisWeek = 0,
    this.upcomingAppointment = '',
  });

  final String id;
  final String fullName;
  final String preferredName;
  final String relationship;
  final String dateOfBirth;
  final String gender;
  final String bloodGroup;
  final String phone;
  final String address;
  final String city;
  final String country;
  final String timezone;
  final String language;
  final String medicalConditions;
  final String allergies;
  final String mobilityNotes;
  final String doctorNotes;
  final String emergencyInstructions;
  final String primaryCaregiver;
  final String secondaryCaregiver;
  final CareProfileStatus status;
  final int medicinesDue;
  final int missedReminders;
  final int documentsThisWeek;
  final String upcomingAppointment;

  String get initials => fullName
      .split(' ')
      .where((part) => part.isNotEmpty)
      .map((part) => part[0])
      .take(2)
      .join();

  CareProfile copyWith({
    String? fullName,
    String? preferredName,
    String? relationship,
    String? dateOfBirth,
    String? gender,
    String? bloodGroup,
    String? phone,
    String? address,
    String? city,
    String? country,
    String? timezone,
    String? language,
    String? medicalConditions,
    String? allergies,
    String? mobilityNotes,
    String? doctorNotes,
    String? emergencyInstructions,
    String? primaryCaregiver,
    String? secondaryCaregiver,
    CareProfileStatus? status,
  }) => CareProfile(
    id: id,
    fullName: fullName ?? this.fullName,
    preferredName: preferredName ?? this.preferredName,
    relationship: relationship ?? this.relationship,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    gender: gender ?? this.gender,
    bloodGroup: bloodGroup ?? this.bloodGroup,
    phone: phone ?? this.phone,
    address: address ?? this.address,
    city: city ?? this.city,
    country: country ?? this.country,
    timezone: timezone ?? this.timezone,
    language: language ?? this.language,
    medicalConditions: medicalConditions ?? this.medicalConditions,
    allergies: allergies ?? this.allergies,
    mobilityNotes: mobilityNotes ?? this.mobilityNotes,
    doctorNotes: doctorNotes ?? this.doctorNotes,
    emergencyInstructions: emergencyInstructions ?? this.emergencyInstructions,
    primaryCaregiver: primaryCaregiver ?? this.primaryCaregiver,
    secondaryCaregiver: secondaryCaregiver ?? this.secondaryCaregiver,
    status: status ?? this.status,
    medicinesDue: medicinesDue,
    missedReminders: missedReminders,
    documentsThisWeek: documentsThisWeek,
    upcomingAppointment: upcomingAppointment,
  );
}
