import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/reservation.dart';

class ReservationService {
  // static const String basePath = 'https://localhost:8080';
  static const String basePath = 'https://192.168.0.162:8080';
  // static const String basePath = 'https://172.20.10.5:8080';

  static Future<List<Reservation>> getReservations() async {
    String endpoint = '/api/v1/reservation';

    final response = await http.get(Uri.parse('$basePath$endpoint'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<Reservation> reservations = List<Reservation>.from(
          jsonResponse.map((model) => Reservation.fromJson(model)));
      return reservations;
    } else {
      throw Exception('Failed to fetch reservations');
    }
  }

  static Future<bool> cancelReservation(String reservationId) async {
    String endpoint = '/api/v1/reservation/cancel/$reservationId';

    var response = await http.patch(Uri.parse('$basePath$endpoint'),
        body: json.encode({}));

    return (response.statusCode == 200);
  }

  static Future<bool> finalizeReservation(
      String reservationId, String review) async {
    String endpoint = '/api/v1/reservation/finalize/$reservationId';

    var response =
        await http.patch(Uri.parse('$basePath$endpoint'), body: review);

    return (response.statusCode == 200);
  }
}
