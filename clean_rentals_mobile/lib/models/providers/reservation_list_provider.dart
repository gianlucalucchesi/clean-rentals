import 'package:flutter/material.dart';

import '../../services/reservation_service.dart';
import '../reservation.dart';

class ReservationListProvider with ChangeNotifier {
  late List<Reservation> _reservationList = [];

  List<Reservation> get reservationList {
    ReservationService.getReservations().then((value) {
      _reservationList = value;
    });
    return [..._reservationList];
  }

  List<Reservation> get activeReservationList {
    ReservationService.getReservations().then((value) {
      _reservationList = value;
    });
    return [
      ..._reservationList
          .where((element) => !element.returned && !element.cancelled)
    ];
  }

  Reservation findById(String id) {
    return _reservationList.firstWhere((element) => element.id == id);
  }

  void addReservation(Reservation reservation) {
    _reservationList.add(reservation);
  }
}
