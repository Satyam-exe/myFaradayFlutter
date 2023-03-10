import 'package:app/constants/routes.dart';
import 'package:app/enums/menu_action.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/utilities/dialogs/log_out_dialog.dart';
import 'package:flutter/material.dart';

class LoggedInView extends StatefulWidget {
  const LoggedInView({super.key});

  @override
  State<LoggedInView> createState() => _LoggedInViewState();
}

class _LoggedInViewState extends State<LoggedInView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In'),
        backgroundColor: Colors.lightGreenAccent,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                )
              ];
            },
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService().logOut();
                    if (!mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      logInRoute,
                      (route) => false,
                    );
                  } else {
                    return;
                  }
              }
            },
          )
        ],
      ),
    );
  }
}
