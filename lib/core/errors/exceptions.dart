class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}

class ExtractionFailedException implements Exception {
  final String message;
  ExtractionFailedException({required this.message});
}

class FFmpegExecutionException implements Exception {
  final String message;
  FFmpegExecutionException({required this.message});
}

class CancellationException implements Exception {
  final String message;
  CancellationException({this.message = "Operation cancelled."});
}

class UnsupportedPlatformException implements Exception {
  final String message;
  UnsupportedPlatformException({required this.message});
}
