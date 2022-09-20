class ReservationOption {
  final String id;
  final String name;
  final String? description;
  final double dayPriceEuroExclVat;

  ReservationOption(
      {required this.id,
      required this.name,
      this.description,
      required this.dayPriceEuroExclVat});

  factory ReservationOption.fromJson(Map<String, dynamic> json) {
    return ReservationOption(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      dayPriceEuroExclVat: json['day_price_euro_excl_vat'],
    );
  }
}
