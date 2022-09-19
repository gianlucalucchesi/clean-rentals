// ignore_for_file: non_constant_identifier_names

class ReservationOption {
  final String id;
  final String name;
  final String? description;
  final double day_price_euro_excl_vat;

  ReservationOption(
      {required this.id,
      required this.name,
      this.description,
      required this.day_price_euro_excl_vat});

  factory ReservationOption.fromJson(Map<String, dynamic> json) {
    return ReservationOption(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      day_price_euro_excl_vat: json['day_price_euro_excl_vat'],
    );
  }
}
