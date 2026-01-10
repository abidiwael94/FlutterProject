import 'package:flutter/material.dart';
import 'package:project_flutter/Models/reservation.dart';
import 'package:project_flutter/features/reservation/services/reservation_service.dart';

class ReservationProvider extends ChangeNotifier {
  final ReservationService _service = ReservationService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Stream<List<Reservation>> getReservations(String userId) {
    return _service.getUserReservations(userId);
  }

  Future<void> deleteReservation(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _service.cancelReservation(id);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}