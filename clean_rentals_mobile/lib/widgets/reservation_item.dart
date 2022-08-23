import 'package:clean_rentals_mobile/models/providers/reservation_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reservation = Provider.of<ReservationListProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
    );
  }
}
