import 'dart:convert';

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

  List<Reservation> _reservationList2 = [];

  Future<void> fetchReservations() async {
    final response = await http.get(Uri.parse(getReservationsUrl));

    if (response.statusCode == 200) {
      print(response.body);
      // return Reservation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch reservations');
    }
  }

  final List<Reservation> _reservationList = [
    Reservation(
      id: '352a9110-a548-4b43-8e29-9d966586b947',
      client: Client(
          id: '6806ef20-0493-4bf8-b364-747b82b05102',
          firstName: 'Gianluca',
          lastName: 'Lucchesi',
          phoneNumber: '0477123456',
          emailAddress: 'email@gmail.com',
          auth0Id: 'auth123'),
      car: Car(
        id: '91ef163b-7ef0-43ac-9421-a0c6d8116dda',
        brand: Brand(
          id: '2693650d-aae7-4fec-a5d9-9019918444b1',
          name: 'Audi',
        ),
        model: 'Q4 e-tron 40',
        seats: 5,
        doors: 5,
        year: 2021,
        horsepower: 204,
        wltp_range_km: 521,
        battery_capacity_kwh: 82,
        start_day_price_euro_excl_vat: 55,
        carOptions: [
          CarOption(
            id: '0af53a43-1cfb-4545-b9a2-eb105dc56820',
            name: 'GPS',
          ),
          CarOption(
            id: 'b120887b-6361-44a0-be67-d3c0d6f3f128',
            name: 'Adaptive Cruise Control',
          ),
          CarOption(
            id: 'bc394a6c-497c-4ac5-a925-9d01bac63b5b',
            name: 'Heated seats',
          ),
        ],
        image_url: 'assets/images/cars/AudiQ4.png',
      ),
      location: Location(
        id: 'f0ea936f-519a-4215-b613-ac7b33a1179c',
        name: 'EPHEC Woluwé',
        city: City(
          id: '16be4e3b-a034-4477-979a-f5bf4305467b',
          name: 'Brussels',
          country: Country(
            id: 'c25d9c35-8fa8-41b7-b6fb-c5579897942d',
            name: 'Belgium',
          ),
        ),
        latitude: 50.849823,
        longitude: 4.449186,
      ),
      reservationOptions: [
        ReservationOption(
          id: '837be53d-d6bd-41ee-89c5-d2e82d6829e2',
          name: 'Charge Card',
          description: 'Charge everywhere without limit and without supplement',
          day_price_euro_excl_vat: 20,
        ),
        ReservationOption(
          id: '8faab8e0-bfe3-4faa-9934-650da24d6297',
          name: 'Additional Driver',
          description: '',
          day_price_euro_excl_vat: 12,
        )
      ],
      dateTimeStart: DateTime(2022, 12, 12),
      dateTimeStop: DateTime(2022, 16, 12),
      total_price_euro_excl_vat: 1184.12,
      paid: true,
      returned: true,
      cancelled: false,
    ),
    Reservation(
      id: '7bba5a60-51bc-4d43-995b-599412791bb5',
      client: Client(
          id: '6806ef20-0493-4bf8-b364-747b82b05102',
          firstName: 'Gianluca',
          lastName: 'Lucchesi',
          phoneNumber: '0477123456',
          emailAddress: 'email@gmail.com',
          auth0Id: 'auth123'),
      car: Car(
        id: '8dc9e31b-323b-4597-996f-f1061527e021',
        brand: Brand(
          id: 'ad8dc659-4949-43d6-a929-77b4d9a33bc6',
          name: 'Hyundai',
        ),
        model: 'IONIQ 5 Long Range 2WD',
        seats: 5,
        doors: 5,
        year: 2021,
        horsepower: 204,
        wltp_range_km: 521,
        battery_capacity_kwh: 82,
        start_day_price_euro_excl_vat: 55,
        carOptions: [
          CarOption(
            id: '0af53a43-1cfb-4545-b9a2-eb105dc56820',
            name: 'GPS',
          ),
          CarOption(
            id: 'b120887b-6361-44a0-be67-d3c0d6f3f128',
            name: 'Adaptive Cruise Control',
          ),
          CarOption(
            id: 'bc394a6c-497c-4ac5-a925-9d01bac63b5b',
            name: 'Heated seats',
          ),
        ],
        image_url: 'assets/images/cars/HyundaiIoniq5.png',
      ),
      location: Location(
        id: 'f0ea936f-519a-4215-b613-ac7b33a1179c',
        name: 'EPHEC Woluwé',
        city: City(
          id: '16be4e3b-a034-4477-979a-f5bf4305467b',
          name: 'Brussels',
          country: Country(
            id: 'c25d9c35-8fa8-41b7-b6fb-c5579897942d',
            name: 'Belgium',
          ),
        ),
        latitude: 50.849823,
        longitude: 4.449186,
      ),
      reservationOptions: [
        ReservationOption(
          id: '837be53d-d6bd-41ee-89c5-d2e82d6829e2',
          name: 'Charge Card',
          description: 'Charge everywhere without limit and without supplement',
          day_price_euro_excl_vat: 20,
        ),
        ReservationOption(
          id: '8faab8e0-bfe3-4faa-9934-650da24d6297',
          name: 'Additional Driver',
          description: '',
          day_price_euro_excl_vat: 12,
        )
      ],
      dateTimeStart: DateTime(2022, 12, 12),
      dateTimeStop: DateTime(2022, 16, 12),
      total_price_euro_excl_vat: 920.63,
      paid: true,
      returned: false,
      cancelled: false,
    ),
    Reservation(
      id: 'a4b3dd21-7231-499d-8cc7-baf766920f8e',
      client: Client(
          id: '6806ef20-0493-4bf8-b364-747b82b05102',
          firstName: 'Gianluca',
          lastName: 'Lucchesi',
          phoneNumber: '0477123456',
          emailAddress: 'email@gmail.com',
          auth0Id: 'auth123'),
      car: Car(
        id: '8dc9e31b-323b-4597-996f-f1061527e021',
        brand: Brand(
          id: 'ad8dc659-4949-43d6-a929-77b4d9a33bc6',
          name: 'Mercedes-Benz',
        ),
        model: 'EQB 300 4MATIC',
        seats: 5,
        doors: 5,
        year: 2021,
        horsepower: 204,
        wltp_range_km: 521,
        battery_capacity_kwh: 82,
        start_day_price_euro_excl_vat: 55,
        carOptions: [
          CarOption(
            id: '0af53a43-1cfb-4545-b9a2-eb105dc56820',
            name: 'GPS',
          ),
          CarOption(
            id: 'b120887b-6361-44a0-be67-d3c0d6f3f128',
            name: 'Adaptive Cruise Control',
          ),
          CarOption(
            id: 'bc394a6c-497c-4ac5-a925-9d01bac63b5b',
            name: 'Heated seats',
          ),
        ],
        image_url: 'assets/images/cars/MercedesBenzEQB.png',
      ),
      location: Location(
        id: 'f0ea936f-519a-4215-b613-ac7b33a1179c',
        name: 'Berlin Brandenburg Airport Willy Brandt',
        city: City(
          id: '16be4e3b-a034-4477-979a-f5bf4305467b',
          name: 'Berlin',
          country: Country(
            id: 'c25d9c35-8fa8-41b7-b6fb-c5579897942d',
            name: 'Germany',
          ),
        ),
        latitude: 52.36434,
        longitude: 13.51061,
      ),
      reservationOptions: [
        ReservationOption(
          id: '837be53d-d6bd-41ee-89c5-d2e82d6829e2',
          name: 'Charge Card',
          description: 'Charge everywhere without limit and without supplement',
          day_price_euro_excl_vat: 20,
        ),
        ReservationOption(
          id: '8faab8e0-bfe3-4faa-9934-650da24d6297',
          name: 'Additional Driver',
          description: '',
          day_price_euro_excl_vat: 12,
        )
      ],
      dateTimeStart: DateTime(2022, 12, 12),
      dateTimeStop: DateTime(2022, 16, 12),
      total_price_euro_excl_vat: 1087.47,
      paid: true,
      returned: false,
      cancelled: true,
    ),
  ];

  List<Reservation> get reservationList {
    fetchReservations();
    return [..._reservationList];
  }

  List<Reservation> get activeReservationList {
    fetchReservations();
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
