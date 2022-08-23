import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final bool isLoggedIn = false;

  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ]),
    );
  }
}
