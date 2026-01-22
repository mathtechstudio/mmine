import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

class ScanDirectoryUseCase implements UseCase<List<AudioTrack>, String> {
  final AudioRepository repository;

  ScanDirectoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<AudioTrack>>> call(String path) async {
    return await repository.scanDirectory(path);
  }
}
