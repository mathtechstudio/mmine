import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';

/// Use case for retrieving all unique album names from the library.
///
/// This use case fetches a list of all distinct album names from the
/// audio repository. The albums are extracted from the metadata of all
/// tracks in the library.
///
/// Returns:
/// - Right: List of album names (may be empty if no tracks exist)
/// - Left: [Failure] if the operation fails
///
/// Example:
/// ```dart
/// final useCase = GetAllAlbumsUseCase(repository);
/// final result = await useCase(NoParams());
/// result.fold(
///   (failure) => print('Error: $failure'),
///   (albums) => print('Found ${albums.length} albums'),
/// );
/// ```
class GetAllAlbumsUseCase implements UseCase<List<String>, NoParams> {
  final AudioRepository repository;

  GetAllAlbumsUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await repository.getAllAlbums();
  }
}
