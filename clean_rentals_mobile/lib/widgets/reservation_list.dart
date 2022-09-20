import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reservation.dart';
import '../widgets/reservation_list_item.dart';

class ReservationList extends StatelessWidget {
  final bool showOnlyActiveReservations;
  final List<Reservation> reservationData;

  const ReservationList(
      {super.key,
      required this.showOnlyActiveReservations,
      required this.reservationData});

  @override
  Widget build(BuildContext context) {
    return reservationData.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: reservationData.length,
            itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: reservationData[i],
              child: const ReservationListItem(),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 600,
                child: Center(
                  child: Text(
                    'No reservations',
                    style: TextStyle(fontSize: 30, color: Colors.blueGrey),
                  ),
                ),
              );
            });
  }
}
