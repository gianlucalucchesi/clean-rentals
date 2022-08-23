import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/add_car_screen.dart';
import './screens/add_location_screen.dart';
import './models/providers/reservation_list_provider.dart';
import 'screens/login_screen.dart';
import 'screens/reservations_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn = false;

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReservationListProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Clean Rentals',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: isLoggedIn
            ? const ReservationsOverviewScreen()
            : const LoginScreen(),
        routes: {
          ReservationsOverviewScreen.routeName: (context) =>
              const ReservationsOverviewScreen(),
          AddCarScreen.routeName: (context) => const AddCarScreen(),
          AddLocationScreen.routeName: (context) => const AddLocationScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
        },
      ),
    );
  }
}
