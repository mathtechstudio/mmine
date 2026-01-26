import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

/// Data source for handling storage and media permissions.
///
/// This class manages runtime permissions required for accessing audio files
/// on the device. It handles different permission models for different
/// Android versions and iOS.
///
/// Android 13+ (API 33+) uses granular media permissions (audio, images, video)
/// while older Android versions use the storage permission.
///
/// iOS handles file access permissions through Info.plist declarations.
class PermissionDataSource {
  /// Requests storage/media permission from the user.
  ///
  /// On Android 13+ (API 33+), requests the audio permission.
  /// On older Android versions, requests the storage permission.
  /// On iOS, returns true immediately as permissions are handled via Info.plist.
  ///
  /// Returns true if permission is granted, false otherwise.
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

  /// Checks if storage/media permission is currently granted.
  ///
  /// Returns true if the required permission is already granted,
  /// false otherwise. Does not request permission if not granted.
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

  /// Checks if the app should show a permission rationale to the user.
  ///
  /// Returns true if the user has previously denied the permission and
  /// the system recommends showing an explanation before requesting again.
  ///
  /// This is useful for providing context to users about why the permission
  /// is needed before showing the system permission dialog.
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

  /// Opens the app's settings page in the system settings.
  ///
  /// This is useful when the user has permanently denied a permission
  /// and needs to manually enable it in settings.
  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  /// Gets the Android API version.
  ///
  /// Returns the Android API level, or 0 if not on Android or if
  /// the version cannot be determined.
  ///
  /// Note: This is a simplified implementation. In production, use
  /// the device_info_plus package for accurate version detection.
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
