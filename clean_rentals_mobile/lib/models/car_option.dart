class CarOption {
  final String id;
  final String name;

  CarOption({required this.id, required this.name});

  factory CarOption.fromJson(Map<String, dynamic> json) {
    return CarOption(
      id: json['id'],
      name: json['name'],
    );
  }
}
