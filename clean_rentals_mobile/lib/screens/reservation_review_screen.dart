import 'package:clean_rentals_mobile/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
            child: const Icon(Icons.camera_alt),
          ),
          const ImageInput(),
        ],
      ),
    );
  }
}
