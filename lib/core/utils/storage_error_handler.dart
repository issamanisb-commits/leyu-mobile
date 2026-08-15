import 'dart:io';
import 'package:leyu_mobile/core/utils/message.dart';
import 'package:leyu_mobile/core/utils/storage_logger.dart';

/// Handles storage errors and provides user-facing error messages
class StorageErrorHandler {
  /// Handle storage initialization errors
  static void handleInitializationError(dynamic error) {
    StorageLogger.logStorageInitError(error);

    // Check if it's a storage space issue
    if (_isStorageSpaceError(error)) {
      showErrorMessage(
        'Low storage space detected. Some features may not work properly. Please free up space on your device.',
      );
    } else {
      showErrorMessage(
        'Failed to initialize local storage. Your work will be saved temporarily but may be lost if you close the app.',
      );
    }
  }

  /// Handle audio file save errors
  static void handleAudioSaveError(dynamic error, {bool showToUser = true}) {
    if (!showToUser) return;

    if (_isStorageSpaceError(error)) {
      showErrorMessage(
        'Not enough storage space to save recording. Please free up space on your device.',
      );
    } else if (_isPermissionError(error)) {
      showErrorMessage(
        'Permission denied. Please check app permissions in your device settings.',
      );
    } else {
      showErrorMessage(
        'Failed to save recording. Your recording is temporarily stored but may be lost if you close the app.',
      );
    }
  }

  /// Handle text output save errors
  static void handleTextSaveError(dynamic error, {bool showToUser = true}) {
    if (!showToUser) return;

    if (_isStorageSpaceError(error)) {
      showErrorMessage(
        'Not enough storage space to save text. Please free up space on your device.',
      );
    } else {
      showErrorMessage(
        'Failed to save text output. Your text is temporarily stored but may be lost if you close the app.',
      );
    }
  }

  /// Handle file deletion errors
  static void handleDeleteError(dynamic error, {bool showToUser = false}) {
    if (!showToUser) return;

    showErrorMessage(
      'Failed to delete file. You may need to manually clear app data in settings.',
    );
  }

  /// Handle data recovery scenarios
  static void handleDataRecovery(int audioCount, int textCount) {
    if (audioCount > 0 || textCount > 0) {
      showSuccessMessage(_buildRecoveryMessage(audioCount, textCount));
    }
  }

  /// Handle cleanup errors
  static void handleCleanupError(dynamic error, {bool showToUser = false}) {
    if (!showToUser) return;

    showErrorMessage(
      'Failed to clean up old files. This may use extra storage space.',
    );
  }

  /// Handle directory creation errors
  static void handleDirectoryCreationError(dynamic error,
      {bool showToUser = true}) {
    if (!showToUser) return;

    if (_isStorageSpaceError(error)) {
      showErrorMessage(
        'Not enough storage space. Please free up space on your device.',
      );
    } else if (_isPermissionError(error)) {
      showErrorMessage(
        'Permission denied. Please check app permissions in your device settings.',
      );
    } else {
      showErrorMessage(
        'Failed to create storage directory. Recordings will be saved temporarily.',
      );
    }
  }

  /// Handle submission cleanup errors
  static void handleSubmissionCleanupError(dynamic error) {
    // Don't show to user - this is a background operation
    // Just log it for debugging
    StorageLogger.logStorageCleanupError('unknown', error);
  }

  /// Check if error is related to storage space
  static bool _isStorageSpaceError(dynamic error) {
    final errorString = error.toString().toLowerCase();
    return errorString.contains('no space') ||
        errorString.contains('disk full') ||
        errorString.contains('storage') ||
        errorString.contains('enospc');
  }

  /// Check if error is related to permissions
  static bool _isPermissionError(dynamic error) {
    if (error is FileSystemException) {
      return error.osError?.errorCode == 13; // EACCES
    }
    final errorString = error.toString().toLowerCase();
    return errorString.contains('permission') ||
        errorString.contains('access denied') ||
        errorString.contains('eacces');
  }

  /// Build recovery message based on recovered data
  static String _buildRecoveryMessage(int audioCount, int textCount) {
    if (audioCount > 0 && textCount > 0) {
      return 'Recovered $audioCount recording${audioCount > 1 ? 's' : ''} and $textCount text output${textCount > 1 ? 's' : ''} from previous session.';
    } else if (audioCount > 0) {
      return 'Recovered $audioCount recording${audioCount > 1 ? 's' : ''} from previous session.';
    } else {
      return 'Recovered $textCount text output${textCount > 1 ? 's' : ''} from previous session.';
    }
  }
}
