const createAuthUserTableQuery = """
CREATE TABLE IF NOT EXISTS "AuthUser" (
	"uid"	INTEGER NOT NULL UNIQUE,
	"firstName"	TEXT NOT NULL,
	"lastName"	TEXT NOT NULL,
	"email"	TEXT NOT NULL UNIQUE,
	"phoneNumber"	TEXT NOT NULL UNIQUE,
	"isEmailVerified"	INTEGER NOT NULL,
	"isStaff"	INTEGER NOT NULL,
	"isSuperuser"	INTEGER NOT NULL,
  "signedUp" TEXT NOT NULL,
	PRIMARY KEY("uid")
)
""";

const createUserProfileTableQuery = """
CREATE TABLE IF NOT EXISTS "UserProfile" (
	"uid"	INTEGER NOT NULL UNIQUE,
	"firstName"	BLOB NOT NULL,
	"lastName"	INTEGER NOT NULL,
	"email"	INTEGER NOT NULL UNIQUE,
	"phoneNumber"	INTEGER NOT NULL UNIQUE,
	"dateOfBirth"	INTEGER,
	"gender" TEXT,
	"profilePicture"	TEXT,
	PRIMARY KEY("uid"),
	FOREIGN KEY("uid") REFERENCES "AuthUser"("uid")
)
""";

const createHomeAddressTableQuery = """
CREATE TABLE IF NOT EXISTS "HomeAddress" (
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

const createMobileAuthTokenTableQuery = """
CREATE TABLE IF NOT EXISTS "MobileAuthToken" (
	"uid"	INTEGER NOT NULL UNIQUE,
	"token"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("uid"),
	FOREIGN KEY("uid") REFERENCES "AuthUser"("uid")
)
""";
