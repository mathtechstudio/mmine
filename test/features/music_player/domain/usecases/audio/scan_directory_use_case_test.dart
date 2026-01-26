import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/audio/scan_directory_use_case.dart';

import 'scan_directory_use_case_test.mocks.dart';

@GenerateMocks([AudioRepository])
void main() {
  late ScanDirectoryUseCase useCase;
  late MockAudioRepository mockRepository;

  setUp(() {
    mockRepository = MockAudioRepository();
    useCase = ScanDirectoryUseCase(mockRepository);
  });

  const testPath = '/storage/emulated/0/Music';
  final testTracks = [
    AudioTrack(
      id: '1',
      filePath: '/path/to/track1.flac',
      title: 'Track 1',
      artist: 'Artist 1',
      album: 'Album 1',
      duration: const Duration(minutes: 3),
      format: AudioFormat.flac,
      bitDepth: 24,
      sampleRate: 96000,
      fileSize: 50000000,
      dateAdded: DateTime(2024, 1, 1),
    ),
  ];

  test('should scan directory and return tracks', () async {
    when(
      mockRepository.scanDirectory(any),
    ).thenAnswer((_) async => Right(testTracks));

    final result = await useCase(testPath);

    expect(result, Right(testTracks));
    verify(mockRepository.scanDirectory(testPath));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return failure when scanning fails', () async {
    when(
      mockRepository.scanDirectory(any),
    ).thenAnswer((_) async => Left(DatabaseFailure('Scan failed')));

    final result = await useCase(testPath);

    expect(result, Left(DatabaseFailure('Scan failed')));
    verify(mockRepository.scanDirectory(testPath));
    verifyNoMoreInteractions(mockRepository);
  });
}
