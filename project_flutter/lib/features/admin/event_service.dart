import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/Models/event.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get _events => _db.collection('events');

  // -----------------------
  // ID
  // -----------------------
  String generateId() {
    return _events.doc().id;
  }

  // -----------------------
  // READ (stream)
  // -----------------------
  Stream<List<Event>> getEvents() {
    return _events.snapshots().map((snapshot) {
      return snapshot.docs.map<Event>((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return Event(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          date: (data['date'] as Timestamp).toDate(),
          adminId: data['adminId'],
        );
      }).toList();
    });
  }

  // -----------------------
  // CREATE
  // -----------------------
  Future<void> createEvent(Event event) async {
    await _events.doc(event.id).set({
      'title': event.title,
      'description': event.description,
      'date': Timestamp.fromDate(event.date),
      'adminId': event.adminId,
    });
  }

  // -----------------------
  // UPDATE
  // -----------------------
  Future<void> updateEvent(Event event) async {
    await _events.doc(event.id).update({
      'title': event.title,
      'description': event.description,
      'date': Timestamp.fromDate(event.date),
      'adminId': event.adminId,
    });
  }

  // -----------------------
  // DELETE
  // -----------------------
  Future<void> deleteEvent(String id) async {
    await _events.doc(id).delete();
  }
}
