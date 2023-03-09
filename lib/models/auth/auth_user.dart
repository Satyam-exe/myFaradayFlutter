class AuthUser {
  int uid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  bool isEmailVerified;
  bool isStaff;
  bool isSuperuser;
  String password;

  AuthUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.isStaff,
    required this.isSuperuser,
    required this.email,
    required this.isEmailVerified,
    required this.password,
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
      password: json['password'],
    );
  }
  factory AuthUser.fromSqliteRow(Map<String, dynamic> row) {
    return AuthUser(
      uid: row['uid'],
      firstName: row['firstName'],
      lastName: row['lastName'],
      phoneNumber: row['phoneNumber'],
      isStaff: row['isStaff'],
      isSuperuser: row['isSuperuser'],
      email: row['email'],
      isEmailVerified: row['isEmailVerified'],
      password: row['password'],
    );
  }
}
