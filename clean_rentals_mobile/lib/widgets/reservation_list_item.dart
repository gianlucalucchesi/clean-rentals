import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/reservation.dart';
import '../screens/reservation_details_screen.dart';

class ReservationListItem extends StatelessWidget {
  const ReservationListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final reservation = Provider.of<Reservation>(context);

    return Center(
      child: Card(
        child: InkWell(
          onTap: () => {
            Navigator.of(context).pushNamed(
              ReservationDetailScreen.routeName,
              arguments: reservation.id,
            ),
          },
          child: SizedBox(
            width: double.infinity,
            height: 80,
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 125,
                  child: Image(
                    image: AssetImage(reservation.car.image_url),
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${reservation.car.brand.name} ${reservation.car.model}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${DateFormat('dd/MM/yyyy').format(reservation.dateTimeStart)} - ${DateFormat('dd/MM/yyyy').format(reservation.dateTimeStop)}',
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '€ ${(reservation.total_price_euro_excl_vat * 1.21).toStringAsFixed(2)}',
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          reservation.client.emailAddress,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
