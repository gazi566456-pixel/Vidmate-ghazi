import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
  @override List<Object?> get props => [];
}

class GeneralFailure extends Failure {
  final String message;
  const GeneralFailure(this.message);
  @override List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  final String message;
  const ServerFailure({required this.message});
  @override List<Object?> get props => [message];
}

class UnsupportedPlatformFailure extends Failure {
  final String message;
  const UnsupportedPlatformFailure([this.message = "Unsupported platform or media type."]);
  @override List<Object?> get props => [message];
}

class UnsupportedStreamTypeFailure extends Failure {
  final String message;
  const UnsupportedStreamTypeFailure([this.message = "The selected stream type is not supported for direct download or merging."]);
  @override List<Object?> get props => [message];
}

class ExtractionFailedFailure extends Failure {
  final String message;
  const ExtractionFailedFailure({required this.message});
  @override List<Object?> get props => [message];
}

class FFmpegFailure extends Failure {
  final String message;
  const FFmpegFailure({required this.message});
  @override List<Object?> get props => [message];
}

class DownloadCancelledFailure extends Failure {
  final String message;
  const DownloadCancelledFailure({this.message = "Download was cancelled."});
  @override List<Object?> get props => [message];
}
