import 'package:app/constants/accounts/overview/overview_constants.dart';
import 'package:app/services/crud/crud_service.dart';
import 'package:flutter/material.dart';

class AccountsOverviewView extends StatefulWidget {
  const AccountsOverviewView({super.key});

  @override
  State<AccountsOverviewView> createState() => _AccountsOverviewViewState();
}

class _AccountsOverviewViewState extends State<AccountsOverviewView> {
  late final DateTime customerSince;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CRUDService().getCurrentUserFromDb(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              customerSince = snapshot.data!.signedUp;
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
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 60),
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
                                    '${customerSince.day} ${monthAbbr[customerSince.month]} ${customerSince.year}',
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
              return const CircularProgressIndicator.adaptive();
          }
        });
  }
}
