import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/reservations_overview_screen.dart';

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
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
          automaticallyImplyLeading: false, // will never add back button
        ),
        if (isLoggedIn)
          const SizedBox(
            height: 20,
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
            title: const Text(
              'All reservations',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ReservationsOverviewScreen.routeName),
          ),
        if (isLoggedIn) const Divider(),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProfileScreen.routeName),
          ),
      ]),
    );
  }
}
