import 'country.dart';

class City {
  final String id;
  final String name;
  final Country country;

  City({required this.id, required this.name, required this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country: json['country'] = Country.fromJson(json['country']),
    );
  }
}
