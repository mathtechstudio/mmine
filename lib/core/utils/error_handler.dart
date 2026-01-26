import 'dart:async';

import 'package:flutter/material.dart';

/// Utility class for handling and displaying errors in the application.
///
/// Provides methods for:
/// - Showing error dialogs with optional retry actions
/// - Displaying error snackbars
/// - Logging errors with context
/// - Converting technical errors to user-friendly messages
///
/// Example usage:
/// ```dart
/// try {
///   await someOperation();
/// } catch (e, stackTrace) {
///   ErrorHandler.logError('Operation', e, stackTrace);
///   ErrorHandler.showErrorSnackBar(context,
///     ErrorHandler.getUserFriendlyMessage(e));
/// }
/// ```
class ErrorHandler {
  /// Shows an error dialog with title, message, and optional retry action.
  ///
  /// Parameters:
  /// - [context]: Build context for showing the dialog
  /// - [title]: Dialog title
  /// - [message]: Error message to display
  /// - [onRetry]: Optional callback for retry button
  static void showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onRetry,
  }) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red[400]),
              const SizedBox(width: 8),
              Text(title),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            if (onRetry != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  onRetry();
                },
                child: const Text('Retry'),
              ),
          ],
        ),
      ),
    );
  }

  /// Shows an error snackbar at the bottom of the screen.
  ///
  /// Parameters:
  /// - [context]: Build context for showing the snackbar
  /// - [message]: Error message to display
  /// - [onRetry]: Optional callback for retry action
  static void showErrorSnackBar(
    BuildContext context,
    String message, {
    VoidCallback? onRetry,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red[700],
        duration: const Duration(seconds: 4),
        action: onRetry != null
            ? SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
      ),
    );
  }

  /// Logs an error with context information.
  ///
  /// Parameters:
  /// - [context]: Description of where the error occurred
  /// - [error]: The error object
  /// - [stackTrace]: Optional stack trace for debugging
  static void logError(
    String context,
    dynamic error, [
    StackTrace? stackTrace,
  ]) {
    debugPrint('ERROR [$context]: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// Converts technical error messages to user-friendly text.
  ///
  /// Analyzes the error and returns an appropriate message for common
  /// error types like permissions, network issues, file errors, etc.
  ///
  /// Returns a generic message if the error type is not recognized.
  static String getUserFriendlyMessage(dynamic error) {
    if (error == null) return 'An unknown error occurred';

    final errorString = error.toString().toLowerCase();

    if (errorString.contains('permission')) {
      return 'Permission denied. Please grant the required permissions.';
    } else if (errorString.contains('network') ||
        errorString.contains('connection')) {
      return 'Network error. Please check your internet connection.';
    } else if (errorString.contains('file not found') ||
        errorString.contains('no such file')) {
      return 'File not found. The file may have been moved or deleted.';
    } else if (errorString.contains('timeout')) {
      return 'Operation timed out. Please try again.';
    } else if (errorString.contains('format') ||
        errorString.contains('unsupported')) {
      return 'Unsupported file format.';
    } else if (errorString.contains('corrupted') ||
        errorString.contains('invalid')) {
      return 'File is corrupted or invalid.';
    } else if (errorString.contains('storage') ||
        errorString.contains('space')) {
      return 'Insufficient storage space.';
    }

    return 'An error occurred: ${error.toString()}';
  }
}
