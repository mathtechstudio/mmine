import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/resume_playback_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'resume_playback_use_case_test.mocks.dart';

@GenerateMocks([PlaybackRepository])
void main() {
  late ResumePlaybackUseCase useCase;
  late MockPlaybackRepository mockRepository;

  setUp(() {
    mockRepository = MockPlaybackRepository();
    useCase = ResumePlaybackUseCase(mockRepository);
  });

  group('ResumePlaybackUseCase', () {
    test('should resume playback successfully', () async {
      // Arrange
      when(mockRepository.resume()).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(NoParams());

      // Assert
      expect(result, const Right(null));
      verify(mockRepository.resume());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when resume fails', () async {
      // Arrange
      final failure = PlaybackFailure('Failed to resume');
      when(mockRepository.resume()).thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(NoParams());

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.resume());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
