import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../services/reservation_service.dart';
import '../helpers/location_helper.dart';
import '../screens/reservations_overview_screen.dart';
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
        latitude: reservation.location.latitude as double,
        longitude: reservation.location.longitude as double);

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
                        reservation.id.length > 8
                            ? Text(reservation.id.substring(0, 8))
                            : Text(reservation.id),
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
                          DateFormat('dd/MM/yyyy hh:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  reservation.dateTimeStart)),
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
                        Text(
                          DateFormat('dd/MM/yyyy hh:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  reservation.dateTimeStop)),
                        ),
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
                        Text(reservation.client.firstName ?? ''),
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
                        Text(reservation.client.lastName ?? ''),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      children: [
                        const Text(
                          "E-mail: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(reservation.client.emailAddress),
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
            if (!reservation.returned && !reservation.cancelled)
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(300, 40),
                              backgroundColor: Colors.red),
                          onPressed: () async {
                            bool succes =
                                await ReservationService.cancelReservation(
                                    reservationId);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context, succes),
                            );
                          },
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

  Widget _buildPopupDialog(BuildContext context, bool success) {
    return AlertDialog(
      title: const Text('Clean Rentals'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          success
              ? const Text("Reservation cancelled")
              : const Text("Could not cancel reservation"),
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
