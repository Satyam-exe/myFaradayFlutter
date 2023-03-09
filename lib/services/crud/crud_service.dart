import 'package:app/models/auth/auth_user.dart';
import 'package:app/services/crud/crud_exceptions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const _dbName = 'erenjaeger.aot';
const _authUserTable = 'AuthUser';
const _userProfileTable = 'UserProfile';
const _homeAddressTable = 'HomeAddress';

const _uidColumn = 'uid';
const _firstNameColumn = 'firstName';
const _lastNameColumn = 'lastName';
const _emailColumn = 'email';
const _phoneNumberColumn = 'phoneNumber';
const _isStaffColumn = 'isStaff';
const _isSuperuserColumn = 'isSuperuser';
const _isEmailVerifiedColumn = 'isEmailVerified';
const _passwordColumn = 'password';

const _createAuthUserTableQuery = """
CREATE TABLE "AuthUser" (
	"uid"	INTEGER NOT NULL UNIQUE,
	"firstName"	TEXT NOT NULL,
	"lastName"	TEXT NOT NULL,
	"email"	TEXT NOT NULL UNIQUE,
	"phoneNumber"	TEXT NOT NULL UNIQUE,
	"isEmailVerified"	INTEGER NOT NULL,
	"isStaff"	INTEGER NOT NULL,
	"isSuperuser"	INTEGER NOT NULL,
	PRIMARY KEY("uid")
)
""";

const _createUserProfileTableQuery = """
CREATE TABLE "UserProfile" (
	"uid"	INTEGER NOT NULL UNIQUE,
	"firstName"	BLOB NOT NULL,
	"lastName"	INTEGER NOT NULL,
	"email"	INTEGER NOT NULL UNIQUE,
	"phoneNumber"	INTEGER NOT NULL UNIQUE,
	"dateOfBirth"	INTEGER,
	"profilePicture"	TEXT,
	PRIMARY KEY("uid"),
	FOREIGN KEY("uid") REFERENCES "AuthUser"("uid")
)
""";

const _createHomeAddressTableQuery = """
CREATE TABLE "HomeAddress" (
	"address1"	INTEGER NOT NULL,
	"address"	TEXT NOT NULL,
	"pincode"	INTEGER NOT NULL,
	"city"	TEXT NOT NULL,
	"state"	TEXT NOT NULL,
	"latitude"	REAL,
	"longitude"	REAL,
	"uid"	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("uid"),
	FOREIGN KEY("uid") REFERENCES "UserProfile"("uid")
)
""";

class CRUDService {
  Database? _db;

  Future<void> open() async {
    if (_db != null) throw DatabaseAlreadyOpenException();
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, _dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      await db.execute(_createAuthUserTableQuery);
      await db.execute(_createUserProfileTableQuery);
      await db.execute(_createHomeAddressTableQuery);
    } on MissingPlatformDirectoryException {
      throw UnableToGetDocumentsDirectoryException();
    }
  }

  Future<void> close() async {
    final db = _db;
    if (db == null) {
      throw DatabaseNotOpenException();
    } else {
      await db.close();
      _db = null;
    }
  }

  Database _getDatabaseOrThrow() {
    final db = _db;
    if (db == null) {
      throw DatabaseNotOpenException();
    } else {
      return db;
    }
  }

  Future<void> _ensureDbIsOpen() async {
    try {
      await open();
    } on DatabaseAlreadyOpenException {
      // empty
    }
  }

  Future<AuthUser> getCurrentUserFromDb() async {
    _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final row = await db.query(_authUserTable, limit: 1);
    AuthUser user = AuthUser.fromSqliteRow(row.first);
    return user;
  }

  Future<void> insertUserIntoDb(AuthUser user) async {
    _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await db.insert(_authUserTable, {
      _uidColumn: user.uid,
      _firstNameColumn: user.firstName,
      _lastNameColumn: user.lastName,
      _emailColumn: user.email,
      _phoneNumberColumn: user.phoneNumber,
      _isStaffColumn: user.isStaff,
      _isSuperuserColumn: user.isSuperuser,
      _isEmailVerifiedColumn: user.isEmailVerified,
      _passwordColumn: user.password,
    });
    await db.insert(_userProfileTable, {
      _uidColumn: user.uid,
      _firstNameColumn: user.firstName,
      _lastNameColumn: user.lastName,
      _emailColumn: user.email,
      _phoneNumberColumn: user.phoneNumber,
    });
  }

  Future<void> deleteUserFromDb(AuthUser user) async {
    _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await db.delete(_authUserTable);
    await db.delete(_userProfileTable);
    await db.delete(_homeAddressTable);
  }
}
