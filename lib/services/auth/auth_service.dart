import 'dart:convert';
import 'dart:developer';
import 'package:app/models/auth/auth_user.dart';
import 'package:app/services/api/auth/auth_api.dart' as api;
import 'package:app/services/auth/auth_exceptions.dart';
import 'package:app/services/crud/crud_service.dart';

class AuthService {
  Future<AuthUser> get currentUser => CRUDService().getCurrentUserFromDb();

  Future<AuthUser> getUserByUID(int uid) async {
    final response = await api.getUserByUIDAPIResponse(uid);
    return AuthUser.fromJson(jsonDecode(response.body));
  }

  Future<AuthUser> getUserByEmail(String email) async {
    final response = await api.getUserByEmailAPIResponse(email);
    final decodedJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return AuthUser.fromJson(decodedJson);
    } else {
      throw UserNotFoundAuthException();
    }
  }

  Future<AuthUser> getUserByPhoneNumber(String phoneNumber) async {
    final response = await api.getUserByPhoneNumberAPIResponse(phoneNumber);
    final decodedJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return AuthUser.fromJson(decodedJson);
    } else {
      throw UserNotFoundAuthException();
    }
  }

  Future<AuthUser?> logIn({
    required String email,
    required String password,
  }) async {
    final response = await api.logInAPIResponse(
      email,
      password,
    );
    final decodedJson = json.decode(response.body);
    if (response.statusCode == 200) {
      final uid = decodedJson['uid'];
      return getUserByUID(uid);
    } else if (response.statusCode == 400) {
      throw InvalidCredentialsAuthException();
    } else if (response.statusCode == 401) {
      throw EmailNotVerifiedAuthException();
    } else if (response.statusCode == 500) {
      throw InternalServerErrorAuthException();
    } else {
      throw GenericAuthException();
    }
  }

  Future<AuthUser?> createUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    final response = await api.signUpAPIResponse(
      firstName,
      lastName,
      email,
      phoneNumber,
      password,
    );
    final decodedJson = jsonDecode(response.body);
    log(decodedJson.toString());
    if (response.statusCode == 201) {
      AuthUser createdUser = AuthUser.fromJson(decodedJson);
      return createdUser;
    } else if (response.statusCode == 400) {
      if (decodedJson['error']['message'] == 'WEAK_PASSWORD') {
        throw WeakPasswordAuthException();
      } else {
        throw EmptyFieldsAuthException();
      }
    } else if (response.statusCode == 409) {
      final errorMessage = decodedJson['error']['message'];
      if (errorMessage == 'PHONE_NUMBER_ALREADY_IN_USE') {
        throw PhoneNumberAlreadyInUseAuthException();
      } else if (errorMessage == 'EMAIL_ALREADY_IN_USE') {
        throw EmailAlreadyInUseAuthException();
      } else if (errorMessage == 'BOTH_IDENTIFIERS_ALREADY_IN_USE') {
        throw BothIdentifiersAlreadyInUseAuthException();
      } else {
        throw IntegrityErrorAuthException();
      }
    } else if (response.statusCode == 500) {
      throw InternalServerErrorAuthException();
    } else {
      throw GenericAuthException();
    }
  }

  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  Future<void> sendEmailVerification(String email) async {
    final user = await getUserByEmail(email);
    final uid = user.uid;
    final response = await api.sendEmailVerificationAPIResponse(uid);
    if (response.statusCode == 400) {
      throw UserNotFoundAuthException();
    } else if (response.statusCode == 500) {
      throw InternalServerErrorAuthException();
    } else if (response.statusCode == 409) {
      throw IntegrityErrorAuthException();
    }
  }
}
