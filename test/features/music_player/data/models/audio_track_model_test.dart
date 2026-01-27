import 'package:flutter_test/flutter_test.dart';
import 'package:mmine/features/music_player/data/datasources/database.dart';
import 'package:mmine/features/music_player/data/models/audio_track_model.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

void main() {
  group('AudioTrackModel', () {
    final now = DateTime.now();
    final testTrack = AudioTrack(
      id: '1',
      title: 'Test Song',
      artist: 'Test Artist',
      album: 'Test Album',
      filePath: '/path/to/song.flac',
      duration: const Duration(minutes: 3, seconds: 30),
      format: AudioFormat.flac,
      bitDepth: 24,
      sampleRate: 96000,
      fileSize: 10485760,
      dateAdded: now,
    );

    test('should create AudioTrackModel from entity', () {
      // Act
      final model = AudioTrackModel.fromEntity(testTrack);

      // Assert
      expect(model.id, testTrack.id);
      expect(model.title, testTrack.title);
      expect(model.artist, testTrack.artist);
      expect(model.album, testTrack.album);
      expect(model.format, testTrack.format);
    });

    test('should convert model to entity', () {
      // Arrange
      final model = AudioTrackModel(
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

      // Act
      final entity = model.toEntity();

      // Assert
      expect(entity.id, model.id);
      expect(entity.title, model.title);
      expect(entity.artist, model.artist);
      // ignore: unnecessary_type_check
      expect(entity is AudioTrack, true);
    });

    test('should create AudioTrackModel from database Track', () {
      // Arrange
      final dbTrack = Track(
        id: '1',
        filePath: '/path/to/song.flac',
        title: 'Test Song',
        artist: 'Test Artist',
        album: 'Test Album',
        durationMs: 210000,
        format: 'flac',
        bitDepth: 24,
        sampleRate: 96000,
        fileSize: 10485760,
        dateAdded: now.millisecondsSinceEpoch,
      );

      // Act
      final model = AudioTrackModel.fromDatabase(dbTrack);

      // Assert
      expect(model.id, dbTrack.id);
      expect(model.title, dbTrack.title);
      expect(model.artist, dbTrack.artist);
      expect(model.format, AudioFormat.flac);
      expect(model.duration.inMilliseconds, dbTrack.durationMs);
    });

    test('should parse FLAC format correctly', () {
      // Arrange
      final dbTrack = Track(
        id: '1',
        filePath: '/path/to/song.flac',
        title: 'Test',
        artist: 'Artist',
        album: 'Album',
        durationMs: 0,
        format: 'flac',
        bitDepth: 16,
        sampleRate: 44100,
        fileSize: 1000,
        dateAdded: now.millisecondsSinceEpoch,
      );

      // Act
      final model = AudioTrackModel.fromDatabase(dbTrack);

      // Assert
      expect(model.format, AudioFormat.flac);
    });

    test('should parse WAV format correctly', () {
      // Arrange
      final dbTrack = Track(
        id: '1',
        filePath: '/path/to/song.wav',
        title: 'Test',
        artist: 'Artist',
        album: 'Album',
        durationMs: 0,
        format: 'wav',
        bitDepth: 16,
        sampleRate: 44100,
        fileSize: 1000,
        dateAdded: now.millisecondsSinceEpoch,
      );

      // Act
      final model = AudioTrackModel.fromDatabase(dbTrack);

      // Assert
      expect(model.format, AudioFormat.wav);
    });

    test('should parse ALAC format correctly', () {
      // Arrange
      final dbTrack = Track(
        id: '1',
        filePath: '/path/to/song.m4a',
        title: 'Test',
        artist: 'Artist',
        album: 'Album',
        durationMs: 0,
        format: 'alac',
        bitDepth: 16,
        sampleRate: 44100,
        fileSize: 1000,
        dateAdded: now.millisecondsSinceEpoch,
      );

      // Act
      final model = AudioTrackModel.fromDatabase(dbTrack);

      // Assert
      expect(model.format, AudioFormat.alac);
    });

    test('should throw exception for unknown format', () {
      // Arrange
      final dbTrack = Track(
        id: '1',
        filePath: '/path/to/song.mp3',
        title: 'Test',
        artist: 'Artist',
        album: 'Album',
        durationMs: 0,
        format: 'mp3',
        bitDepth: 16,
        sampleRate: 44100,
        fileSize: 1000,
        dateAdded: now.millisecondsSinceEpoch,
      );

      // Act & Assert
      expect(() => AudioTrackModel.fromDatabase(dbTrack), throwsException);
    });
  });
}
