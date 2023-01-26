//login exceptions
class WrongPasswordAuthException implements Exception{}
class UserNotFoundAuthException implements Exception{}
//register exceptions
class WeekPasswordAuthException implements Exception{}
class InvalidEmailAuthException implements Exception{}
class EmailAlreadyInUseAuthException implements Exception{}
//generic exceptions
class GenericAuthException implements Exception{}
class UserNotLoggedAuthException implements Exception{}