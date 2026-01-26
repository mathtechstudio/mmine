import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

/// Repository interface for managing audio tracks and library operations.
///
/// This abstract class defines the contract for audio-related data operations,
/// including scanning directories for audio files, retrieving tracks by various
/// criteria, and managing the music library.
///
/// All methods return [Either] with [Failure] on the left for errors and
/// the expected result on the right for success.
///
/// Implementations of this interface should handle:
/// - File system operations for scanning directories
/// - Database operations for storing and retrieving tracks
/// - Metadata extraction from audio files
/// - Error handling and failure reporting
abstract class AudioRepository {
  /// Scans a directory for audio files and adds them to the library.
  ///
  /// Returns a list of [AudioTrack]s found in the specified [path].
  /// Only supported audio formats (FLAC, WAV, ALAC) are included.
  Future<Either<Failure, List<AudioTrack>>> scanDirectory(String path);

  /// Retrieves all tracks from the library.
  ///
  /// Returns a list of all [AudioTrack]s stored in the database.
  Future<Either<Failure, List<AudioTrack>>> getAllTracks();

  /// Retrieves all tracks by a specific artist.
  ///
  /// Returns a list of [AudioTrack]s where the artist field matches [artist].
  Future<Either<Failure, List<AudioTrack>>> getTracksByArtist(String artist);

  /// Retrieves all tracks from a specific album.
  ///
  /// Returns a list of [AudioTrack]s where the album field matches [album].
  Future<Either<Failure, List<AudioTrack>>> getTracksByAlbum(String album);

  /// Retrieves a single track by its ID.
  ///
  /// Returns the [AudioTrack] with the specified [id], or a [Failure]
  /// if the track is not found.
  Future<Either<Failure, AudioTrack>> getTrackById(String id);

  /// Retrieves a list of all unique artists in the library.
  ///
  /// Returns a list of artist names, sorted alphabetically.
  Future<Either<Failure, List<String>>> getAllArtists();

  /// Retrieves a list of all unique albums in the library.
  ///
  /// Returns a list of album names, sorted alphabetically.
  Future<Either<Failure, List<String>>> getAllAlbums();

  /// Searches for tracks matching the given query.
  ///
  /// Searches across track title, artist, and album fields.
  /// Returns a list of matching [AudioTrack]s.
  Future<Either<Failure, List<AudioTrack>>> searchTracks(String query);

  /// Deletes a track from the library.
  ///
  /// Removes the track with the specified [id] from the database.
  /// Does not delete the actual audio file from the file system.
  Future<Either<Failure, void>> deleteTrack(String id);

  /// Clears all tracks from the library.
  ///
  /// Removes all tracks from the database. This operation cannot be undone.
  /// Does not delete the actual audio files from the file system.
  Future<Either<Failure, void>> clearLibrary();
}
