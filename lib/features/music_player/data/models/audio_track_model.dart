import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

class AudioTrackModel extends AudioTrack {
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
