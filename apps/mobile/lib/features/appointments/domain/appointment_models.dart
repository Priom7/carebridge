enum AppointmentStatus {
  scheduled,
  reminderSent,
  completed,
  missed,
  cancelled,
  rescheduled,
  followUpRequired,
}

class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.speciality,
    required this.hospital,
    required this.phone,
    required this.email,
    required this.address,
    required this.visitingHours,
    required this.notes,
    required this.linkedCareProfileIds,
  });
  final String id;
  final String name;
  final String speciality;
  final String hospital;
  final String phone;
  final String email;
  final String address;
  final String visitingHours;
  final String notes;
  final List<String> linkedCareProfileIds;
}

class Appointment {
  const Appointment({
    required this.id,
    required this.careProfileId,
    required this.doctorId,
    required this.dateTime,
    required this.timezone,
    required this.location,
    required this.reason,
    required this.questions,
    required this.requiredReports,
    required this.status,
    required this.followUpRequired,
    required this.followUpDate,
    required this.visitSummary,
    required this.attachments,
    required this.caregiverNotes,
  });
  final String id;
  final String careProfileId;
  final String doctorId;
  final DateTime dateTime;
  final String timezone;
  final String location;
  final String reason;
  final List<String> questions;
  final List<String> requiredReports;
  final AppointmentStatus status;
  final bool followUpRequired;
  final String followUpDate;
  final String visitSummary;
  final List<String> attachments;
  final String caregiverNotes;

  Appointment copyWith({
    DateTime? dateTime,
    AppointmentStatus? status,
    bool? followUpRequired,
    String? followUpDate,
    String? visitSummary,
  }) => Appointment(
    id: id,
    careProfileId: careProfileId,
    doctorId: doctorId,
    dateTime: dateTime ?? this.dateTime,
    timezone: timezone,
    location: location,
    reason: reason,
    questions: questions,
    requiredReports: requiredReports,
    status: status ?? this.status,
    followUpRequired: followUpRequired ?? this.followUpRequired,
    followUpDate: followUpDate ?? this.followUpDate,
    visitSummary: visitSummary ?? this.visitSummary,
    attachments: attachments,
    caregiverNotes: caregiverNotes,
  );
}
