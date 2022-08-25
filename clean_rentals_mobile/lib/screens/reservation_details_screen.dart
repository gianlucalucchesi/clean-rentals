import 'package:clean_rentals_mobile/screens/reservation_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/reservation_list_provider.dart';

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
    final reservation =
        Provider.of<ReservationListProvider>(context, listen: false)
            .findById(reservationId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${reservation.car.brand.name} ${reservation.car.model}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(reservation.car.image_url),
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '€${reservation.total_price_euro_excl_vat}',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: const Text("description"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(
                ReservationReviewScreen.routeName,
                arguments: reservation.id,
              ),
              child: const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}
