import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

/// Use case for adding tracks to the end of the playback queue.
///
/// This use case appends one or more tracks to the current playback queue
/// without interrupting the currently playing track.
///
/// Parameters:
/// - [tracks]: List of [AudioTrack] objects to add to the queue
///
/// Returns:
/// - Right: void on success
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = AddToQueueUseCase(repository);
/// final result = await useCase([track1, track2]);
/// result.fold(
///   (failure) => print('Failed: $failure'),
///   (_) => print('Tracks added to queue'),
/// );
/// ```
class AddToQueueUseCase implements UseCase<void, List<AudioTrack>> {
  final PlaybackRepository repository;

  AddToQueueUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(List<AudioTrack> tracks) async {
    return await repository.addToQueue(tracks);
  }
}
