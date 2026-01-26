import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/search_tracks_use_case.dart';

import 'search_tracks_use_case_test.mocks.dart';

@GenerateMocks([AudioRepository])
void main() {
  late SearchTracksUseCase useCase;
  late MockAudioRepository mockRepository;

  setUp(() {
    mockRepository = MockAudioRepository();
    useCase = SearchTracksUseCase(mockRepository);
  });

  final testTracks = [
    AudioTrack(
      id: '1',
      filePath: '/path/to/track1.flac',
      title: 'Yesterday',
      artist: 'The Beatles',
      album: 'Help!',
      duration: const Duration(minutes: 2, seconds: 5),
      format: AudioFormat.flac,
      bitDepth: 24,
      sampleRate: 96000,
      fileSize: 40000000,
      dateAdded: DateTime(2024, 1, 1),
    ),
  ];

  test('should search tracks and return results', () async {
    when(
      mockRepository.searchTracks(any),
    ).thenAnswer((_) async => Right(testTracks));

    final result = await useCase('yesterday');

    expect(result, Right(testTracks));
    verify(mockRepository.searchTracks('yesterday'));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return empty list for empty query', () async {
    final result = await useCase('');

    expect(result.isRight(), true);
    result.fold((l) => fail('Should return Right'), (r) => expect(r, isEmpty));
    verifyNever(mockRepository.searchTracks(any));
  });

  test('should return empty list for whitespace query', () async {
    final result = await useCase('   ');

    expect(result.isRight(), true);
    result.fold((l) => fail('Should return Right'), (r) => expect(r, isEmpty));
    verifyNever(mockRepository.searchTracks(any));
  });

  test('should return failure when search fails', () async {
    when(
      mockRepository.searchTracks(any),
    ).thenAnswer((_) async => Left(DatabaseFailure('Search failed')));

    final result = await useCase('test');

    expect(result, Left(DatabaseFailure('Search failed')));
    verify(mockRepository.searchTracks('test'));
    verifyNoMoreInteractions(mockRepository);
  });
}
