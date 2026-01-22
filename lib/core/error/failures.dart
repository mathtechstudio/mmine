import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class FileNotFoundFailure extends Failure {
  const FileNotFoundFailure(super.message);
}

class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure(super.message);
}

class PlaybackFailure extends Failure {
  const PlaybackFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class MetadataExtractionFailure extends Failure {
  const MetadataExtractionFailure(super.message);
}

class InvalidFormatFailure extends Failure {
  const InvalidFormatFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
