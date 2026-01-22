import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

class GetAllArtistsUseCase implements UseCase<List<String>, NoParams> {
  final AudioRepository repository;

  GetAllArtistsUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getAllArtists();
  }
}
