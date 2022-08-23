import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../models/providers/auth0.dart';
import '../widgets/app_drawer.dart';
import '../widgets/login.dart';
import '../widgets/profile.dart';

/// https://auth0.com/blog/get-started-with-flutter-authentication/
/// https://auth0.com/blog/flutter-authentication-authorization-with-auth0-part-1-adding-authentication-to-an-app/
const FlutterAppAuth appAuth = FlutterAppAuth();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

const AUTH0_DOMAIN = 'dev-qkw53hzi.eu.auth0.com';
const AUTH0_CLIENT_ID = 'EUjEN89wRH4dKpVqnKBHVIorYjaDVY9j';
const AUTH0_REDIRECT_URI = 'com.cleanrentals.mobile://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final auth0 = Provider.of<Auth0>(context);
    bool isBusy = auth0.isBusy;
    bool isLoggedIn = auth0.isLoggedIn;
    String errorMessage = auth0.errorMessage;
    String name = auth0.name;
    String picture = auth0.picture;

    Map<String, dynamic> parseIdToken(String? idToken) {
      final parts = idToken!.split(r'.');
      assert(parts.length == 3);

      return jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    }

    Future<Map<String, dynamic>> getUserDetails(String? accessToken) async {
      const url = 'https://$AUTH0_DOMAIN/userinfo';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get user details');
      }
    }

    Future<void> loginAction() async {
      auth0.setIsBusy(true);
      auth0.setErrorMessage('');

      // setState(() {
      //   errorMessage = '';
      // });

      try {
        final AuthorizationTokenResponse? result =
            await appAuth.authorizeAndExchangeCode(
          AuthorizationTokenRequest(AUTH0_CLIENT_ID, AUTH0_REDIRECT_URI,
              issuer: 'https://$AUTH0_DOMAIN',
              scopes: ['openid', 'profile', 'offline_access'],
              promptValues: ['login']),
        );

        if (result != null) {
          final idToken = parseIdToken(result.idToken);
          final profile = await getUserDetails(result.accessToken);

          await secureStorage.write(
              key: 'refresh_token', value: result.refreshToken);

          auth0.setIsBusy(false);
          auth0.setIsLoggedIn(true);
          auth0.setName(idToken['name']);
          auth0.setPicture(profile['picture']);

          // setState(() {
          //   name = idToken['name'];
          //   picture = profile['picture'];
          // });
        }
      } catch (e, s) {
        print('login error: $e - stack: $s');

        auth0.setIsBusy(false);
        auth0.setIsLoggedIn(false);
        auth0.setErrorMessage(e.toString());

        // setState(() {
        //   errorMessage = e.toString();
        // });
      }
    }

    // void logoutAction() async {
    //   await secureStorage.delete(key: 'refresh_token');
    //   auth0.logout();
    // }

    void initAction() async {
      final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
      if (storedRefreshToken == null) return;

      auth0.setIsBusy(true);

      try {
        final response = await appAuth.token(TokenRequest(
          AUTH0_CLIENT_ID,
          AUTH0_REDIRECT_URI,
          issuer: AUTH0_ISSUER,
          refreshToken: storedRefreshToken,
        ));

        final idToken = parseIdToken(response!.idToken);
        final profile = await getUserDetails(response.accessToken);

        secureStorage.write(key: 'refresh_token', value: response.refreshToken);

        auth0.setIsBusy(false);
        auth0.setIsLoggedIn(true);
        auth0.setName(idToken['name']);
        auth0.setPicture(profile['picture']);

        // setState(() {
        //   name = idToken['name'];
        //   picture = profile['picture'];
        // });
      } catch (e, s) {
        print('error on refresh token: $e - stack: $s');
        auth0.logout();
      }
    }

    @override
    void initState() {
      initAction();
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: isBusy
            ? const CircularProgressIndicator()
            : !isLoggedIn
                ? Login(loginAction, errorMessage)
                : null,
      ),
    );
  }
}
