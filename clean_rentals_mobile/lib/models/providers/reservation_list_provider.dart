import 'dart:convert';

import 'package:clean_rentals_mobile/services/brand_service.dart';
import 'package:clean_rentals_mobile/services/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../brand.dart';
import '../car.dart';
import '../car_option.dart';
import '../city.dart';
import '../client.dart';
import '../location.dart';
import '../country.dart';
import '../reservation.dart';
import '../reservation_option.dart';

class ReservationListProvider with ChangeNotifier {
  static const getReservationsUrl = 'https://localhost:8080/api/v1/reservation';

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
