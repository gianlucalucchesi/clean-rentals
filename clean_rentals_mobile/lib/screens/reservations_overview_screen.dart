import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/reservation_item.dart';

class ReservationsOverviewScreen extends StatefulWidget {
  static const routeName = '/reservations';

  const ReservationsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsOverviewScreen> createState() =>
      _ReservationsOverviewScreen();
}

class _ReservationsOverviewScreen extends State<ReservationsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ReservationItem(),
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
