import 'package:project_flutter/Models/favorite.dart';
import 'package:project_flutter/Models/reservation.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;

  // Relations
  String adminId; // The admin who created this event
  List<Reservation> reservations = [];
  List<Favorite> favorites = [];
  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.adminId,
    List<Reservation>? reservations,
    List<Favorite>? favorites,
  }) {
    if (reservations != null) this.reservations = reservations;
    if (favorites != null) this.favorites = favorites;
  }
}
