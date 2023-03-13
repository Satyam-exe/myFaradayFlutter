import 'package:app/constants/navbar/navbar_enums.dart';
import 'package:app/views/account/overview/accounts_overview.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AccountsOverviewView(),
    Text(
      'Index 1: Past Requests',
    ),
    Text(
      'Index 2: Edit Profile',
    ),
    Text(
      'Index 3: Contact Support',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: accountsBottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
