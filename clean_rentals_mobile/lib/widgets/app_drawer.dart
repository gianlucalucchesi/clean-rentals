import 'package:clean_rentals_mobile/screens/add_car_screen.dart';
import 'package:clean_rentals_mobile/screens/add_location_screen.dart';
import 'package:clean_rentals_mobile/screens/login_screen.dart';
import 'package:clean_rentals_mobile/screens/profile_screen.dart';
import 'package:clean_rentals_mobile/screens/reservation_details_screen.dart';
import 'package:clean_rentals_mobile/screens/reservations_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/auth0.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth0 = Provider.of<Auth0>(context);
    bool isLoggedIn = auth0.isLoggedIn;

    return Drawer(
      child: Column(children: [
        AppBar(
          title: Column(
            children: const [
              Text('Clean Rentals'),
              // TODO : admin panel only if user is admin
              Text(
                'Admin Panel',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          automaticallyImplyLeading: false, // will never add back button
        ),
        if (!isLoggedIn)
          ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName)),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text('All reservations'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ReservationsOverviewScreen.routeName),
          ),
        if (isLoggedIn) const Divider(),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add car'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AddCarScreen.routeName),
          ),
        if (isLoggedIn) const Divider(),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.add_location_alt),
            title: const Text('Add location'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(AddLocationScreen.routeName),
          ),
        if (isLoggedIn) const Divider(),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProfileScreen.routeName),
          ),
      ]),
    );
  }
}
