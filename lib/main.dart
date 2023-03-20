import 'dart:developer';

import 'package:app/constants/routes.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/services/crud/crud_service.dart';
import 'package:app/views/account/account_view.dart';
import 'package:app/views/account/overview/accounts_overview.dart';
import 'package:app/views/auth/log_in_view.dart';
import 'package:app/views/auth/reset_password_view.dart';
import 'package:app/views/auth/sign_up.dart';
import 'package:app/views/home/home_view.dart';
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
        signUpRoute: (context) => const SignUpView(),
        loggedInRoute: (context) => const HomeView(),
        logInRoute: (context) => const LogInView(),
        resetPasswordRoute: (context) => const ResetPasswordView(),
        homeRoute: (context) => const HomeView(),
        accountRoute: (context) => const AccountView(),
        accountOverviewRoute: (context) => const AccountsOverviewView(),
      },
    ),
  );
}

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkDatabaseAndToken(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!) {
            return const HomeView();
          } else {
            return const LogInView();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<bool> _checkDatabaseAndToken() async {
    bool doesDatabaseExist = await CRUDService().doesDatabaseExist();

    if (!doesDatabaseExist) {
      log('db does not exist');
      return false;
    }

    bool isTokenValid = await MobileTokenAuthService().isTokenValid();

    if (!isTokenValid) {
      await AuthService().logOut();
      log('token invalid');
      return false;
    }

    await CRUDService().updateDbOnStartUp();

    return true;
  }
}
