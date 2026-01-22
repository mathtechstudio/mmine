import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class AddToQueueUseCase implements UseCase<void, List<AudioTrack>> {
  final PlaybackRepository repository;

  AddToQueueUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(List<AudioTrack> tracks) async {
    return await repository.addToQueue(tracks);
  }
}
