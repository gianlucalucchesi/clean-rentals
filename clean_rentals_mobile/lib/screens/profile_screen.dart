import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/profile.dart';
import '../models/providers/auth0.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth0 = Provider.of<Auth0>(context);
    bool isBusy = auth0.isBusy;
    bool isLoggedIn = auth0.isLoggedIn;
    String errorMessage = auth0.errorMessage;
    String name = auth0.name;
    String picture = auth0.picture;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Profile(name, picture),
      ),
    );
  }
}
