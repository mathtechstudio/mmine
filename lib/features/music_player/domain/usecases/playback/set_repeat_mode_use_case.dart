import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';

class SetRepeatModeUseCase implements UseCase<void, RepeatMode> {
  final PlaybackRepository repository;

  SetRepeatModeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RepeatMode mode) async {
    return await repository.setRepeatMode(mode);
  }
}
