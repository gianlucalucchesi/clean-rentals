import 'city.dart';

class Location {
  final String id;
  final String name;
  final City city;
  final double latitude;
  final double longitude;

  Location({
    required this.id,
    required this.name,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      city: json['city'] = City.fromJson(json['city']),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
