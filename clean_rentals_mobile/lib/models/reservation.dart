import 'package:clean_rentals_mobile/models/reservation_option.dart';

import 'car.dart';
import 'client.dart';
import 'location.dart';

class Reservation {
  Reservation(
      {required this.id,
      required this.client,
      required this.car,
      required this.location,
      this.reservationOptions,
      required this.dateTimeStart,
      this.dateTimeStop,
      required this.total_price_euro_excl_vat});

  final String id;
  final Client client;
  final Car car;
  final Location location;
  final List<ReservationOption>? reservationOptions;
  final DateTime dateTimeStart;
  final DateTime? dateTimeStop;
  final int total_price_euro_excl_vat;
}
