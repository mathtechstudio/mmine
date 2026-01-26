import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/set_queue_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'set_queue_use_case_test.mocks.dart';

@GenerateMocks([PlaybackRepository])
void main() {
  late SetQueueUseCase useCase;
  late MockPlaybackRepository mockRepository;

  setUp(() {
    mockRepository = MockPlaybackRepository();
    useCase = SetQueueUseCase(mockRepository);
  });

  final now = DateTime.now();
  final testTrack = AudioTrack(
    id: '1',
    title: 'Test Song',
    artist: 'Test Artist',
    album: 'Test Album',
    filePath: '/path/to/song.flac',
    duration: const Duration(minutes: 3),
    format: AudioFormat.flac,
    bitDepth: 24,
    sampleRate: 96000,
    fileSize: 10485760,
    dateAdded: now,
  );

  group('SetQueueUseCase', () {
    test('should set queue successfully', () async {
      // Arrange
      final tracks = [testTrack];
      const startIndex = 0;
      when(
        mockRepository.setQueue(any, any),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(
        SetQueueParams(tracks: tracks, startIndex: startIndex),
      );

      // Assert
      expect(result, const Right(null));
      verify(mockRepository.setQueue(tracks, startIndex));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when set queue fails', () async {
      // Arrange
      final tracks = [testTrack];
      const startIndex = 0;
      final failure = PlaybackFailure('Failed to set queue');
      when(
        mockRepository.setQueue(any, any),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(
        SetQueueParams(tracks: tracks, startIndex: startIndex),
      );

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.setQueue(tracks, startIndex));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should handle empty queue', () async {
      // Arrange
      const tracks = <AudioTrack>[];
      const startIndex = 0;
      when(
        mockRepository.setQueue(any, any),
      ).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(
        const SetQueueParams(tracks: tracks, startIndex: startIndex),
      );

      // Assert
      expect(result, const Right(null));
      verify(mockRepository.setQueue(tracks, startIndex));
    });
  });
}
