import 'package:app/constants/crud/crud_columns.dart';
import 'package:app/constants/crud/crud_queries.dart';
import 'package:app/constants/crud/crud_tables.dart';
import 'package:app/models/auth/auth_user.dart';
import 'package:app/services/auth/auth_service.dart';
import 'package:app/services/crud/crud_exceptions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CRUDService {
  Database? _db;

  Future<bool> doesDatabaseExist() async {
    try {
      await getCurrentUserFromDb();
      return true;
    } on DatabaseNotFoundException {
      return false;
    }
  }

  Future<void> open() async {
    if (_db != null) throw DatabaseAlreadyOpenException();
    try {
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;
      await db.execute(createAuthUserTableQuery);
      await db.execute(createUserProfileTableQuery);
      await db.execute(createHomeAddressTableQuery);
      await db.execute(createMobileAuthTokenTableQuery);
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
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    try {
      final row = await db.query(authUserTable, limit: 1);
      AuthUser user = AuthUser.fromSqliteRow(row.first);
      return user;
    } on StateError {
      throw DatabaseNotFoundException();
    }
  }

  Future<void> insertUserIntoDb(AuthUser user) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await db.insert(authUserTable, {
      uidColumn: user.uid,
      firstNameColumn: user.firstName,
      lastNameColumn: user.lastName,
      emailColumn: user.email,
      phoneNumberColumn: user.phoneNumber,
      isStaffColumn: user.isStaff,
      isSuperuserColumn: user.isSuperuser,
      isEmailVerifiedColumn: user.isEmailVerified,
      signedUpColumn: user.signedUp.toString(),
    });
    await db.insert(userProfileTable, {
      uidColumn: user.uid,
      firstNameColumn: user.firstName,
      lastNameColumn: user.lastName,
      emailColumn: user.email,
      phoneNumberColumn: user.phoneNumber,
    });
  }

  Future<void> deleteUserDb(AuthUser user) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    await db.delete(authUserTable);
    await db.delete(userProfileTable);
    await db.delete(homeAddressTable);
    await db.delete(mobileAuthTokenTable);
  }

  Future<String> getMobileAuthTokenFromDb() async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    AuthUser user = await getCurrentUserFromDb();
    final row = await db.query(
      mobileAuthTokenTable,
      limit: 1,
      where: 'uid = ?',
      whereArgs: [user.uid],
    );
    return row.first['token'].toString();
  }

  Future<void> insertMobileAuthTokenIntoDb(String token,
      [AuthUser? user]) async {
    await _ensureDbIsOpen();
    final db = _getDatabaseOrThrow();
    final AuthUser dbUser = user ?? await AuthService().currentUser;
    await db.insert(
      mobileAuthTokenTable,
      {
        uidColumn: dbUser.uid,
        tokenColumn: token,
      },
    );
  }
}
