import 'package:flutter/material.dart';

var bottomNavigationBarItems = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(icon: Icon(Icons.home_sharp), label: 'Home'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.electric_bolt_sharp), label: 'Electrician'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.plumbing_sharp), label: 'Plumber'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_sharp), label: 'Account')
];

var accountsBottomNavigationBarItems = <BottomNavigationBarItem>[
  const BottomNavigationBarItem(
      icon: Icon(Icons.info_sharp), label: 'Overview'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart_sharp), label: 'Past Requests'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.edit_sharp), label: 'Edit Profile'),
  const BottomNavigationBarItem(
      icon: Icon(Icons.support_agent_sharp), label: 'Contact Support'),
];
