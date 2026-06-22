enum MedicineStatus { active, paused, completed, stopped }

enum MedicineFrequency {
  onceDaily,
  twiceDaily,
  threeTimesDaily,
  fourTimesDaily,
  everyXHours,
  specificDays,
  weekly,
  monthly,
  asNeeded,
}

class MedicineSchedule {
  const MedicineSchedule({
    required this.frequency,
    required this.times,
    required this.daysOfWeek,
    required this.startDate,
    required this.endDate,
    required this.timezone,
    required this.foodInstruction,
    required this.isLongTerm,
    this.everyHours = 0,
  });

  final MedicineFrequency frequency;
  final List<String> times;
  final Set<int> daysOfWeek;
  final String startDate;
  final String endDate;
  final String timezone;
  final String foodInstruction;
  final bool isLongTerm;
  final int everyHours;
}

class Medicine {
  const Medicine({
    required this.id,
    required this.careProfileId,
    required this.name,
    required this.genericName,
    required this.brandName,
    required this.strength,
    required this.form,
    required this.dosage,
    required this.quantityPerDose,
    required this.prescribedBy,
    required this.linkedDoctor,
    required this.linkedPrescription,
    required this.stockCount,
    required this.lowStockThreshold,
    required this.notes,
    required this.sideEffectNotes,
    required this.status,
    required this.schedule,
  });

  final String id;
  final String careProfileId;
  final String name;
  final String genericName;
  final String brandName;
  final String strength;
  final String form;
  final String dosage;
  final double quantityPerDose;
  final String prescribedBy;
  final String linkedDoctor;
  final String linkedPrescription;
  final int stockCount;
  final int lowStockThreshold;
  final String notes;
  final String sideEffectNotes;
  final MedicineStatus status;
  final MedicineSchedule schedule;

  bool get isLowStock => stockCount <= lowStockThreshold;

  Medicine copyWith({MedicineStatus? status}) => Medicine(
    id: id,
    careProfileId: careProfileId,
    name: name,
    genericName: genericName,
    brandName: brandName,
    strength: strength,
    form: form,
    dosage: dosage,
    quantityPerDose: quantityPerDose,
    prescribedBy: prescribedBy,
    linkedDoctor: linkedDoctor,
    linkedPrescription: linkedPrescription,
    stockCount: stockCount,
    lowStockThreshold: lowStockThreshold,
    notes: notes,
    sideEffectNotes: sideEffectNotes,
    status: status ?? this.status,
    schedule: schedule,
  );
}
