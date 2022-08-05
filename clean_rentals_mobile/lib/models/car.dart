import 'package:clean_rentals_mobile/models/car-option.dart';

import 'brand.dart';

class Car {
  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.seats,
    required this.doors,
    required this.year,
    required this.horsepower,
    required this.wltp_range_km,
    required this.battery_capacity_kwh,
    required this.start_day_price_euro_excl_vat,
    this.carOptions,
    required this.image_url,
  });

  final String id;
  final Brand brand;
  final String model;
  final int seats;
  final int doors;
  final int year;
  final int horsepower;
  final int wltp_range_km;
  final int battery_capacity_kwh;
  final int start_day_price_euro_excl_vat;
  final CarOption? carOptions;
  final String image_url;
}
