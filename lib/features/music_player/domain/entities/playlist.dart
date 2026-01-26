import 'package:equatable/equatable.dart';

/// Represents a user-created playlist containing a collection of tracks.
///
/// A playlist is an ordered collection of track IDs that allows users to
/// organize their music. It includes metadata about when it was created
/// and last updated.
///
/// The class extends [Equatable] to enable value-based equality comparison.
class Playlist extends Equatable {
  final String id;
  final String name;
  final List<String> trackIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Creates a [Playlist] instance.
  ///
  /// All fields are required. The [trackIds] list contains the IDs of tracks
  /// in the order they appear in the playlist.
  const Playlist({
    required this.id,
    required this.name,
    required this.trackIds,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, trackIds, createdAt, updatedAt];

  /// Creates a copy of this [Playlist] with the given fields replaced
  /// with new values.
  ///
  /// Returns a new [Playlist] instance with updated values for the
  /// specified fields. Fields not provided will retain their original values.
  Playlist copyWith({
    String? id,
    String? name,
    List<String>? trackIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      trackIds: trackIds ?? this.trackIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Returns the number of tracks in this playlist.
  int get trackCount => trackIds.length;
}
