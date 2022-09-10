import 'package:clean_rentals_mobile/models/reservation.dart';
import 'package:clean_rentals_mobile/screens/reservations_overview_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

class ReservationReviewScreen extends StatelessWidget {
  static const routeName = '/reservation-review';

  const ReservationReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservationId = ModalRoute.of(context)?.settings.arguments as String;
    var reviewText = 'Hello, world!';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Review"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Findings',
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                ],
              ),
            ),
            const Divider(),
            const Center(
              child: ImageInput(),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  bool succes = await Reservation.finalizeReservation(
                      reservationId, reviewText);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context, succes),
                  );
                },
                child: const Icon(Icons.check_circle_outline_sharp),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, bool success) {
    return AlertDialog(
      title: const Text('Clean Rentals'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          success
              ? const Text("Reservation finalized")
              : const Text("Could not finalize reservation"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            success
                ? Navigator.of(context)
                    .pushReplacementNamed(ReservationsOverviewScreen.routeName)
                : Navigator.of(context).pop();
          },
          child: success ? const Text('Continue') : const Text("Go back"),
        ),
      ],
    );
  }
}
