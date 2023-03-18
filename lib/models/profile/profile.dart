class Profile {
  int uid;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String? dateOfBirth;
  String? gender;
  String profilePicture;

  Profile({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.profilePicture,
  });
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      uid: json['user'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'].toString(),
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      profilePicture: json['profile_picture'],
    );
  }
  factory Profile.fromSqliteRow(Map<String, dynamic> row) {
    return Profile(
      uid: row['uid'],
      firstName: row['firstName'],
      lastName: row['lastName'],
      phoneNumber: row['phoneNumber'].toString(),
      email: row['email'],
      dateOfBirth: row['dateOfBirth'],
      gender: row['gender'],
      profilePicture: row['profilePicture'],
    );
  }
}
