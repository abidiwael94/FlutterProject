class Reservation {
  final String id;
  final String userId;
  final String eventId;
  final DateTime reservedAt;

  Reservation({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.reservedAt,
  });
}
