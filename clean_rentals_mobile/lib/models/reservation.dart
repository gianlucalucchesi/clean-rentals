// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  final DateTime dateTimeStart;
  final DateTime dateTimeStop;
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

  static Future<bool> cancelReservation(String reservationId) async {
    var url = 'https://localhost:8080/api/v1/reservation/cancel/$reservationId';
    var response = await http.patch(Uri.parse(url), body: json.encode({}));

    return (response.statusCode == 200);
  }

  static Future<bool> finalizeReservation(
      String reservationId, String review) async {
    var url =
        'https://localhost:8080/api/v1/reservation/finalize/$reservationId';
    var response = await http.patch(Uri.parse(url), body: review);

    return (response.statusCode == 200);
  }

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      client: json['client'],
      car: json['car'],
      location: json['location'],
      reservationOptions: json['reservationOptions'],
      dateTimeStart: DateTime.parse(json['dateTimeStart']),
      dateTimeStop: DateTime.parse(json['dateTimeStop']),
      total_price_euro_excl_vat: json['total_price_euro_excl_vat'],
      review_text: json['review_text'],
      paid: json['paid'],
      returned: json['returned'],
      cancelled: json['cancelled'],
    );
  }
}
