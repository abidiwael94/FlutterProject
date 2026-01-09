import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/event.dart';
import '../../Models/favorite.dart';
import '../../Models/reservation.dart';
import '../services/event_service.dart';

class EventProvider with ChangeNotifier {
  final EventService _service = EventService();

  List<Event> _events = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchEvents() async {
    _isLoading = true;
    notifyListeners();

    try {
      _events = await _service.getEvents();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite(Event event, String userId) async {
    final favorite = Favorite(
      id: FirebaseFirestore.instance.collection('favorite').doc().id,
      userId: userId,
      eventId: event.id,
      likedAt: DateTime.now().toIso8601String(),
    );

    await FirebaseFirestore.instance.collection('favorite').doc(favorite.id).set({
      'id': favorite.id,
      'userId': favorite.userId,
      'eventId': favorite.eventId,
      'likedAt': favorite.likedAt,
    });
  }

  Future<void> addReservation(Event event, String userId) async {
    final reservation = Reservation(
      id: FirebaseFirestore.instance.collection('reservation').doc().id,
      userId: userId,
      eventId: event.id,
      reservedAt: DateTime.now().toIso8601String(),
    );

    await FirebaseFirestore.instance.collection('reservation').doc(reservation.id).set({
      'id': reservation.id,
      'userId': reservation.userId,
      'eventId': reservation.eventId,
      'reservedAt': reservation.reservedAt,
    });
  }
}
