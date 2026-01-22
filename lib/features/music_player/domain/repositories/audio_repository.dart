import 'package:dartz/dartz.dart';
import 'package:mmine/core/error/failures.dart';
import 'package:mmine/features/music_player/domain/entities/audio_track.dart';

abstract class AudioRepository {
  Future<Either<Failure, List<AudioTrack>>> scanDirectory(String path);
  Future<Either<Failure, List<AudioTrack>>> getAllTracks();
  Future<Either<Failure, List<AudioTrack>>> getTracksByArtist(String artist);
  Future<Either<Failure, List<AudioTrack>>> getTracksByAlbum(String album);
  Future<Either<Failure, AudioTrack>> getTrackById(String id);
  Future<Either<Failure, List<String>>> getAllArtists();
  Future<Either<Failure, List<String>>> getAllAlbums();
  Future<Either<Failure, List<AudioTrack>>> searchTracks(String query);
  Future<Either<Failure, void>> deleteTrack(String id);
  Future<Either<Failure, void>> clearLibrary();
}
