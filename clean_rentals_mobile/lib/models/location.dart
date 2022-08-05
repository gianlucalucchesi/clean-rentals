import 'city.dart';

class Location {
  Location({
    required this.id,
    required this.name,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final City city;
  final double latitude;
  final double longitude;
}
