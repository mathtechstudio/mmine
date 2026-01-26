import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

/// Data model for [AudioTrack] that extends the domain entity.
///
/// This model provides conversion methods between the domain entity,
/// database representation, and data transfer objects. It serves as
/// the data layer implementation of the [AudioTrack] entity.
///
/// The model includes factory constructors for creating instances from:
/// - Domain entities ([fromEntity])
/// - Database records ([fromDatabase])
///
/// And methods for converting to:
/// - Domain entities ([toEntity])
class AudioTrackModel extends AudioTrack {
  /// Creates an [AudioTrackModel] instance.
  ///
  /// All parameters are passed to the parent [AudioTrack] constructor.
  const AudioTrackModel({
    required super.id,
    required super.filePath,
    required super.title,
    required super.artist,
    required super.album,
    super.albumArtist,
    super.year,
    super.genre,
    super.trackNumber,
    required super.duration,
    required super.format,
    required super.bitDepth,
    required super.sampleRate,
    required super.fileSize,
    super.albumArtPath,
    required super.dateAdded,
  });

  /// Creates an [AudioTrackModel] from a domain [AudioTrack] entity.
  ///
  /// This factory constructor is used to convert a domain entity to a
  /// data model, typically when preparing data for storage or transmission.
  factory AudioTrackModel.fromEntity(AudioTrack track) {
    return AudioTrackModel(
      id: track.id,
      filePath: track.filePath,
      title: track.title,
      artist: track.artist,
      album: track.album,
      albumArtist: track.albumArtist,
      year: track.year,
      genre: track.genre,
      trackNumber: track.trackNumber,
      duration: track.duration,
      format: track.format,
      bitDepth: track.bitDepth,
      sampleRate: track.sampleRate,
      fileSize: track.fileSize,
      albumArtPath: track.albumArtPath,
      dateAdded: track.dateAdded,
    );
  }

  /// Creates an [AudioTrackModel] from a database [Track] record.
  ///
  /// This factory constructor converts a Drift database record into an
  /// [AudioTrackModel]. It handles type conversions including:
  /// - Duration from milliseconds
  /// - Audio format from string
  /// - DateTime from milliseconds since epoch
  ///
  /// Throws an [Exception] if the audio format string is not recognized.
  factory AudioTrackModel.fromDatabase(Track track) {
    return AudioTrackModel(
      id: track.id,
      filePath: track.filePath,
      title: track.title,
      artist: track.artist,
      album: track.album,
      albumArtist: track.albumArtist,
      year: track.year,
      genre: track.genre,
      trackNumber: track.trackNumber,
      duration: Duration(milliseconds: track.durationMs),
      format: _parseAudioFormat(track.format),
      bitDepth: track.bitDepth,
      sampleRate: track.sampleRate,
      fileSize: track.fileSize,
      albumArtPath: track.albumArtPath,
      dateAdded: DateTime.fromMillisecondsSinceEpoch(track.dateAdded),
    );
  }

  /// Parses an audio format string into an [AudioFormat] enum value.
  ///
  /// Supported format strings (case-insensitive):
  /// - 'flac' -> [AudioFormat.flac]
  /// - 'wav' -> [AudioFormat.wav]
  /// - 'alac' -> [AudioFormat.alac]
  ///
  /// Throws an [Exception] if the format string is not recognized.
  static AudioFormat _parseAudioFormat(String format) {
    switch (format.toLowerCase()) {
      case 'flac':
        return AudioFormat.flac;
      case 'wav':
        return AudioFormat.wav;
      case 'alac':
        return AudioFormat.alac;
      default:
        throw Exception('Unknown audio format: $format');
    }
  }

  /// Converts this model to a domain [AudioTrack] entity.
  ///
  /// This method is used to convert the data model back to a domain entity,
  /// typically when retrieving data from storage for use in business logic.
  AudioTrack toEntity() {
    return AudioTrack(
      id: id,
      filePath: filePath,
      title: title,
      artist: artist,
      album: album,
      albumArtist: albumArtist,
      year: year,
      genre: genre,
      trackNumber: trackNumber,
      duration: duration,
      format: format,
      bitDepth: bitDepth,
      sampleRate: sampleRate,
      fileSize: fileSize,
      albumArtPath: albumArtPath,
      dateAdded: dateAdded,
    );
  }
}
