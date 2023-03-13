import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AccountsOverviewView extends StatefulWidget {
  const AccountsOverviewView({super.key});

  @override
  State<AccountsOverviewView> createState() => _AccountsOverviewViewState();
}

class _AccountsOverviewViewState extends State<AccountsOverviewView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    minRadius: 60.0,
                    child: CircleAvatar(
                        radius: 75.0,
                        backgroundImage: AssetImage(
                            'assets/images/default-profile-picture.png')),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 60),
                    child: Icon(
                      Icons.shopping_cart_sharp,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 60),
                    child: Icon(
                      Icons.timeline_sharp,
                      size: 40,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
