import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

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
          const Center(child: ImageInput()),
        ],
      ),
    );
  }
}
