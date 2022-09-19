// ignore_for_file: non_constant_identifier_names

import 'package:clean_rentals_mobile/models/car_option.dart';

import 'brand.dart';

class Car {
  final String id;
  final Brand brand;
  final String model;
  final int seats, doors, year, horsepower, wltp_range_km;
  final num battery_capacity_kwh, start_day_price_euro_excl_vat;
  final List<CarOption>? carOptions;
  final String image_url;

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

  factory Car.fromJson(Map<String, dynamic> json) {
    var list = json['carOptions'] as List;
    List<CarOption> carOptionsList =
        list.map((i) => CarOption.fromJson(i)).toList();

    return Car(
      id: json['id'],
      brand: json['brand'] = Brand.fromJson(json['brand']),
      model: json['model'],
      seats: json['seats'],
      doors: json['doors'],
      year: json['year'],
      horsepower: json['horsepower'],
      wltp_range_km: json['wltp_range_km'],
      battery_capacity_kwh: json['battery_capacity_kwh'],
      start_day_price_euro_excl_vat: json['start_day_price_euro_excl_vat'],
      carOptions: carOptionsList,
      image_url: json['image_url'],
    );
  }
}
