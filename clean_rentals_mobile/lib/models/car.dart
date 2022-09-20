import '../models/car_option.dart';
import 'brand.dart';

class Car {
  final String id;
  final Brand brand;
  final String model;
  final int seats, doors, year, horsepower, wltpRangeKm;
  final num batteryCapacityKwh, startDayPriceEuroExclVat;
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
    required this.wltpRangeKm,
    required this.batteryCapacityKwh,
    required this.startDayPriceEuroExclVat,
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
      wltpRangeKm: json['wltp_range_km'],
      batteryCapacityKwh: json['battery_capacity_kwh'],
      startDayPriceEuroExclVat: json['start_day_price_euro_excl_vat'],
      carOptions: carOptionsList,
      image_url: json['image_url'],
    );
  }
}
