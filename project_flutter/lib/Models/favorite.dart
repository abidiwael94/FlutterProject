class Favorite {
  final String id;
  final String userId;
  final String eventId;
  final String likedAt;

  Favorite({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.likedAt,
  });

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      eventId: map['eventId'] ?? '',
      likedAt: map['likedAt'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'likedAt': likedAt,
    };
  }
}
