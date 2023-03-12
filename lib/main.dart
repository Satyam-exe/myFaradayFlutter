import 'dart:developer';

import 'package:app/constants/routes.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/services/crud/crud_service.dart';
import 'package:app/views/auth/reset_password_view.dart';
import 'package:app/views/auth/log_in_view.dart';
import 'package:app/views/auth/sign_up.dart';
import 'package:app/views/home/logged_in_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartUpView(),
      routes: {
        homeRoute: (context) => const StartUpView(),
        signUpRoute: (context) => const SignUpView(),
        loggedInRoute: (context) => const LoggedInView(),
        logInRoute: (context) => const LogInView(),
        resetPasswordRoute: (context) => const ResetPasswordView(),
      },
    ),
  );
}

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: CRUDService().doesDatabaseExist(),
        builder: (BuildContext context, AsyncSnapshot<bool> dbSnapshot) {
          if (dbSnapshot.connectionState == ConnectionState.waiting ||
              dbSnapshot.connectionState == ConnectionState.none) {
            log('DBConnection state is waiting or none');
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black54,
              ),
            );
          } else if (!dbSnapshot.hasData || dbSnapshot.data == false) {
            log('no data in db or doesnt exist');
            return const LogInView();
          } else {
            log('db exists');
            return FutureBuilder<bool>(
              future: MobileTokenAuthService().isTokenValid(),
              builder: (context, tokenSnapshot) {
                if (tokenSnapshot.connectionState == ConnectionState.waiting) {
                  log('TokenConnection state is waiting or none');
                  return const Center(child: CircularProgressIndicator());
                } else if (!tokenSnapshot.hasData ||
                    tokenSnapshot.data == false) {
                  log('No data or token isnt valid');
                  Future(() => AuthService().logOut());
                  return const LogInView();
                } else {
                  log('Return loggedinview');
                  return const LoggedInView();
                }
              },
            );
          }
        },
      ),
    );
  }
}
