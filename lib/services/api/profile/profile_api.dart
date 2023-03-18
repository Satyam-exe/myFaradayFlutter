import 'package:app/constants/api/api_urls.dart';
import 'package:http/http.dart' as http;

Future<http.Response> getProfileAPIResponse(int uid) {
  final response = http.get(
    Uri.parse('$getProfileAPIUrl$uid/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return response;
}
