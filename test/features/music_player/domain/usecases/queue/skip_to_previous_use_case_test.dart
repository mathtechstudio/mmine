import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/skip_to_previous_use_case.dart';

import 'skip_to_previous_use_case_test.mocks.dart';

@GenerateMocks([PlaybackRepository])
void main() {
  late SkipToPreviousUseCase useCase;
  late MockPlaybackRepository mockRepository;

  setUp(() {
    mockRepository = MockPlaybackRepository();
    useCase = SkipToPreviousUseCase(mockRepository);
  });

  test('should skip to previous track', () async {
    when(
      mockRepository.skipToPrevious(),
    ).thenAnswer((_) async => const Right(null));

    final result = await useCase(NoParams());

    expect(result, const Right(null));
    verify(mockRepository.skipToPrevious());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when skip fails', () async {
    when(
      mockRepository.skipToPrevious(),
    ).thenAnswer((_) async => Left(PlaybackFailure('No previous track')));

    final result = await useCase(NoParams());

    expect(result, Left(PlaybackFailure('No previous track')));
    verify(mockRepository.skipToPrevious());
    verifyNoMoreInteractions(mockRepository);
  });
}
