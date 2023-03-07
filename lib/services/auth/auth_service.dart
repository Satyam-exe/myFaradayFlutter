import 'package:app/services/auth/auth_user.dart';

abstract class AuthService {
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    return AuthUser(
      uid: 1,
      firstName: 'firstName',
      lastName: 'lastName',
      phoneNumber: 'phoneNumber',
      isStaff: false,
      isSuperuser: false,
      email: email,
      isEmailVerified: false,
    );
  }

  Future<AuthUser> createUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
