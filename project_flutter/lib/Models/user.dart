import 'package:project_flutter/Models/reservation.dart';
import 'package:project_flutter/Models/favorite.dart';
import 'package:project_flutter/Models/userRole.dart';


class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  // Relations
  List<Reservation> reservations = [];
  List<Favorite> favorites = [];

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    List<Reservation>? reservations,
    List<Favorite>? favorites,
  }) {
    if (reservations != null) this.reservations = reservations;
    if (favorites != null) this.favorites = favorites;
  }
}
