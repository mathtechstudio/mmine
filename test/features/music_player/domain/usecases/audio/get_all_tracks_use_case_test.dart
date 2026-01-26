import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/core/usecases/usecase.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/get_all_tracks_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_tracks_use_case_test.mocks.dart';

@GenerateMocks([AudioRepository])
void main() {
  late GetAllTracksUseCase useCase;
  late MockAudioRepository mockRepository;

  setUp(() {
    mockRepository = MockAudioRepository();
    useCase = GetAllTracksUseCase(mockRepository);
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

  group('GetAllTracksUseCase', () {
    test('should get all tracks successfully', () async {
      // Arrange
      final tracks = [testTrack];
      when(
        mockRepository.getAllTracks(),
      ).thenAnswer((_) async => Right(tracks));

      // Act
      final result = await useCase(NoParams());

      // Assert
      expect(result, Right(tracks));
      verify(mockRepository.getAllTracks());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when getting tracks fails', () async {
      // Arrange
      final failure = DatabaseFailure('Failed to get tracks');
      when(
        mockRepository.getAllTracks(),
      ).thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase(NoParams());

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.getAllTracks());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return empty list when no tracks', () async {
      // Arrange
      when(
        mockRepository.getAllTracks(),
      ).thenAnswer((_) async => const Right(<AudioTrack>[]));

      // Act
      final result = await useCase(NoParams());

      // Assert
      expect(result.isRight(), true);
      verify(mockRepository.getAllTracks());
    });
  });
}
