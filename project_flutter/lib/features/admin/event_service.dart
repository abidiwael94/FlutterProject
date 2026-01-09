import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/Models/event.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get _events => _db.collection('events');


  String generateId() {
    return _events.doc().id;
  }

  Stream<List<Event>> getEvents() {
    return _events.snapshots().map((snapshot) {
      return snapshot.docs.map<Event>((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return Event(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          date: (data['date'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }


  Future<void> createEvent(Event event) async {
    await _events.doc(event.id).set({
      'title': event.title,
      'description': event.description,
      'date': Timestamp.fromDate(event.date),
    });
  }

  Future<void> updateEvent(Event event) async {
    await _events.doc(event.id).update({
      'title': event.title,
      'description': event.description,
      'date': Timestamp.fromDate(event.date),
    });
  }

  Future<void> deleteEvent(String id) async {
    await _events.doc(id).delete();
  }
}
