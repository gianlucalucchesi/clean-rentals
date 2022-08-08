import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// https://auth0.com/blog/get-started-with-flutter-authentication/
/// https://auth0.com/blog/flutter-authentication-authorization-with-auth0-part-1-adding-authentication-to-an-app/

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------

const AUTH0_DOMAIN = 'dev-qkw53hzi.eu.auth0.com';
const AUTH0_CLIENT_ID = 'EUjEN89wRH4dKpVqnKBHVIorYjaDVY9j';
const AUTH0_REDIRECT_URI = 'com.cleanrentals.mobile://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

/// -----------------------------------
///           Profile Widget
/// -----------------------------------

class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  Widget build(BuildContext context) {
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
            logoutAction();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}

/// -----------------------------------
///            Login Widget
/// -----------------------------------

class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => loginAction(),
          child: const Text('Login'),
        ),
        //Text(loginError),
      ],
    );
  }

  print(loginError) {
    print(loginError);
  }
}

/// -----------------------------------
///                 App
/// -----------------------------------

class Auth0 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

/// -----------------------------------
///              App State
/// -----------------------------------

class _MyAppState extends State<Auth0> {
  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  late String name;
  late String picture;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => loginAction(),
      child: Text('Login'),
    );

    // @override
    // Widget build(BuildContext context) {
    //   return MaterialApp(
    //     title: 'Clean Rentals',
    //     home: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Clean Rentals'),
    //         backgroundColor: Colors.green,
    //         // leading:
    //         actions: <Widget>[
    //           Padding(
    //               padding: const EdgeInsets.only(right: 20.0),
    //               child: GestureDetector(
    //                 onTap: () {},
    //                 child: const Icon(
    //                   Icons.search,
    //                   size: 26.0,
    //                 ),
    //               )),
    //           Padding(
    //               padding: EdgeInsets.only(right: 20.0),
    //               child: GestureDetector(
    //                 onTap: () {},
    //                 child: Icon(Icons.more_vert),
    //               )),
    //           TextButton(
    //             onPressed: () => loginAction(),
    //             child: const Text(
    //               "Login",
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ],
    //       ),
    //       body: Center(
    //         child: isBusy
    //             ? const CircularProgressIndicator()
    //             : isLoggedIn
    //                 ? Profile(logoutAction, name, picture)
    //                 : Login(loginAction, errorMessage),
    //       ),
    //     ),
    //   );
  }

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
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

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

        setState(() {
          isBusy = false;
          isLoggedIn = true;
          name = idToken['name'];
          picture = profile['picture'];
        });
      }
    } catch (e, s) {
      print('login error: $e - stack: $s');

      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  void logoutAction() async {
    await secureStorage.delete(key: 'refresh_token');
    setState(() {
      isLoggedIn = false;
      isBusy = false;
    });
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    if (storedRefreshToken == null) return;

    setState(() {
      isBusy = true;
    });

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

      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        picture = profile['picture'];
      });
    } catch (e, s) {
      print('error on refresh token: $e - stack: $s');
      logoutAction();
    }
  }
}
