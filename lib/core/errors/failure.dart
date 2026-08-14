import 'package:leyu_mobile/core/errors/exceptions.dart';

abstract class Failure {
  final String message;
  const Failure(this.message);
}

// 🌐 Network & Timeout Failures
class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

// 🔐 Authorization & Authentication Failures
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);
}

// 📡 API Request Failures
class BadRequestFailure extends Failure {
  const BadRequestFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

// 🗄️ Cache Failure
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

Failure mapExceptionToFailure(Exception e) {
  if (e is TimeoutException) {
    return TimeoutFailure(e.message);
  } else if (e is NetworkException) {
    return NetworkFailure(e.message);
  } else if (e is BadRequestException) {
    return BadRequestFailure(e.message);
  } else if (e is UnauthorizedException) {
    return UnauthorizedFailure(e.message);
  } else if (e is ForbiddenException) {
    return ForbiddenFailure(e.message);
  } else if (e is NotFoundException) {
    return NotFoundFailure(e.message);
  } else if (e is ServerException) {
    return ServerFailure(e.message);
  } else if (e is CacheException) {
    return CacheFailure(e.message);
  } else {
    return const ServerFailure("Unexpected error occurred.");
  }
}
