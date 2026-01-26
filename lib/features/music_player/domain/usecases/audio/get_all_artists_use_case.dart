import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

/// Use case for retrieving all unique artist names from the library.
///
/// This use case fetches a list of all distinct artist names from the
/// audio repository. The artists are extracted from the metadata of all
/// tracks in the library.
///
/// Returns:
/// - Right: List of artist names (may be empty if no tracks exist)
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = GetAllArtistsUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (artists) => print('Found ${artists.length} artists'),
/// );
/// ```
class GetAllArtistsUseCase implements UseCase<List<String>, NoParams> {
  final AudioRepository repository;

  GetAllArtistsUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getAllArtists();
  }
}
