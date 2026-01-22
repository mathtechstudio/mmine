import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

class GetTracksByAlbumUseCase implements UseCase<List<AudioTrack>, String> {
  final AudioRepository repository;

  GetTracksByAlbumUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudioTrack>>> call(String album) async {
    return await repository.getTracksByAlbum(album);
  }
}
