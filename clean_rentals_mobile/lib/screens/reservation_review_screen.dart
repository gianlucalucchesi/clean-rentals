import 'package:flutter/material.dart';

import '../screens/reservations_overview_screen.dart';
import '../services/reservation_service.dart';
import '../widgets/image_input.dart';

class ReservationReviewScreen extends StatefulWidget {
  static const routeName = '/reservation-review';

  const ReservationReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReservationReviewScreen> createState() =>
      _ReservationReviewScreenState();
}

class _ReservationReviewScreenState extends State<ReservationReviewScreen> {
  final reviewTextController = TextEditingController();

  @override
  void dispose() {
    reviewTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reservationId = ModalRoute.of(context)?.settings.arguments as String;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                      controller: reviewTextController,
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
                    bool succes = await ReservationService.finalizeReservation(
                        reservationId, reviewTextController.text);
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
