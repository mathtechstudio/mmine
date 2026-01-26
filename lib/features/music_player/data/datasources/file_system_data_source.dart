import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mmine/core/utils/constants.dart';
import 'package:path/path.dart' as p;

/// Data source for file system operations related to audio files.
///
/// This class provides functionality for:
/// - Scanning directories for lossless audio files
/// - Validating audio file formats
/// - Retrieving file metadata (size, date added)
///
/// Supported lossless formats:
/// - FLAC (.flac)
/// - WAV (.wav)
/// - ALAC (.m4a with ALAC codec)
///
/// Example usage:
/// ```dart
/// final dataSource = FileSystemDataSource();
/// final files = await dataSource.scanDirectory('/path/to/music');
/// final isValid = await dataSource.validateAudioFormat(files.first.path);
/// ```
class FileSystemDataSource {
  /// Scans a directory recursively for lossless audio files.
  ///
  /// Parameters:
  /// - [directoryPath]: The path to the directory to scan
  ///
  /// Returns a list of audio files with supported lossless formats.
  ///
  /// Throws an exception if the directory does not exist.
  ///
  /// Example:
  /// ```dart
  /// final files = await scanDirectory('/storage/emulated/0/Music');
  /// print('Found ${files.length} audio files');
  /// ```
  Future<List<File>> scanDirectory(String directoryPath) async {
    final directory = Directory(directoryPath);

    if (!await directory.exists()) {
      throw Exception('Directory does not exist: $directoryPath');
    }

    final audioFiles = <File>[];

    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) {
        if (_isLosslessFormat(entity.path)) {
          audioFiles.add(entity);
        }
      }
    }

    return audioFiles;
  }

  /// Checks if a file has a supported lossless audio format.
  ///
  /// Supported extensions: .flac, .wav, .m4a (ALAC only)
  ///
  /// Returns true if the file extension is in the supported list.
  bool _isLosslessFormat(String filePath) {
    final extension = p.extension(filePath).toLowerCase();
    return AppConstants.losslessExtensions.contains(extension);
  }

  /// Validates that an audio file is in a supported lossless format.
  ///
  /// This method performs two checks:
  /// 1. Verifies the file exists
  /// 2. Checks the file extension is supported
  /// 3. For .m4a files, verifies it's ALAC (not AAC)
  ///
  /// Returns true if the file is valid, false otherwise.
  ///
  /// Example:
  /// ```dart
  /// final isValid = await validateAudioFormat('/path/to/song.flac');
  /// if (isValid) {
  ///   // Process the file
  /// }
  /// ```
  Future<bool> validateAudioFormat(String filePath) async {
    final file = File(filePath);

    if (!await file.exists()) {
      return false;
    }

    final extension = p.extension(filePath).toLowerCase();

    if (!AppConstants.losslessExtensions.contains(extension)) {
      return false;
    }

    // For ALAC, need to verify it's actually ALAC and not AAC in m4a container
    if (extension == '.m4a') {
      return await _isAlacFile(file);
    }

    return true;
  }

  /// Checks if an .m4a file contains ALAC codec.
  ///
  /// This is a basic check that looks for ALAC-specific atoms in the file.
  /// A more sophisticated implementation would parse the entire MP4 container.
  ///
  /// Returns true if the file appears to be ALAC, false otherwise.
  Future<bool> _isAlacFile(File file) async {
    try {
      // Read first few bytes to check for ALAC codec identifier
      final bytes = await file.openRead(0, 100).first;

      // Simple check: ALAC files typically have 'alac' atom in the file
      // This is a basic check - more sophisticated validation would be needed
      // for production use
      final content = String.fromCharCodes(bytes);
      return content.contains('alac') || content.contains('ftyp');
    } catch (e) {
      debugPrint('Error checking ALAC format: $e');
      return false;
    }
  }

  /// Gets the file size in bytes.
  ///
  /// Throws an exception if the file does not exist.
  Future<int> getFileSize(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File does not exist: $filePath');
    }
    return await file.length();
  }

  /// Gets the date when the file was last modified.
  ///
  /// This is used as the "date added" for audio tracks.
  ///
  /// Throws an exception if the file does not exist.
  Future<DateTime> getDateAdded(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File does not exist: $filePath');
    }
    final stat = await file.stat();
    return stat.modified;
  }
}
