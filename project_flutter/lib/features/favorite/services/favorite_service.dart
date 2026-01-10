import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_flutter/Models/favorite.dart';

class FavoriteService {
  final CollectionReference favoritesRef =
      FirebaseFirestore.instance.collection('favorite');

  final User? currentUser = FirebaseAuth.instance.currentUser;

  /// Add a favorite
  Future<void> addFavorite(String eventId) async {
    if (currentUser == null) return;

    // Check if already favorited
    final existing = await favoritesRef
        .where('userId', isEqualTo: currentUser!.uid)
        .where('eventId', isEqualTo: eventId)
        .get();

    if (existing.docs.isNotEmpty) return;

    final docRef = favoritesRef.doc();

    final favorite = Favorite(
      id: docRef.id,
      userId: currentUser!.uid,
      eventId: eventId,
      likedAt: DateTime.now().toIso8601String(),
    );

    await docRef.set(favorite.toMap());
  }

  /// Remove a favorite
  Future<void> removeFavorite(String eventId) async {
    if (currentUser == null) return;

    final existing = await favoritesRef
        .where('userId', isEqualTo: currentUser!.uid)
        .where('eventId', isEqualTo: eventId)
        .get();

    for (var doc in existing.docs) {
      await favoritesRef.doc(doc.id).delete();
    }
  }

  /// Check if an event is favorited
  Future<bool> isFavorite(String eventId) async {
    if (currentUser == null) return false;

    final existing = await favoritesRef
        .where('userId', isEqualTo: currentUser!.uid)
        .where('eventId', isEqualTo: eventId)
        .get();

    return existing.docs.isNotEmpty;
  }

  /// Stream all favorites for current user
  Stream<List<Favorite>> getUserFavorites() {
    if (currentUser == null) return const Stream.empty();

    return favoritesRef
        .where('userId', isEqualTo: currentUser!.uid)
        .orderBy('likedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Favorite.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }
}
