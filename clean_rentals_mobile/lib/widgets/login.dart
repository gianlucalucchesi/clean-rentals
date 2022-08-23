import 'package:flutter/material.dart';

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
