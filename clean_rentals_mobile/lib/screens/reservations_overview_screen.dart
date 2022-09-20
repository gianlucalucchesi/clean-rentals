import 'package:flutter/material.dart';

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
  bool _showGridView = true;

  @override
  Widget build(BuildContext context) {
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
          ? ReservationGrid(
              showOnlyActiveReservations: _showOnlyActive,
            )
          : ReservationList(showOnlyActiveReservations: _showOnlyActive),
      drawer: const AppDrawer(),
    );
  }
}
