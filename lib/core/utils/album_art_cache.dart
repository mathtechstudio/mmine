import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AlbumArtCache {
  static final AlbumArtCache _instance = AlbumArtCache._internal();
  factory AlbumArtCache() => _instance;
  AlbumArtCache._internal();

  final Map<String, Uint8List> _memoryCache = {};
  static const int _maxMemoryCacheSize = 50;

  Future<String> getCacheDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory(p.join(appDir.path, 'album_art_cache'));
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir.path;
  }

  String _getCacheKey(String trackId) {
    return trackId.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  }

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

  Future<void> put(String trackId, Uint8List data) async {
    // Save to memory cache
    _addToMemoryCache(trackId, data);

    // Save to disk cache
    final cacheDir = await getCacheDirectory();
    final cacheKey = _getCacheKey(trackId);
    final file = File(p.join(cacheDir, '$cacheKey.jpg'));
    await file.writeAsBytes(data);
  }

  void _addToMemoryCache(String trackId, Uint8List data) {
    if (_memoryCache.length >= _maxMemoryCacheSize) {
      // Remove oldest entry
      final firstKey = _memoryCache.keys.first;
      _memoryCache.remove(firstKey);
    }
    _memoryCache[trackId] = data;
  }

  Future<void> clear() async {
    _memoryCache.clear();
    final cacheDir = await getCacheDirectory();
    final dir = Directory(cacheDir);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

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
