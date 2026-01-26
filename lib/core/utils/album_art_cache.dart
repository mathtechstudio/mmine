import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Cache manager for album artwork images.
///
/// This singleton class provides a two-tier caching system for album art:
/// - Memory cache: Fast access for recently used images (max 50 items)
/// - Disk cache: Persistent storage in application documents directory
///
/// The cache automatically manages memory by removing oldest entries when
/// the limit is reached. Disk cache persists between app sessions.
///
/// Example usage:
/// ```dart
/// final cache = AlbumArtCache();
///
/// // Store album art
/// await cache.put(trackId, imageBytes);
///
/// // Retrieve album art
/// final bytes = await cache.get(trackId);
///
/// // Clear all cached images
/// await cache.clear();
/// ```
class AlbumArtCache {
  static final AlbumArtCache _instance = AlbumArtCache._internal();

  /// Returns the singleton instance of [AlbumArtCache].
  factory AlbumArtCache() => _instance;

  AlbumArtCache._internal();

  final Map<String, Uint8List> _memoryCache = {};
  static const int _maxMemoryCacheSize = 50;

  /// Gets the directory path for disk cache storage.
  ///
  /// Creates the directory if it doesn't exist.
  Future<String> getCacheDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(p.join(appDir.path, 'album_art_cache'));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir.path;
  }

  /// Generates a safe cache key from a track ID.
  ///
  /// Removes special characters to create a valid filename.
  String _getCacheKey(String trackId) {
    return trackId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  }

  /// Retrieves album art for the given track ID.
  ///
  /// Checks memory cache first, then disk cache. Returns null if not found.
  Future<Uint8List?> get(String trackId) async {
    // Check memory cache first
    if (_memoryCache.containsKey(trackId)) {
      return _memoryCache[trackId];
    }

    // Check disk cache
    final cacheDir = await getCacheDirectory();
    final cacheKey = _getCacheKey(trackId);
    final file = File(p.join(cacheDir, '$cacheKey.jpg'));

    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      _addToMemoryCache(trackId, bytes);
      return bytes;
    }

    return null;
  }

  /// Stores album art for the given track ID.
  ///
  /// Saves to both memory and disk cache.
  Future<void> put(String trackId, Uint8List data) async {
    // Save to memory cache
    _addToMemoryCache(trackId, data);

    // Save to disk cache
    final cacheDir = await getCacheDirectory();
    final cacheKey = _getCacheKey(trackId);
    final file = File(p.join(cacheDir, '$cacheKey.jpg'));
    await file.writeAsBytes(data);
  }

  /// Adds an image to the memory cache.
  ///
  /// Removes the oldest entry if cache is full.
  void _addToMemoryCache(String trackId, Uint8List data) {
    if (_memoryCache.length >= _maxMemoryCacheSize) {
      // Remove oldest entry
      final firstKey = _memoryCache.keys.first;
      _memoryCache.remove(firstKey);
    }
    _memoryCache[trackId] = data;
  }

  /// Clears all cached album art from memory and disk.
  Future<void> clear() async {
    _memoryCache.clear();
    final cacheDir = await getCacheDirectory();
    final dir = Directory(cacheDir);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  /// Calculates the total size of the disk cache in bytes.
  ///
  /// Returns 0 if cache directory doesn't exist.
  Future<int> getCacheSize() async {
    final cacheDir = await getCacheDirectory();
    final dir = Directory(cacheDir);
    if (!await dir.exists()) return 0;

    int totalSize = 0;
    await for (final entity in dir.list(recursive: true)) {
      if (entity is File) {
        totalSize += await entity.length();
      }
    }
    return totalSize;
  }
}
