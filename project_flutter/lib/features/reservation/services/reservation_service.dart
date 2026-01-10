import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_flutter/Models/reservation.dart';

class ReservationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Reservation>> getUserReservations(String userId) {
    return _firestore
        .collection('reservations') 
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Reservation.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> cancelReservation(String id) async {
    await _firestore.collection('reservations').doc(id).delete();
  }
}