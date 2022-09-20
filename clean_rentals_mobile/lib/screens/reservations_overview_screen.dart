import 'package:clean_rentals_mobile/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/reservation_list_provider.dart';
import '../widgets/reservation_list.dart';
import '../widgets/app_drawer.dart';
import '../widgets/reservation_grid.dart';

enum FilterOptions {
  active,
  all,
}

class ReservationsOverviewScreen extends StatefulWidget {
  static const routeName = '/reservations';

  const ReservationsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ReservationsOverviewScreen> createState() =>
      _ReservationsOverviewScreen();
}

class _ReservationsOverviewScreen extends State<ReservationsOverviewScreen> {
  bool _showOnlyActive = true;
  bool _showGridView = false;

  @override
  Widget build(BuildContext context) {
    final reservationProvider = Provider.of<ReservationListProvider>(context);

    var reservationData = _showOnlyActive
        ? reservationProvider.activeReservationList
        : reservationProvider.reservationList;

    Future<void> _refresh() async {
      setState(() {
        reservationData = _showOnlyActive
            ? reservationProvider.activeReservationList
            : reservationProvider.reservationList;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservations"),
        actions: <Widget>[
          IconButton(
            onPressed: () => {setState(() => _showGridView = !_showGridView)},
            icon: _showGridView
                ? const Icon(Icons.view_list)
                : const Icon(Icons.grid_view),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.active) {
                  _showOnlyActive = true;
                } else {
                  _showOnlyActive = false;
                }
              });
            },
            icon: const Icon(
              Icons.filter_alt,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.active,
                child: Text('Active reservations'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('All reservations'),
              ),
            ],
          ),
        ],
      ),
      body: _showGridView
          ? RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ReservationGrid(
                showOnlyActiveReservations: _showOnlyActive,
                reservationData: reservationData,
              ),
            )
          : RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ReservationList(
                showOnlyActiveReservations: _showOnlyActive,
                reservationData: reservationData,
              ),
            ),
      drawer: const AppDrawer(),
    );
  }
}
