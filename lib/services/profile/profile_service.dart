import 'dart:convert';

import 'package:app/models/profile/profile.dart';
import 'package:app/services/api/profile/profile_api.dart' as api;
import 'package:app/services/crud/crud_service.dart';

class ProfileService {
  Future<Profile> get currentProfile async =>
      await CRUDService().getCurrentProfileFromDb();

  Future<Profile> getProfile(int uid) async {
    final response = await api.getProfileAPIResponse(uid);
    return Profile.fromJson(jsonDecode(response.body));
  }
}
