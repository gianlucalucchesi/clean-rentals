import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reservation.dart';
import 'reservation_grid_item.dart';

class ReservationGrid extends StatelessWidget {
  final bool showOnlyActiveReservations;
  final List<Reservation> reservationData;

  const ReservationGrid({
    Key? key,
    required this.showOnlyActiveReservations,
    required this.reservationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return reservationData.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: reservationData.length,
            itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: reservationData[i],
              child: const ReservationGridItem(),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Column count
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10, // Spacing between columns
              mainAxisSpacing: 10, // Spacing between rows
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
