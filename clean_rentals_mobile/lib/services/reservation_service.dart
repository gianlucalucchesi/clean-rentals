import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/reservation.dart';

class ReservationService {
  static const getReservationsUrlLocal =
      'https://localhost:8080/api/v1/reservation';
  static const getReservationsUrlHome =
      'https://192.168.0.162:8080/api/v1/reservation';
  static const getReservationsUrlMobile =
      'https://172.20.10.5:8080/api/v1/reservation';

  static Future<List<Reservation>> getReservations() async {
    final response = await http.get(Uri.parse(getReservationsUrlHome));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Reservation> reservations = List<Reservation>.from(
          jsonResponse.map((model) => Reservation.fromJson(model)));
      return reservations;
    } else {
      throw Exception('Failed to fetch reservations');
    }
  }
}
