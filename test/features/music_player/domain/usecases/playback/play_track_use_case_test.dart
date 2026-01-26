import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/play_track_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'play_track_use_case_test.mocks.dart';

@GenerateMocks([PlaybackRepository])
void main() {
  late PlayTrackUseCase useCase;
  late MockPlaybackRepository mockRepository;

  setUp(() {
    mockRepository = MockPlaybackRepository();
    useCase = PlayTrackUseCase(mockRepository);
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

  group('PlayTrackUseCase', () {
    test('should play track successfully', () async {
      // Arrange
      when(mockRepository.play(any)).thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(testTrack);

      // Assert
      expect(result, const Right(null));
      verify(mockRepository.play(testTrack));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when playback fails', () async {
      // Arrange
      final failure = PlaybackFailure('Failed to play track');
      when(mockRepository.play(any)).thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(testTrack);

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.play(testTrack));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
