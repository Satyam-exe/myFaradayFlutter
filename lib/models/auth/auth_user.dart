class AuthUser {
  int uid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  bool isEmailVerified;
  bool isStaff;
  bool isSuperuser;

  AuthUser({
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
