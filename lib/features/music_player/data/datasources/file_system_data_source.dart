import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mmine/core/utils/constants.dart';
import 'package:path/path.dart' as p;

class FileSystemDataSource {
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

  bool _isLosslessFormat(String filePath) {
    final extension = p.extension(filePath).toLowerCase();
    return AppConstants.losslessExtensions.contains(extension);
  }

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

  Future<int> getFileSize(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File does not exist: $filePath');
    }
    return await file.length();
  }

  Future<DateTime> getDateAdded(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) {
      throw Exception('File does not exist: $filePath');
    }
    final stat = await file.stat();
    return stat.modified;
  }
}
