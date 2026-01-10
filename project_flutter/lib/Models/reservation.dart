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

  factory Reservation.fromMap(Map<String, dynamic> data, String documentId) {
    return Reservation(
      id: documentId,
      userId: data['userId'] ?? '',
      eventId: data['eventId'] ?? '',
      reservedAt: data['reservedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'eventId': eventId,
      'reservedAt': reservedAt,
    };
  }
}