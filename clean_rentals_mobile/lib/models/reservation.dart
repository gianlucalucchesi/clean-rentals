import 'package:flutter/material.dart';

import 'car.dart';
import 'client.dart';
import 'location.dart';
import 'reservation_option.dart';

class Reservation {
  final String id;
  final Client client;
  final Car car;
  final Location location;
  final List<ReservationOption>? reservationOptions;
  final DateTime dateTimeStart;
  final DateTime? dateTimeStop;
  final double total_price_euro_excl_vat;

  Reservation({
    required this.id,
    required this.client,
    required this.car,
    required this.location,
    this.reservationOptions,
    required this.dateTimeStart,
    this.dateTimeStop,
    required this.total_price_euro_excl_vat,
  });
}
