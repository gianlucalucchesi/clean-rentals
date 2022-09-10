import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'reservation_grid_item.dart';
import '../models/providers/reservation_list_provider.dart';

class ReservationGrid extends StatelessWidget {
  final bool showOnlyActiveReservations;

  const ReservationGrid({Key? key, required this.showOnlyActiveReservations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationListProvider>(context);

    final reservationData = showOnlyActiveReservations
        ? reservationProvider.activeReservationList
        : reservationProvider.reservationList;

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
        : const Center(
            child: Text(
              'No reservations',
              style: TextStyle(fontSize: 30, color: Colors.blueGrey),
            ),
          );
  }
}
