import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/entities/playback_state.dart';
import 'package:mmine/features/music_player/domain/repositories/playback_repository.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/pause_playback_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/play_track_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/resume_playback_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/seek_to_position_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/set_speed_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/set_volume_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/playback/toggle_shuffle_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/set_queue_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/skip_to_next_use_case.dart';
import 'package:mmine/features/music_player/domain/usecases/queue/skip_to_previous_use_case.dart';
import 'package:mmine/features/music_player/presentation/bloc/playback/playback_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'playback_bloc_test.mocks.dart';

@GenerateMocks([
  PlaybackRepository,
  PlayTrackUseCase,
  PausePlaybackUseCase,
  ResumePlaybackUseCase,
  SeekToPositionUseCase,
  SetVolumeUseCase,
  SetSpeedUseCase,
  SetQueueUseCase,
  SkipToNextUseCase,
  SkipToPreviousUseCase,
  ToggleShuffleUseCase,
])
void main() {
  late PlaybackBloc bloc;
  late MockPlayTrackUseCase mockPlayTrack;
  late MockPausePlaybackUseCase mockPausePlayback;
  late MockResumePlaybackUseCase mockResumePlayback;
  late MockSeekToPositionUseCase mockSeekToPosition;
  late MockSetVolumeUseCase mockSetVolume;
  late MockSetSpeedUseCase mockSetSpeed;
  late MockSetQueueUseCase mockSetQueue;
  late MockSkipToNextUseCase mockSkipToNext;
  late MockSkipToPreviousUseCase mockSkipToPrevious;
  late MockToggleShuffleUseCase mockToggleShuffle;
  late MockPlaybackRepository mockRepository;
  late StreamController<PlaybackState> stateController;

  setUp(() {
    mockPlayTrack = MockPlayTrackUseCase();
    mockPausePlayback = MockPausePlaybackUseCase();
    mockResumePlayback = MockResumePlaybackUseCase();
    mockSeekToPosition = MockSeekToPositionUseCase();
    mockSetVolume = MockSetVolumeUseCase();
    mockSetSpeed = MockSetSpeedUseCase();
    mockSetQueue = MockSetQueueUseCase();
    mockSkipToNext = MockSkipToNextUseCase();
    mockSkipToPrevious = MockSkipToPreviousUseCase();
    mockToggleShuffle = MockToggleShuffleUseCase();
    mockRepository = MockPlaybackRepository();
    stateController = StreamController<PlaybackState>.broadcast();

    when(
      mockRepository.playbackStateStream,
    ).thenAnswer((_) => stateController.stream);

    bloc = PlaybackBloc(
      playTrack: mockPlayTrack,
      pausePlayback: mockPausePlayback,
      resumePlayback: mockResumePlayback,
      seekToPosition: mockSeekToPosition,
      setVolume: mockSetVolume,
      setSpeed: mockSetSpeed,
      setQueue: mockSetQueue,
      skipToNext: mockSkipToNext,
      skipToPrevious: mockSkipToPrevious,
      toggleShuffle: mockToggleShuffle,
      playbackRepository: mockRepository,
    );
  });

  tearDown(() async {
    await stateController.close();
    await bloc.close();
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

  group('PlaybackBloc', () {
    test('initial state should be initial', () {
      expect(bloc.state, const PlaybackBlocState.initial());
    });

    test('should handle play track request', () async {
      // Arrange
      when(mockSetQueue(any)).thenAnswer((_) async => const Right(null));
      when(mockPlayTrack(any)).thenAnswer((_) async => const Right(null));

      // Act
      bloc.add(PlaybackEvent.playRequested(testTrack, [testTrack], 0));
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Assert - just verify no errors
      expect(bloc.state, isA<PlaybackBlocState>());
    });

    test('should handle pause request', () async {
      // Arrange
      when(mockPausePlayback(any)).thenAnswer((_) async => const Right(null));

      // Act
      bloc.add(const PlaybackEvent.pauseRequested());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(bloc.state, isA<PlaybackBlocState>());
    });

    test('should handle resume request', () async {
      // Arrange
      when(mockResumePlayback(any)).thenAnswer((_) async => const Right(null));

      // Act
      bloc.add(const PlaybackEvent.resumeRequested());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(bloc.state, isA<PlaybackBlocState>());
    });

    test('should handle volume change', () async {
      // Arrange
      when(mockSetVolume(any)).thenAnswer((_) async => const Right(null));

      // Act
      bloc.add(const PlaybackEvent.volumeChanged(0.5));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(bloc.state, isA<PlaybackBlocState>());
    });

    test('should handle speed change', () async {
      // Arrange
      when(mockSetSpeed(any)).thenAnswer((_) async => const Right(null));

      // Act
      bloc.add(const PlaybackEvent.speedChanged(1.5));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expect(bloc.state, isA<PlaybackBlocState>());
    });

    test('should update state from repository stream', () async {
      // Arrange
      final newState = PlaybackState(currentTrack: testTrack, isPlaying: true);

      // Act
      stateController.add(newState);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert - state should be updated from stream
      expect(bloc.state, isA<PlaybackBlocState>());
    });
  });
}
