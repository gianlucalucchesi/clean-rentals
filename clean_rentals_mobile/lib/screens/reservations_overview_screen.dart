import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/reservation_grid.dart';

class ReservationsOverviewScreen extends StatefulWidget {
  static const routeName = '/reservations';

  const ReservationsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsOverviewScreen> createState() =>
      _ReservationsOverviewScreen();
}

// TODO: filter on All/Current/Future reservations
class _ReservationsOverviewScreen extends State<ReservationsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservations"),
      ),
      body: const ReservationGrid(),
      drawer: const AppDrawer(),
    );
  }
}
