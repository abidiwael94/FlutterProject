  import 'package:project_flutter/Models/reservation.dart';
  import 'package:project_flutter/Models/favorite.dart';
  import 'package:project_flutter/Models/user_role.dart';



  class User {
    final String id;
    final String username;
    final String email;
    final String password;
    final UserRole role;

    // Relations
    List<Reservation> reservations = [];
    List<Favorite> favorites = [];


    User({
      required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.role,
      List<Reservation>? reservations,
      List<Favorite>? favorites,
    }) {
      if (reservations != null) this.reservations = reservations;
      if (favorites != null) this.favorites = favorites;
    }

  }
