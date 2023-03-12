import 'dart:async';
import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/auth/auth_service.dart';

bool isPasswordOfAcceptableLength(String password) =>
    password.length >= 8 && password.length <= 32;

bool isEmailSyntacticallyValid(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return regex.hasMatch(email);
}

Future<bool> isEmailAvailable(String email) async {
  try {
    await AuthService().getUserByEmail(email);
    return false;
  } on UserNotFoundAuthException catch (_) {
    return true;
  }
}

bool isFirstNameOfAcceptableLength(String firstName) => firstName.length <= 30;

bool isLastNameOfAcceptableLength(String lastName) => lastName.length <= 30;

bool isPhoneNumberofAcceptableLength(String phoneNumber) =>
    phoneNumber.length == 10;

bool isPhoneNumberSyntacticallyValid(String phoneNumber) =>
    RegExp(r'^[0-9]{10}$').hasMatch(phoneNumber);

Future<bool> isPhoneNumberAvailable(String phoneNumber) async {
  try {
    await AuthService().getUserByPhoneNumber(phoneNumber);
    return false;
  } on UserNotFoundAuthException catch (_) {
    return true;
  }
}

String? isFirstNameValid(String firstName) {
  if (firstName.isEmpty) {
    return 'Please enter your first name.';
  } else if (isFirstNameOfAcceptableLength(firstName) == false) {
    return 'First name cannot be longer than 30 characters.';
  } else {
    return null;
  }
}

String? isLastNameValid(String lastName) {
  if (lastName.isEmpty) {
    return 'Please enter your last name.';
  } else if (isLastNameOfAcceptableLength(lastName) == false) {
    return 'Last name cannot be longer than 30 characters.';
  } else {
    return null;
  }
}

String? isEmailValid(String email) {
  if (email.isEmpty) {
    return 'Please enter your email.';
  } else if (isEmailSyntacticallyValid(email) == false) {
    return 'Please enter a valid email.';
  } else {
    return null;
  }
}

String? isPhoneNumberValid(String phoneNumber) {
  if (phoneNumber.isEmpty) {
    return 'Please enter your phone number';
  } else if (isPhoneNumberSyntacticallyValid(phoneNumber) == false) {
    return 'Please enter a valid 10 digit phone number';
  } else if (isPhoneNumberofAcceptableLength(phoneNumber) == false) {
    return 'Please enter a valid 10 digit phone number';
  } else {
    return null;
  }
}

String? isPasswordValid(String password) {
  if (password.isEmpty) {
    return 'Please enter a password';
  } else if (isPasswordOfAcceptableLength(password) == false) {
    return 'Please enter a password within 8-32 characters in length.';
  } else {
    return null;
  }
}

Future<bool> checkIfIdentifiersAreAvailable(
  String email,
  String phoneNumber,
) async {
  final arr = List.empty(growable: true);
  if (await isEmailAvailable(email) == false) {
    arr.add('email');
  }
  if (await isPhoneNumberAvailable(phoneNumber) == false) {
    arr.add('phoneNumber');
  }
  if (arr.contains('email') && arr.contains('phoneNumber')) {
    throw BothIdentifiersAlreadyInUseAuthException();
  } else if (arr.contains('email')) {
    throw EmailAlreadyInUseAuthException();
  } else if (arr.contains('phoneNumber')) {
    throw PhoneNumberAlreadyInUseAuthException();
  } else {
    return true;
  }
}
