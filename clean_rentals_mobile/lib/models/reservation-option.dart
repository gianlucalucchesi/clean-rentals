class ReservationOption {
  ReservationOption(
      {required this.id,
      required this.name,
      required this.description,
      required this.day_price_euro_excl_vat});

  final String id;
  final String name;
  final String description;
  final int day_price_euro_excl_vat;
}
