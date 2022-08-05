class Client {
  Client(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.emailAddress,
      required this.auth0Id});

  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String emailAddress;
  final String auth0Id;
}
