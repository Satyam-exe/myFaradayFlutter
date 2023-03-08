import 'dart:ffi';
import 'dart:typed_data';

import 'package:app/constants/api/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> signUpAPIResponse(
  String firstName,
  String lastName,
  String email,
  String phoneNumber,
  String password,
) async {
  final response = await http.post(
    Uri.parse(signUpAPIUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
      'signup_platform': 'flutter',
    }),
  );
  return response;
}

Future<http.Response> logInAPIResponse(
  String email,
  String password,
) async {
  final response = await http.post(
    Uri.parse(logInAPIUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  return response;
}

Future<http.Response> sendEmailVerificationAPIResponse(int uid) async {
  final response = await http.post(
    Uri.parse(signUpAPIUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'uid': '$uid'}),
  );
  return response;
}

Future<http.Response> getUserByUIDAPIResponse(int uid) async {
  final response = await http.get(
    Uri.parse('${getUsersAPIUrl}uid/$uid/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );
  return response;
}

Future<http.Response> getUserByEmailAPIResponse(String email) async {
  final response = await http.get(
    Uri.parse('${getUsersAPIUrl}email/$email/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );
  return response;
}

Future<http.Response> getUserByPhoneNumberAPIResponse(int phoneNumber) async {
  final response = await http.get(
    Uri.parse('${getUsersAPIUrl}phone/$phoneNumber/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );
  return response;
}
