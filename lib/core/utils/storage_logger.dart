import 'package:logger/logger.dart';

/// Centralized logger for storage operations
/// Provides consistent logging across TaskStorageService and FileStorageService
class StorageLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  // TaskStorageService logging
  static void logTaskStorageInit(bool success, {String? error}) {
    if (success) {
      _logger.i('TaskStorageService initialized successfully');
    } else {
      _logger.e('Failed to initialize TaskStorageService', error: error);
    }
  }

  static void logAudioRecordingSaved(String taskId, String microTaskId) {
    _logger.i('Saved audio recording: task=$taskId, microtask=$microTaskId');
  }

  static void logAudioRecordingSaveError(
      String taskId, String microTaskId, dynamic error) {
    _logger.e(
        'Failed to save audio recording: task=$taskId, microtask=$microTaskId',
        error: error);
  }

  static void logTextOutputSaved(String taskId, String microTaskId) {
    _logger.i('Saved text output: task=$taskId, microtask=$microTaskId');
  }

  static void logTextOutputSaveError(
      String taskId, String microTaskId, dynamic error) {
    _logger.e(
        'Failed to save text output: task=$taskId, microtask=$microTaskId',
        error: error);
  }

  static void logSubmissionRetrieved(String taskId, bool found) {
    if (found) {
      _logger.d('Retrieved submission for task=$taskId');
    } else {
      _logger.d('No submission found for task=$taskId');
    }
  }

  static void logSubmissionRetrievalError(String taskId, dynamic error) {
    _logger.e('Failed to retrieve submission: task=$taskId', error: error);
  }

  static void logAudioRecordingDeleted(String taskId, String microTaskId) {
    _logger.i('Deleted audio recording: task=$taskId, microtask=$microTaskId');
  }

  static void logAudioRecordingDeleteError(
      String taskId, String microTaskId, dynamic error) {
    _logger.e(
        'Failed to delete audio recording: task=$taskId, microtask=$microTaskId',
        error: error);
  }

  static void logTextOutputDeleted(String taskId, String microTaskId) {
    _logger.i('Deleted text output: task=$taskId, microtask=$microTaskId');
  }

  static void logTextOutputDeleteError(
      String taskId, String microTaskId, dynamic error) {
    _logger.e(
        'Failed to delete text output: task=$taskId, microtask=$microTaskId',
        error: error);
  }

  static void logTaskSubmissionDeleted(String taskId) {
    _logger.i('Deleted entire submission: task=$taskId');
  }

  static void logTaskSubmissionDeleteError(String taskId, dynamic error) {
    _logger.e('Failed to delete task submission: task=$taskId', error: error);
  }

  static void logCleanupStarted(int entryCount) {
    _logger
        .i('Starting cleanup of invalid entries: $entryCount tasks to check');
  }

  static void logCleanupCompleted(int cleanedCount) {
    if (cleanedCount > 0) {
      _logger.i('Cleanup completed: $cleanedCount entries cleaned');
    } else {
      _logger.d('Cleanup completed: no invalid entries found');
    }
  }

  static void logCleanupError(dynamic error) {
    _logger.e('Failed to cleanup invalid entries', error: error);
  }

  static void logInvalidEntryRemoved(String taskId, String microTaskId) {
    _logger.w('Removed invalid entry: task=$taskId, microtask=$microTaskId');
  }

  // FileStorageService logging
  static void logRecordingsDirectoryCreated(String path) {
    _logger.d('Recordings directory created: $path');
  }

  static void logRecordingsDirectoryError(dynamic error) {
    _logger.e('Failed to create recordings directory', error: error);
  }

  static void logTaskDirectoryCreated(String taskId, String path) {
    _logger.d('Task directory created: task=$taskId, path=$path');
  }

  static void logTaskDirectoryError(String taskId, dynamic error) {
    _logger.e('Failed to create task directory: task=$taskId', error: error);
  }

  static void logAudioFileSaved(
      String taskId, String microTaskId, String path) {
    _logger.i(
        'Audio file saved: task=$taskId, microtask=$microTaskId, path=$path');
  }

  static void logAudioFileSaveError(
      String taskId, String microTaskId, dynamic error) {
    _logger.e('Failed to save audio file: task=$taskId, microtask=$microTaskId',
        error: error);
  }

  static void logAudioFileDeleted(String path) {
    _logger.i('Audio file deleted: $path');
  }

  static void logAudioFileDeleteError(String path, dynamic error) {
    _logger.e('Failed to delete audio file: $path', error: error);
  }

  static void logTaskFilesDeleted(String taskId) {
    _logger.i('Task files deleted: task=$taskId');
  }

  static void logTaskFilesDeleteError(String taskId, dynamic error) {
    _logger.e('Failed to delete task files: task=$taskId', error: error);
  }

  static void logFileExistenceCheck(String path, bool exists) {
    _logger.d('File existence check: path=$path, exists=$exists');
  }

  static void logFileExistenceCheckError(String path, dynamic error) {
    _logger.e('Failed to check file existence: $path', error: error);
  }

  static void logOrphanedCleanupStarted(int validTaskCount) {
    _logger.i('Starting orphaned files cleanup: $validTaskCount valid tasks');
  }

  static void logOrphanedDirectoryRemoved(String taskId) {
    _logger.w('Removed orphaned directory: task=$taskId');
  }

  static void logEmptyDirectoryRemoved(String path) {
    _logger.d('Removed empty directory: $path');
  }

  static void logOrphanedCleanupError(dynamic error) {
    _logger.e('Failed to cleanup orphaned files', error: error);
  }

  // HomeController logging
  static void logStorageInitStarted() {
    _logger.i('Initializing storage services...');
  }

  static void logStorageInitSuccess() {
    _logger.i('Storage services initialized successfully');
  }

  static void logStorageInitError(dynamic error) {
    _logger.e(
        'Failed to initialize storage services, falling back to in-memory storage',
        error: error);
  }

  static void logTaskSubmissionsLoadStarted(String taskId) {
    _logger.d('Loading task submissions: task=$taskId');
  }

  static void logTaskSubmissionsLoaded(
      String taskId, int audioCount, int textCount) {
    _logger.i(
        'Loaded submissions: task=$taskId, audio=$audioCount, text=$textCount');
  }

  static void logTaskSubmissionsLoadError(String taskId, dynamic error) {
    _logger.e('Failed to load task submissions: task=$taskId', error: error);
  }

  static void logInvalidFilePathRemoved(
      String taskId, String microTaskId, String path) {
    _logger.w(
        'Removed invalid file path: task=$taskId, microtask=$microTaskId, path=$path');
  }

  static void logAudioPersistStarted(String microTaskId) {
    _logger.d('Persisting audio recording: microtask=$microTaskId');
  }

  static void logAudioPersistSuccess(String microTaskId) {
    _logger.i('Audio recording persisted: microtask=$microTaskId');
  }

  static void logAudioPersistError(String microTaskId, dynamic error) {
    _logger.e('Failed to persist audio recording: microtask=$microTaskId',
        error: error);
  }

  static void logTextPersistStarted(String microTaskId) {
    _logger.d('Persisting text output: microtask=$microTaskId');
  }

  static void logTextPersistSuccess(String microTaskId) {
    _logger.i('Text output persisted: microtask=$microTaskId');
  }

  static void logTextPersistError(String microTaskId, dynamic error) {
    _logger.e('Failed to persist text output: microtask=$microTaskId',
        error: error);
  }

  static void logStorageCleanupStarted(String taskId) {
    _logger.i('Cleaning up storage: task=$taskId');
  }

  static void logStorageCleanupSuccess(String taskId) {
    _logger.i('Storage cleanup completed: task=$taskId');
  }

  static void logStorageCleanupError(String taskId, dynamic error) {
    _logger.e('Failed to cleanup storage: task=$taskId', error: error);
  }

  static void logApiSubmissionFailed(String taskId) {
    _logger.w('API submission failed, retaining local data: task=$taskId');
  }

  static void logRecordingFilePathError(dynamic error) {
    _logger.e('Failed to get recording file path', error: error);
  }

  static void logNoTaskSelected(String operation) {
    _logger.w('Cannot perform $operation: no task selected');
  }

  static void logNoMicroTaskSelected(String operation) {
    _logger.w('Cannot perform $operation: no microtask selected');
  }
}
