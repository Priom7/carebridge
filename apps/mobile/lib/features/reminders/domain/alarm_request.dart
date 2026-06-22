enum AlarmDeliveryStatus {
  requested,
  sent,
  delivered,
  opened,
  actioned,
  failed,
}

class AlarmRequest {
  const AlarmRequest({
    required this.id,
    required this.reminderId,
    required this.careProfileId,
    required this.requestedBy,
    required this.type,
    required this.status,
    required this.requestedAt,
    this.deliveredAt = '',
    this.openedAt = '',
    this.actionedAt = '',
    this.failureReason = '',
  });

  final String id;
  final String reminderId;
  final String careProfileId;
  final String requestedBy;
  final String type;
  final AlarmDeliveryStatus status;
  final DateTime requestedAt;
  final String deliveredAt;
  final String openedAt;
  final String actionedAt;
  final String failureReason;
}
