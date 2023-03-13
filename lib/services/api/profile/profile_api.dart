import 'dart:io';

import 'package:app/constants/api/api_urls.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getProfile(int uid) {
  final response = http.get(
    Uri.parse('$getProfileAPIUrl$uid/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response;
}

// Future<http.Response> updateProfile(int uid, [
//   String? firstName,
//   String? lastName,
//   String? email,
//   String? phoneNumber,
//   String? dateOfBirth,
//   String? gender,
//   ? profilePicture
// ])
