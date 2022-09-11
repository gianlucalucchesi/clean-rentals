import 'package:clean_rentals_mobile/widgets/reservation_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/reservation_list_provider.dart';

class ReservationList extends StatelessWidget {
  final bool showOnlyActiveReservations;

  ReservationList({super.key, required this.showOnlyActiveReservations});

  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationListProvider>(context);

    final reservationData = showOnlyActiveReservations
        ? reservationProvider.activeReservationList
        : reservationProvider.reservationList;

    return reservationData.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: reservationData.length,
            itemBuilder: (context, i) => ChangeNotifierProvider.value(
              value: reservationData[i],
              child: const ReservationListItem(),
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
