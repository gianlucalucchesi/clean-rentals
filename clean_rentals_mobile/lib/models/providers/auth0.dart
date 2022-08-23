import 'package:flutter/material.dart';

class Auth0 with ChangeNotifier {
  static const AUTH0_DOMAIN = 'dev-qkw53hzi.eu.auth0.com';
  static const AUTH0_CLIENT_ID = 'EUjEN89wRH4dKpVqnKBHVIorYjaDVY9j';
  static const AUTH0_REDIRECT_URI = 'com.cleanrentals.mobile://login-callback';
  static const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';
}
