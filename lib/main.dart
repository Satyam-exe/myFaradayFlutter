import 'package:app/constants/routes.dart';
import 'package:app/views/auth/log_in_view.dart';
import 'package:app/views/auth/sign_up.dart';
import 'package:app/views/logged_in_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        homeRoute: (context) => const MyHomePage(),
        signUpRoute: (context) => const SignUpView(),
        loggedInRoute: (context) => const LoggedInView(),
        logInRoute: (context) => const LogInView(),
      },
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SignUpView();
  }
}
