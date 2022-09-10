import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/reservations_overview_screen.dart';
import 'screens/reservation_details_screen.dart';
import 'screens/reservation_review_screen.dart';

import 'models/providers/auth0.dart';
import 'models/providers/reservation_list_provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  // MultiProvider should be initialized in runApp()
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
      child: Consumer<Auth0>(
        builder: (context, auth0, _) {
          return const CleanRentals(context: Auth0);
        },
      ),
    ),
  );
}

class CleanRentals extends StatelessWidget {
  const CleanRentals({Key? key, var context}) : super(key: key);

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
        LoginScreen.routeName: (context) => const LoginScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        ReservationDetailScreen.routeName: (context) =>
            const ReservationDetailScreen(),
        ReservationReviewScreen.routeName: (context) =>
            const ReservationReviewScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

/*
Fix for HandshakeException in HTTP calls
https://stackoverflow.com/a/61312927/10470183
MyHttpOverrides called in main method.
*/
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
