import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/providers/auth0.dart';

class Profile extends StatelessWidget {
  final String name;
  final String picture;

  const Profile(this.name, this.picture);

  @override
  Widget build(BuildContext context) {
    final auth0 = Provider.of<Auth0>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4.0),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(picture),
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        Text('Name: $name'),
        const SizedBox(height: 48.0),
        ElevatedButton(
          onPressed: () {
            auth0.logout();
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
