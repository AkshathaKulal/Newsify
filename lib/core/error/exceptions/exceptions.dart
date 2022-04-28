
/// @author Akshatha

class ServerException implements Exception {
  dynamic errorResponse;

  ServerException(this.errorResponse);
}

class CacheException implements Exception {}

class TimeoutException implements Exception {}
