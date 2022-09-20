// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

import 'car.dart';
import 'client.dart';
import 'location.dart';
import 'reservation_option.dart';

class Reservation with ChangeNotifier {
  final String id;
  final Client client;
  final Car car;
  final Location location;
  final List<ReservationOption>? reservationOptions;
  final int dateTimeStart;
  final int dateTimeStop;
  final double total_price_euro_excl_vat;
  final String? review_text;
  final bool paid;
  final bool returned;
  final bool cancelled;

  Reservation({
    required this.id,
    required this.client,
    required this.car,
    required this.location,
    this.reservationOptions,
    required this.dateTimeStart,
    required this.dateTimeStop,
    required this.total_price_euro_excl_vat,
    this.review_text,
    required this.paid,
    required this.returned,
    required this.cancelled,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    var list = json['reservationOptions'] as List;
    List<ReservationOption> reservationOpions =
        list.map((i) => ReservationOption.fromJson(i)).toList();

    return Reservation(
      id: json['id'],
      client: json['client'] = Client.fromJson(
        json['client'],
      ),
      car: json['car'] = Car.fromJson(json['car']),
      location: json['location'] = Location.fromJson(json['location']),
      reservationOptions: reservationOpions,
      dateTimeStart: json['dateTimeStart'],
      dateTimeStop: json['dateTimeStop'],
      total_price_euro_excl_vat: json['total_price_euro_excl_vat'],
      review_text: json['review_text'],
      paid: json['paid'],
      returned: json['returned'],
      cancelled: json['cancelled'],
    );
  }
}
