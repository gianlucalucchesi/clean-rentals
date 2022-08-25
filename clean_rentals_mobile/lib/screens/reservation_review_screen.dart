import 'package:flutter/material.dart';

class ReservationReviewScreen extends StatelessWidget {
  static const routeName = '/reservation-review';

  const ReservationReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservationId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Review"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Icon(Icons.check_circle_outline_sharp),
          )
        ],
      ),
    );
  }
}
