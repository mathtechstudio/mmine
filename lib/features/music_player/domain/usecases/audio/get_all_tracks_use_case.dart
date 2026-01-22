import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

class GetAllTracksUseCase implements UseCase<List<AudioTrack>, NoParams> {
  final AudioRepository repository;

  GetAllTracksUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudioTrack>>> call(NoParams params) async {
    return await repository.getAllTracks();
  }
}
