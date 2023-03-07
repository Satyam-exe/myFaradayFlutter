class AuthUser {
  final int uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final bool isEmailVerified;
  final bool isStaff;
  final bool isSuperuser;

  const AuthUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.isStaff,
    required this.isSuperuser,
    required this.email,
    required this.isEmailVerified,
  });
  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
        uid: json['uid'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        phoneNumber: json['phone_number'],
        isStaff: json['is_staff'],
        isSuperuser: json['is_superuser'],
        isEmailVerified: json['is_email_verified']);
  }
}
