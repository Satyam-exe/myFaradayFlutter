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
  int requestedTimeInDays,
) async {
  final response = await http.post(
    Uri.parse(logInAPIUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'password': password,
      'requested_time_in_days': requestedTimeInDays.toDouble(),
      'request_platform': 'flutter',
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

Future<http.Response> getUserByPhoneNumberAPIResponse(
    String phoneNumber) async {
  final response = await http.get(
    Uri.parse('${getUsersAPIUrl}phone/$phoneNumber/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );
  return response;
}

Future<http.Response> verifyMobileAuthTokenAPIResponse(
  String token,
  int uid,
) async {
  final response = await http.post(
    Uri.parse(verifyMobileAuthTokenAPIUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: json.encode(
      <String, dynamic>{
        'token': token,
        'uid': uid,
      },
    ),
  );
  return response;
}

Future<http.Response> sendPasswordResetLinkAPIResponse(String email) async {
  final response = await http.post(
    Uri.parse(passwordResetAPIUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: json.encode(
      <String, String>{'email': email},
    ),
  );
  return response;
}

Future<http.Response> revokeMobileAuthTokenAPIResponse(String token) async {
  final response = await http.patch(
    Uri.parse(mobileAuthTokenAPIUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: json.encode(
      <String, String>{
        'token': token,
      },
    ),
  );
  return response;
}
