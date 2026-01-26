import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/pause_playback_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pause_playback_use_case_test.mocks.dart';

@GenerateMocks([PlaybackRepository])
void main() {
  late PausePlaybackUseCase useCase;
  late MockPlaybackRepository mockRepository;

  setUp(() {
    mockRepository = MockPlaybackRepository();
    useCase = PausePlaybackUseCase(mockRepository);
  });

  group('PausePlaybackUseCase', () {
    test('should pause playback successfully', () async {
      // Arrange
      when(mockRepository.pause()).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(NoParams());

      // Assert
      expect(result, const Right(null));
      verify(mockRepository.pause());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when pause fails', () async {
      // Arrange
      final failure = PlaybackFailure('Failed to pause');
      when(mockRepository.pause()).thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(NoParams());

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.pause());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
