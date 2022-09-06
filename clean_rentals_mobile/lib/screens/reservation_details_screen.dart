import 'package:clean_rentals_mobile/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import './reservation_review_screen.dart';
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
    String locationImageUrl = LocationHelper.generateLocationPreviewImage(
        latitude: reservation.location.latitude,
        longitude: reservation.location.longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
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
              // white space
              height: 10,
            ),
            Text(
              '${reservation.car.brand.name} ${reservation.car.model}',
              style: const TextStyle(color: Colors.green, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "RESERVATION INFORMATION",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2.5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // align left
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "Reference: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reservation.id),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "Pickup: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy hh:mm')
                              .format(reservation.dateTimeStart),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "Return: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reservation.dateTimeStop != null
                            ? DateFormat('dd/MM/yyyy hh:mm')
                                .format(reservation.dateTimeStop!)
                            : "Not yet returned"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              // white space
              height: 10,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // align left
                children: [
                  const Text(
                    "OPTIONS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...reservation.reservationOptions!
                      .map((option) => Text('- ${option.name}'))
                      .toList(),
                ],
              ),
            ),
            const SizedBox(
              // white space
              height: 10,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              width: double.infinity,
              child: Row(
                children: [
                  const Text(
                    "Total price: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '€ ${(reservation.total_price_euro_excl_vat * 1.21).toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 7.5,
            ),
            const Text(
              "CLIENT INFORMATION",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "Client ID: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reservation.client.auth0Id),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "First Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reservation.client.firstName),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "Last Name: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reservation.client.lastName),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 7.5,
            ),
            const Text(
              "CAR INFORMATION",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "Brand: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reservation.car.brand.name),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "Model: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reservation.car.model),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              // white space
              height: 10,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // align left
                children: [
                  const Text(
                    "OPTIONS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (reservation.car.carOptions!.isEmpty)
                    const Text(
                      "Incomplete option list",
                      style: TextStyle(color: Colors.grey),
                    )
                  else
                    ...reservation.car.carOptions!
                        .map((option) => Text('- ${option.name}'))
                        .toList(),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 7.5,
            ),
            const Text(
              "LOCATION INFORMATION",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              width: double.infinity,
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align top of row cell
                children: [
                  const Text(
                    "Car location: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                        '${reservation.location.name} (${reservation.location.city.name}, ${reservation.location.city.country.name})'),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 150,
                width: 300,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.green)),
                  child: Image.network(
                    locationImageUrl,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 40),
                            primary: Colors.red),
                        onPressed: () {}, // FIXME update to cancel reservation
                        child: const Text("Cancel"),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(300, 40),
                        ),
                        onPressed: () => Navigator.of(context).pushNamed(
                          ReservationReviewScreen.routeName,
                          arguments: reservation.id,
                        ),
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
