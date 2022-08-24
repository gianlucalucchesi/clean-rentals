import 'package:flutter/material.dart';

class ReservationDetailScreen extends StatefulWidget {
  static const routeName = '/reservation-details';

  const ReservationDetailScreen({Key? key}) : super(key: key);

  @override
  State<ReservationDetailScreen> createState() => _ReservationDetailScreen();
}

class _ReservationDetailScreen extends State<ReservationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final reservationId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(reservationId),
      ),
    );
  }
}
