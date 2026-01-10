import 'package:flutter/material.dart';
import 'package:project_flutter/Models/favorite.dart';
import 'package:project_flutter/features/favorite/services/favorite_service.dart';


class FavoriteProvider extends ChangeNotifier {
  final FavoriteService _service = FavoriteService();

  List<Favorite> _favorites = [];
  List<Favorite> get favorites => _favorites;

  FavoriteProvider() {
    _listenFavorites();
  }

  void _listenFavorites() {
    _service.getUserFavorites().listen((favList) {
      _favorites = favList;
      notifyListeners();
    });
  }

  Future<void> toggleFavorite(String eventId) async {
    final exists = _favorites.any((f) => f.eventId == eventId);
    if (exists) {
      await _service.removeFavorite(eventId);
    } else {
      await _service.addFavorite(eventId);
    }
  }

  bool isFavorite(String eventId) {
    return _favorites.any((f) => f.eventId == eventId);
  }
}
