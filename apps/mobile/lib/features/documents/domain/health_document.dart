enum HealthDocumentType {
  prescription,
  bloodTest,
  urineTest,
  ecg,
  xray,
  mri,
  ctScan,
  ultrasound,
  dischargeSummary,
  doctorNote,
  medicinePhoto,
  hospitalBill,
  insurance,
  followUpNote,
  other,
}

enum HealthDocumentStatus { active, archived, deleted }

enum DocumentUploadStatus { ready, uploading, failed }

class DocumentAccessEvent {
  const DocumentAccessEvent({
    required this.actor,
    required this.action,
    required this.timestamp,
  });
  final String actor;
  final String action;
  final String timestamp;
}

class HealthDocument {
  const HealthDocument({
    required this.id,
    required this.careProfileId,
    required this.title,
    required this.type,
    required this.doctorName,
    required this.hospitalName,
    required this.documentDate,
    required this.tags,
    required this.fileName,
    required this.fileSizeBytes,
    required this.mimeType,
    required this.notes,
    required this.uploadedBy,
    required this.visibleTo,
    required this.linkedMedicine,
    required this.linkedAppointment,
    required this.linkedCondition,
    required this.status,
    required this.uploadStatus,
    required this.uploadProgress,
    required this.accessHistory,
  });

  final String id;
  final String careProfileId;
  final String title;
  final HealthDocumentType type;
  final String doctorName;
  final String hospitalName;
  final String documentDate;
  final List<String> tags;
  final String fileName;
  final int fileSizeBytes;
  final String mimeType;
  final String notes;
  final String uploadedBy;
  final List<String> visibleTo;
  final String linkedMedicine;
  final String linkedAppointment;
  final String linkedCondition;
  final HealthDocumentStatus status;
  final DocumentUploadStatus uploadStatus;
  final double uploadProgress;
  final List<DocumentAccessEvent> accessHistory;

  bool get isImage => mimeType.startsWith('image/');

  HealthDocument copyWith({
    HealthDocumentStatus? status,
    DocumentUploadStatus? uploadStatus,
    double? uploadProgress,
    List<DocumentAccessEvent>? accessHistory,
  }) => HealthDocument(
    id: id,
    careProfileId: careProfileId,
    title: title,
    type: type,
    doctorName: doctorName,
    hospitalName: hospitalName,
    documentDate: documentDate,
    tags: tags,
    fileName: fileName,
    fileSizeBytes: fileSizeBytes,
    mimeType: mimeType,
    notes: notes,
    uploadedBy: uploadedBy,
    visibleTo: visibleTo,
    linkedMedicine: linkedMedicine,
    linkedAppointment: linkedAppointment,
    linkedCondition: linkedCondition,
    status: status ?? this.status,
    uploadStatus: uploadStatus ?? this.uploadStatus,
    uploadProgress: uploadProgress ?? this.uploadProgress,
    accessHistory: accessHistory ?? this.accessHistory,
  );
}
