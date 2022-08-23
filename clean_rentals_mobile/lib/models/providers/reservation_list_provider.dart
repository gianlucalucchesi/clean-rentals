import 'package:clean_rentals_mobile/models/country.dart';
import 'package:clean_rentals_mobile/models/reservation.dart';
import 'package:clean_rentals_mobile/models/reservation_option.dart';
import 'package:flutter/material.dart';

import '../brand.dart';
import '../car.dart';
import '../car_option.dart';
import '../city.dart';
import '../client.dart';
import '../location.dart';

class ReservationListProvider with ChangeNotifier {
  final List<Reservation> _reservationList = [
    Reservation(
      id: '1',
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
        carOptions: CarOption(
          id: '0af53a43-1cfb-4545-b9a2-eb105dc56820',
          name: 'GPS',
        ),
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
        )
      ],
      dateTimeStart: DateTime(2022, 12, 12),
      dateTimeStop: DateTime(2022, 16, 12),
      total_price_euro_excl_vat: 1184.12,
    ),
  ];

  List<Reservation> get reservationList {
    return [..._reservationList];
  }
}
