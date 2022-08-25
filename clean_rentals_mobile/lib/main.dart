import 'package:clean_rentals_mobile/screens/reservation_details_screen.dart';
import 'package:clean_rentals_mobile/screens/reservation_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/profile_screen.dart';
import './screens/add_car_screen.dart';
import './screens/add_location_screen.dart';
import 'screens/login_screen.dart';
import 'screens/reservations_overview_screen.dart';

import './models/providers/auth0.dart';
import './models/providers/reservation_list_provider.dart';

void main() {
  // https://stackoverflow.com/questions/57405228/provider-in-init-method-of-main-dart
  // MultiProviders should have come in CleanRentals app but Auth0 live data needed
  // in that class so the provider should be initialized at a higher level
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReservationListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth0(),
        ),
      ],
      child: Consumer<Auth0>(builder: (context, auth0, _) {
        return const CleanRentals(Auth0);
      }),
    ),
  );
}

class CleanRentals extends StatelessWidget {
  const CleanRentals(var context);

  @override
  Widget build(BuildContext context) {
    final auth0 = Provider.of<Auth0>(context);
    bool isLoggedIn = auth0.isLoggedIn;

    return MaterialApp(
      title: 'Clean Rentals',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:
          isLoggedIn ? const ReservationsOverviewScreen() : const LoginScreen(),
      routes: {
        ReservationsOverviewScreen.routeName: (context) =>
            const ReservationsOverviewScreen(),
        AddCarScreen.routeName: (context) => const AddCarScreen(),
        AddLocationScreen.routeName: (context) => const AddLocationScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        ReservationDetailScreen.routeName: (context) =>
            const ReservationDetailScreen(),
        ReservationReviewScreen.routeName: (context) =>
            const ReservationReviewScreen(),
      },
    );
  }
}
