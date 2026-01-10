import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:project_flutter/Models/event.dart';

class EventService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get _events => _db.collection('events');

  String generateId() {
    final id = _events.doc().id;
    debugPrint("Generated new Event ID: $id");
    return id;
  }

  Stream<List<Event>> getEvents() {
    print("Fetching events stream...");
    return _events.snapshots().map((snapshot) {
      final events = snapshot.docs.map<Event>((doc) {
        final data = doc.data() as Map<String, dynamic>;
        DateTime date;

        if (data['date'] is Timestamp) {
          date = (data['date'] as Timestamp).toDate();
        } else if (data['date'] is String) {
          date = DateTime.parse(data['date']);
        } else {
          date = DateTime.now();
        }

        final event = Event(
          id: doc.id,
          title: data['title'] ?? 'No title',
          description: data['description'] ?? '',
          date: date,
        );

        print("Loaded event: ${event.id} - ${event.title} - ${event.date}");
        return event;
      }).toList();

      print("Total events loaded: ${events.length}");
      return events;
    });
  }

  Future<void> createEvent(Event event) async {
    try {
      await _events.doc(event.id).set({
        'title': event.title,
        'description': event.description,
        'date': Timestamp.fromDate(event.date),
      });
      print("Event created: ${event.id} - ${event.title}");
    } catch (e) {
      print("Error creating event: $e");
      rethrow;
    }
  }

  Future<void> updateEvent(Event event) async {
    try {
      await _events.doc(event.id).update({
        'title': event.title,
        'description': event.description,
        'date': Timestamp.fromDate(event.date),
      });
      print("Event updated: ${event.id} - ${event.title}");
    } catch (e) {
      print("Error updating event: $e");
      rethrow;
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await _events.doc(id).delete();
      print("Event deleted: $id");
    } catch (e) {
      print("Error deleting event: $e");
      rethrow;
    }
  }
}
