import 'package:equatable/equatable.dart';

enum AudioFormat { flac, wav, alac }

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
