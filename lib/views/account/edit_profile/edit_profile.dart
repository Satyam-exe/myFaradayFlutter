import 'package:app/models/auth/auth_user.dart';
import 'package:app/models/profile/profile.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/services/profile/profile_service.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserAndProfile(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            Profile profile = snapshot.data!['profile'];
            AuthUser user = snapshot.data!['user'];
            return ListView(
              children: [],
            );
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<Map<String, dynamic>> _getUserAndProfile() async {
    Profile profile = await ProfileService().currentProfile;
    AuthUser user = await AuthService().currentUser;
    return {
      'profile': profile,
      'user': user,
    };
  }
}
