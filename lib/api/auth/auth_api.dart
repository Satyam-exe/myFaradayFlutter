import 'package:app/api/constants/api_urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> createUser(
  String firstName,
  String lastName,
  String email,
  String phoneNumber,
  String password,
) {
  return http.post(
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
    }),
  );
}
