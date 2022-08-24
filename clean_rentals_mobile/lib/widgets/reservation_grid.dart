import 'package:clean_rentals_mobile/widgets/reservation_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/reservation_list_provider.dart';

class ReservationGrid extends StatelessWidget {
  const ReservationGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservationData =
        Provider.of<ReservationListProvider>(context).reservationList;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: reservationData.length,
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: reservationData[i],
        child: const ReservationItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Column count
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10, // Spacing between columns
        mainAxisSpacing: 10, // Spacing between rows
      ),
    );
  }
}
