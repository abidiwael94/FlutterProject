import 'package:project_flutter/Models/favorite.dart';
import 'package:project_flutter/Models/reservation.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;


  List<Reservation>? reservations;
  List<Favorite>? favorites;


  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    List<Reservation>? reservations,
    List<Favorite>? favorites,
  })  : reservations = reservations ?? [],
        favorites = favorites ?? [];
}
