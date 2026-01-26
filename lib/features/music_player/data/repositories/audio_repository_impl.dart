import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/data/datasources/file_system_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/local_database_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/metadata_data_source.dart';
import 'package:mmine/features/music_player/data/datasources/permission_data_source.dart';
import 'package:mmine/features/music_player/data/models/audio_track_model.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';
import 'package:mmine/features/music_player/domain/repositories/audio_repository.dart';
import 'package:uuid/uuid.dart';

/// Implementation of [AudioRepository] that manages audio library operations.
///
/// This class coordinates between multiple data sources to provide a complete
/// audio library management solution:
/// - [FileSystemDataSource]: Scans directories for audio files
/// - [MetadataDataSource]: Extracts metadata from audio files
/// - [LocalDatabaseDataSource]: Stores and retrieves tracks from database
/// - [PermissionDataSource]: Handles storage permissions
///
/// The implementation handles:
/// - Permission checking and requesting
/// - Batch processing of files for performance
/// - Error handling and failure reporting
/// - Metadata extraction with fallbacks
class AudioRepositoryImpl implements AudioRepository {
  final FileSystemDataSource fileSystemDataSource;
  final MetadataDataSource metadataDataSource;
  final LocalDatabaseDataSource databaseDataSource;
  final PermissionDataSource permissionDataSource;
  final _uuid = const Uuid();

  /// Creates an [AudioRepositoryImpl] with the required data sources.
  AudioRepositoryImpl({
    required this.fileSystemDataSource,
    required this.metadataDataSource,
    required this.databaseDataSource,
    required this.permissionDataSource,
  });

  @override
  Future<Either<Failure, List<AudioTrack>>> scanDirectory(String path) async {
    try {
      // Check permissions
      final hasPermission = await permissionDataSource.checkStoragePermission();
      if (!hasPermission) {
        final granted = await permissionDataSource.requestStoragePermission();
        if (!granted) {
          return const Left(
            PermissionDeniedFailure('Storage permission denied'),
          );
        }
      }

      // Scan directory for audio files
      final files = await fileSystemDataSource.scanDirectory(path);

      if (files.isEmpty) {
        return const Right([]);
      }

      // Get existing file paths to prevent duplicates
      final existingTracks = await databaseDataSource.getAllTracks();
      final existingPaths = existingTracks.map((t) => t.filePath).toSet();

      // Process files in batches to avoid blocking
      final tracks = <AudioTrackModel>[];
      int skippedDuplicates = 0;

      for (final file in files) {
        try {
          // Skip if already in library
          if (existingPaths.contains(file.path)) {
            skippedDuplicates++;
            debugPrint('Skipping duplicate: ${file.path}');
            continue;
          }

          // Validate format
          final isValid = await fileSystemDataSource.validateAudioFormat(
            file.path,
          );

          if (!isValid) {
            debugPrint('Skipping invalid format: ${file.path}');
            continue;
          }

          // Extract metadata
          final metadata = await metadataDataSource.extractMetadata(file.path);

          // Get file info
          final fileSize = await fileSystemDataSource.getFileSize(file.path);
          final dateAdded = await fileSystemDataSource.getDateAdded(file.path);

          // Save album art if available
          String? albumArtPath;
          if (metadata['albumArt'] != null) {
            albumArtPath = await metadataDataSource.extractAndSaveAlbumArt(
              file.path,
              metadata['albumArt'] as Uint8List?,
            );
          }

          // Create track model
          final track = AudioTrackModel(
            id: _uuid.v4(),
            filePath: file.path,
            title: metadata['title'] as String,
            artist: metadata['artist'] as String,
            album: metadata['album'] as String,
            albumArtist: metadata['albumArtist'] as String?,
            year: metadata['year'] as int?,
            genre: metadata['genre'] as String?,
            trackNumber: metadata['trackNumber'] as int?,
            duration: metadata['duration'] as Duration,
            format: metadataDataSource.getAudioFormat(file.path),
            bitDepth: metadata['bitDepth'] as int,
            sampleRate: metadata['sampleRate'] as int,
            fileSize: fileSize,
            albumArtPath: albumArtPath,
            dateAdded: dateAdded,
          );

          tracks.add(track);
        } catch (e) {
          debugPrint('Error processing file ${file.path}: $e');
          continue;
        }
      }

      // Save to database
      if (tracks.isNotEmpty) {
        await databaseDataSource.insertTracks(tracks);
      }

      debugPrint(
        'Scan complete: ${tracks.length} new tracks added, $skippedDuplicates duplicates skipped',
      );

      return Right(tracks.map((t) => t.toEntity()).toList());
    } on PermissionDeniedFailure catch (e) {
      return Left(e);
    } catch (e) {
      debugPrint('Error scanning directory: $e');
      return Left(UnknownFailure('Failed to scan directory: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AudioTrack>>> getAllTracks() async {
    try {
      final tracks = await databaseDataSource.getAllTracks();
      final trackModels = tracks
          .map((t) => AudioTrackModel.fromDatabase(t).toEntity())
          .toList();
      return Right(trackModels);
    } catch (e) {
      debugPrint('Error getting all tracks: $e');
      return Left(DatabaseFailure('Failed to get tracks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AudioTrack>>> getTracksByArtist(
    String artist,
  ) async {
    try {
      final tracks = await databaseDataSource.getTracksByArtist(artist);
      final trackModels = tracks
          .map((t) => AudioTrackModel.fromDatabase(t).toEntity())
          .toList();
      return Right(trackModels);
    } catch (e) {
      debugPrint('Error getting tracks by artist: $e');
      return Left(DatabaseFailure('Failed to get tracks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AudioTrack>>> getTracksByAlbum(
    String album,
  ) async {
    try {
      final tracks = await databaseDataSource.getTracksByAlbum(album);
      final trackModels = tracks
          .map((t) => AudioTrackModel.fromDatabase(t).toEntity())
          .toList();
      return Right(trackModels);
    } catch (e) {
      debugPrint('Error getting tracks by album: $e');
      return Left(DatabaseFailure('Failed to get tracks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AudioTrack>> getTrackById(String id) async {
    try {
      final track = await databaseDataSource.getTrackById(id);

      if (track == null) {
        return const Left(FileNotFoundFailure('Track not found'));
      }

      return Right(AudioTrackModel.fromDatabase(track).toEntity());
    } catch (e) {
      debugPrint('Error getting track by id: $e');
      return Left(DatabaseFailure('Failed to get track: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllArtists() async {
    try {
      final artists = await databaseDataSource.getAllArtists();
      return Right(artists);
    } catch (e) {
      debugPrint('Error getting all artists: $e');
      return Left(DatabaseFailure('Failed to get artists: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAllAlbums() async {
    try {
      final albums = await databaseDataSource.getAllAlbums();
      return Right(albums);
    } catch (e) {
      debugPrint('Error getting all albums: $e');
      return Left(DatabaseFailure('Failed to get albums: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<AudioTrack>>> searchTracks(String query) async {
    try {
      final tracks = await databaseDataSource.searchTracks(query);
      final trackModels = tracks
          .map((t) => AudioTrackModel.fromDatabase(t).toEntity())
          .toList();
      return Right(trackModels);
    } catch (e) {
      debugPrint('Error searching tracks: $e');
      return Left(DatabaseFailure('Failed to search tracks: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTrack(String id) async {
    try {
      await databaseDataSource.deleteTrack(id);
      return const Right(null);
    } catch (e) {
      debugPrint('Error deleting track: $e');
      return Left(DatabaseFailure('Failed to delete track: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> clearLibrary() async {
    try {
      await databaseDataSource.clearAllTracks();
      return const Right(null);
    } catch (e) {
      debugPrint('Error clearing library: $e');
      return Left(DatabaseFailure('Failed to clear library: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AudioTrack?>> addSingleFile(String filePath) async {
    try {
      // Check permissions
      final hasPermission = await permissionDataSource.checkStoragePermission();
      if (!hasPermission) {
        final granted = await permissionDataSource.requestStoragePermission();
        if (!granted) {
          return const Left(
            PermissionDeniedFailure('Storage permission denied'),
          );
        }
      }

      // Check if file already exists in library
      final existingTracks = await databaseDataSource.getAllTracks();
      final existingPaths = existingTracks.map((t) => t.filePath).toSet();

      if (existingPaths.contains(filePath)) {
        debugPrint('File already in library: $filePath');
        return const Right(null);
      }

      // Validate format
      final isValid = await fileSystemDataSource.validateAudioFormat(filePath);
      if (!isValid) {
        return const Left(InvalidFormatFailure('Unsupported audio format'));
      }

      // Extract metadata
      final metadata = await metadataDataSource.extractMetadata(filePath);

      // Get file info
      final fileSize = await fileSystemDataSource.getFileSize(filePath);
      final dateAdded = await fileSystemDataSource.getDateAdded(filePath);

      // Save album art if available
      String? albumArtPath;
      if (metadata['albumArt'] != null) {
        albumArtPath = await metadataDataSource.extractAndSaveAlbumArt(
          filePath,
          metadata['albumArt'] as Uint8List?,
        );
      }

      // Create track model
      final track = AudioTrackModel(
        id: _uuid.v4(),
        filePath: filePath,
        title: metadata['title'] as String,
        artist: metadata['artist'] as String,
        album: metadata['album'] as String,
        albumArtist: metadata['albumArtist'] as String?,
        year: metadata['year'] as int?,
        genre: metadata['genre'] as String?,
        trackNumber: metadata['trackNumber'] as int?,
        duration: metadata['duration'] as Duration,
        format: metadataDataSource.getAudioFormat(filePath),
        bitDepth: metadata['bitDepth'] as int,
        sampleRate: metadata['sampleRate'] as int,
        fileSize: fileSize,
        albumArtPath: albumArtPath,
        dateAdded: dateAdded,
      );

      // Save to database
      await databaseDataSource.insertTracks([track]);

      debugPrint('Successfully added file to library: $filePath');

      return Right(track.toEntity());
    } on PermissionDeniedFailure catch (e) {
      return Left(e);
    } catch (e) {
      debugPrint('Error adding single file: $e');
      return Left(UnknownFailure('Failed to add file: ${e.toString()}'));
    }
  }
}
