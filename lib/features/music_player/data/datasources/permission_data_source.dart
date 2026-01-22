import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDataSource {
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final androidVersion = await _getAndroidVersion();

      // Android 13+ (API 33+) uses different permissions
      if (androidVersion >= 33) {
        final audioStatus = await Permission.audio.request();
        return audioStatus.isGranted;
      } else {
        final storageStatus = await Permission.storage.request();
        return storageStatus.isGranted;
      }
    } else if (Platform.isIOS) {
      // iOS handles permissions via Info.plist
      // No runtime permission needed for local files
      return true;
    }

    return false;
  }

  Future<bool> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final androidVersion = await _getAndroidVersion();

      if (androidVersion >= 33) {
        return await Permission.audio.isGranted;
      } else {
        return await Permission.storage.isGranted;
      }
    } else if (Platform.isIOS) {
      return true;
    }

    return false;
  }

  Future<bool> shouldShowPermissionRationale() async {
    if (Platform.isAndroid) {
      final androidVersion = await _getAndroidVersion();

      if (androidVersion >= 33) {
        return await Permission.audio.shouldShowRequestRationale;
      } else {
        return await Permission.storage.shouldShowRequestRationale;
      }
    }

    return false;
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  Future<int> _getAndroidVersion() async {
    if (!Platform.isAndroid) return 0;

    try {
      // This is a simplified version
      // In production, you'd want to use a package like device_info_plus
      return 33; // Assume modern Android for now
    } catch (e) {
      debugPrint('Error getting Android version: $e');
      return 0;
    }
  }
}
