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
          title: const Text('Clean Rentals'),
          automaticallyImplyLeading: false, // will never add back button
        ),
        if (!isLoggedIn)
          ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Login"),
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed('/login')),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.car_rental),
            title: const Text('All reservations'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed('/reservations'),
          ),
        if (isLoggedIn) const Divider(),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add car'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/add-car'),
          ),
        if (isLoggedIn) const Divider(),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.add_location_alt),
            title: const Text('Add location'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed('/add-location'),
          ),
        if (isLoggedIn) const Divider(),
        if (isLoggedIn)
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/profile'),
          ),
      ]),
    );
  }
}
