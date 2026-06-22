enum ReminderStatus {
  scheduled,
  due,
  taken,
  snoozed,
  skipped,
  missed,
  escalated,
  resolved,
  cancelled,
}

class ReminderEvent {
  const ReminderEvent({
    required this.id,
    required this.careProfileId,
    required this.medicineId,
    required this.medicineName,
    required this.dosage,
    required this.scheduledAt,
    required this.timezone,
    required this.status,
    required this.foodInstruction,
    this.actionedAt = '',
    this.snoozedUntil = '',
    this.note = '',
    this.queuedOffline = false,
  });

  final String id;
  final String careProfileId;
  final String medicineId;
  final String medicineName;
  final String dosage;
  final DateTime scheduledAt;
  final String timezone;
  final ReminderStatus status;
  final String foodInstruction;
  final String actionedAt;
  final String snoozedUntil;
  final String note;
  final bool queuedOffline;

  ReminderEvent copyWith({
    ReminderStatus? status,
    String? actionedAt,
    String? snoozedUntil,
    String? note,
    bool? queuedOffline,
  }) => ReminderEvent(
    id: id,
    careProfileId: careProfileId,
    medicineId: medicineId,
    medicineName: medicineName,
    dosage: dosage,
    scheduledAt: scheduledAt,
    timezone: timezone,
    status: status ?? this.status,
    foodInstruction: foodInstruction,
    actionedAt: actionedAt ?? this.actionedAt,
    snoozedUntil: snoozedUntil ?? this.snoozedUntil,
    note: note ?? this.note,
    queuedOffline: queuedOffline ?? this.queuedOffline,
  );
}
