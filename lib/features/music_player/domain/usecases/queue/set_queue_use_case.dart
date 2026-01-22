import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class SetQueueUseCase implements UseCase<void, SetQueueParams> {
  final PlaybackRepository repository;

  SetQueueUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetQueueParams params) async {
    return await repository.setQueue(params.tracks, params.startIndex);
  }
}

class SetQueueParams {
  final List<AudioTrack> tracks;
  final int startIndex;

  const SetQueueParams({required this.tracks, required this.startIndex});
}
