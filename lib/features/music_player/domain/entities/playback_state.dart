import 'package:equatable/equatable.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

enum RepeatMode { off, all, one }

class PlaybackState extends Equatable {
  final AudioTrack? currentTrack;
  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final bool isBuffering;
  final double volume;
  final double speed;
  final RepeatMode repeatMode;
  final bool shuffleEnabled;
  final List<AudioTrack> queue;
  final int currentIndex;

  const PlaybackState({
    this.currentTrack,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.isPlaying = false,
    this.isBuffering = false,
    this.volume = 1.0,
    this.speed = 1.0,
    this.repeatMode = RepeatMode.off,
    this.shuffleEnabled = false,
    this.queue = const [],
    this.currentIndex = 0,
  });

  @override
  List<Object?> get props => [
    currentTrack,
    position,
    duration,
    isPlaying,
    isBuffering,
    volume,
    speed,
    repeatMode,
    shuffleEnabled,
    queue,
    currentIndex,
  ];

  PlaybackState copyWith({
    AudioTrack? currentTrack,
    Duration? position,
    Duration? duration,
    bool? isPlaying,
    bool? isBuffering,
    double? volume,
    double? speed,
    RepeatMode? repeatMode,
    bool? shuffleEnabled,
    List<AudioTrack>? queue,
    int? currentIndex,
  }) {
    return PlaybackState(
      currentTrack: currentTrack ?? this.currentTrack,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      isBuffering: isBuffering ?? this.isBuffering,
      volume: volume ?? this.volume,
      speed: speed ?? this.speed,
      repeatMode: repeatMode ?? this.repeatMode,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  bool get hasNext => currentIndex < queue.length - 1;
  bool get hasPrevious => currentIndex > 0;
  bool get isEmpty => queue.isEmpty;
}
