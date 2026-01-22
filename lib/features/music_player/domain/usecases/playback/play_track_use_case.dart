import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class PlayTrackUseCase {
  final PlaybackRepository repository;

  PlayTrackUseCase(this.repository);

  Future<Either<Failure, void>> call(AudioTrack track) async {
    return await repository.play(track);
  }
}
