class Reservation {
  final String id;
  final String userId;
  final String eventId;
  final String reservedAt;

  Reservation({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.reservedAt,
  });
}
