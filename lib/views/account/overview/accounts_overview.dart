import 'dart:developer';

import 'package:app/constants/accounts/overview/overview_constants.dart';
import 'package:app/constants/routes.dart';
import 'package:app/models/auth/auth_user.dart';
import 'package:app/models/profile/profile.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/services/profile/profile_service.dart';
import 'package:app/utilities/dialogs/log_out_dialog.dart';
import 'package:flutter/material.dart';

class AccountsOverviewView extends StatefulWidget {
  const AccountsOverviewView({super.key});

  @override
  State<AccountsOverviewView> createState() => _AccountsOverviewViewState();
}

class _AccountsOverviewViewState extends State<AccountsOverviewView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserAndProfile(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            Profile profile = snapshot.data!['profile'];
            AuthUser user = snapshot.data!['user'];
            log(snapshot.data.toString());
            return ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.resolveWith(
                              (states) => const Size(90, 40)),
                          foregroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.red[900]!)),
                      child: Row(
                        children: const [
                          Text('Logout'),
                          Icon(Icons.logout_sharp)
                        ],
                      ),
                      onPressed: () async {
                        bool toLogOut = await showLogOutDialog(context);
                        if (toLogOut) {
                          await AuthService().logOut();
                          if (!mounted) return;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              logInRoute, (route) => false);
                        } else {
                          return;
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white70,
                            minRadius: 60.0,
                            child: CircleAvatar(
                              radius: 75.0,
                              backgroundImage: NetworkImage(
                                'http://localhost:8000${profile.profilePicture}',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 60),
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.shopping_cart_sharp,
                                  size: 40,
                                ),
                                Text('Requests Made:'),
                                Text('0'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.timeline_sharp,
                                  size: 40,
                                ),
                                const Text('Customer Since:'),
                                Text(
                                  '${user.signedUp.day} ${monthAbbr[user.signedUp.month]} ${user.signedUp.year}',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<Map<String, dynamic>> _getUserAndProfile() async {
    Profile profile = await ProfileService().currentProfile;
    AuthUser user = await AuthService().currentUser;
    return {
      'profile': profile,
      'user': user,
    };
  }
}
