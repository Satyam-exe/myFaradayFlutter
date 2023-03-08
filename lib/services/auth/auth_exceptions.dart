// login exceptions

class InvalidCredentialsAuthException implements Exception {}

class EmailNotVerifiedAuthException implements Exception {}

// signup exceptions

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class PhoneNumberAlreadyInUseAuthException implements Exception {}

class BothIdentifiersAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class InternalServerErrorAuthException implements Exception {}

class IntegrityErrorAuthException implements Exception {}

// generic exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}
