import 'package:equatable/equatable.dart';

/// Represents the audio format of a track.
///
/// Supported formats:
/// - [flac]: Free Lossless Audio Codec
/// - [wav]: Waveform Audio File Format
/// - [alac]: Apple Lossless Audio Codec
enum AudioFormat { flac, wav, alac }

/// Represents an audio track with its metadata and quality information.
///
/// This entity contains all the information about a single audio track,
/// including its metadata (title, artist, album), technical specifications
/// (format, bit depth, sample rate), and file information.
///
/// The class extends [Equatable] to enable value-based equality comparison.
class AudioTrack extends Equatable {
  final String id;
  final String filePath;
  final String title;
  final String artist;
  final String album;
  final String? albumArtist;
  final int? year;
  final String? genre;
  final int? trackNumber;
  final Duration duration;
  final AudioFormat format;
  final int bitDepth;
  final int sampleRate;
  final int fileSize;
  final String? albumArtPath;
  final DateTime dateAdded;

  /// Creates an [AudioTrack] instance.
  ///
  /// All required fields must be provided. Optional fields include
  /// [albumArtist], [year], [genre], [trackNumber], and [albumArtPath].
  const AudioTrack({
    required this.id,
    required this.filePath,
    required this.title,
    required this.artist,
    required this.album,
    this.albumArtist,
    this.year,
    this.genre,
    this.trackNumber,
    required this.duration,
    required this.format,
    required this.bitDepth,
    required this.sampleRate,
    required this.fileSize,
    this.albumArtPath,
    required this.dateAdded,
  });

  @override
  List<Object?> get props => [
    id,
    filePath,
    title,
    artist,
    album,
    albumArtist,
    year,
    genre,
    trackNumber,
    duration,
    format,
    bitDepth,
    sampleRate,
    fileSize,
    albumArtPath,
    dateAdded,
  ];

  /// Creates a copy of this [AudioTrack] with the given fields replaced
  /// with new values.
  ///
  /// Returns a new [AudioTrack] instance with updated values for the
  /// specified fields. Fields not provided will retain their original values.
  AudioTrack copyWith({
    String? id,
    String? filePath,
    String? title,
    String? artist,
    String? album,
    String? albumArtist,
    int? year,
    String? genre,
    int? trackNumber,
    Duration? duration,
    AudioFormat? format,
    int? bitDepth,
    int? sampleRate,
    int? fileSize,
    String? albumArtPath,
    DateTime? dateAdded,
  }) {
    return AudioTrack(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArtist: albumArtist ?? this.albumArtist,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      trackNumber: trackNumber ?? this.trackNumber,
      duration: duration ?? this.duration,
      format: format ?? this.format,
      bitDepth: bitDepth ?? this.bitDepth,
      sampleRate: sampleRate ?? this.sampleRate,
      fileSize: fileSize ?? this.fileSize,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}
