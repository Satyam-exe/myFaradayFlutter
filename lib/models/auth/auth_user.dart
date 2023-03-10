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
      isEmailVerified: json['is_email_verified'],
    );
  }
  factory AuthUser.fromSqliteRow(Map<String, dynamic> row) {
    late final bool isStaff;
    late final bool isSuperuser;
    late final bool isEmailVerified;
    row['isStaff'] == 1 ? isStaff = true : isStaff = false;
    row['isSuperuser'] == 1 ? isSuperuser = true : isSuperuser = false;
    row['isEmailVerified'] == 1
        ? isEmailVerified = true
        : isEmailVerified = false;
    return AuthUser(
      uid: row['uid'],
      firstName: row['firstName'],
      lastName: row['lastName'],
      phoneNumber: row['phoneNumber'],
      isStaff: isStaff,
      isSuperuser: isSuperuser,
      email: row['email'],
      isEmailVerified: isEmailVerified,
    );
  }
}
