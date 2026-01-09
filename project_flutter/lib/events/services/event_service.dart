import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/event.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Récupérer tous les événements
  Future<List<Event>> getEvents() async {
    try {
      final snapshot = await _db.collection('events').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Event(
          id: doc.id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          date: (data['date'] as Timestamp).toDate(),
          adminId: data['adminId'] ?? '',
        );
      }).toList();
    } catch (e) {
      throw Exception('Erreur récupération événements : $e');
    }
  }
}
