import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/event.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Event>> getEvents() async {
    try {
      final snapshot = await _db.collection('events').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();

        // 🔥 SAFE DATE CONVERSION (THE PART YOU ASKED ABOUT)
        DateTime eventDate;
        final rawDate = data['date'];

        if (rawDate is Timestamp) {
          eventDate = rawDate.toDate();
        } else if (rawDate is String) {
          eventDate = DateTime.parse(rawDate);
        } else {
          eventDate = DateTime.now();
        }

        return Event(
          id: doc.id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          date: eventDate,
        );
      }).toList();

    } catch (e) {
      throw Exception('Erreur récupération événements : $e');
    }
  }
}
