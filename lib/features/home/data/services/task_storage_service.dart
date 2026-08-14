import 'package:hive/hive.dart';
import '../models/task_submission_model.dart';
import 'file_storage_service.dart';
import '../../../../core/utils/storage_logger.dart';
import '../../../../core/utils/storage_error_handler.dart';

/// Service for managing Hive database operations for task submissions
class TaskStorageService {
  static const String _boxName = 'task_submissions';
  Box<TaskSubmissionModel>? _submissionsBox;

  /// Initialize Hive and open the submissions box
  Future<void> init() async {
    try {
      // Register the adapter if not already registered
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TaskSubmissionModelAdapter());
      }

      // Open the box
      _submissionsBox = await Hive.openBox<TaskSubmissionModel>(_boxName);
      StorageLogger.logTaskStorageInit(true);
    } catch (e) {
      StorageLogger.logTaskStorageInit(false, error: e.toString());
      StorageErrorHandler.handleInitializationError(e);
      rethrow;
    }
  }

  /// Save or update audio recording
  Future<void> saveAudioRecording(
    String taskId,
    String microTaskId,
    String filePath,
    int batch,
    bool isTest,
  ) async {
    try {
      if (_submissionsBox == null) {
        throw Exception('TaskStorageService not initialized');
      }

      final now = DateTime.now();
      final existing = _submissionsBox!.get(taskId);

      if (existing != null) {
        // Update existing submission
        final updatedAudioPaths =
            Map<String, String>.from(existing.audioFilePaths);
        updatedAudioPaths[microTaskId] = filePath;

        final updated = existing.copyWith(
          audioFilePaths: updatedAudioPaths,
          updatedAt: now,
        );

        await _submissionsBox!.put(taskId, updated);
      } else {
        // Create new submission
        final newSubmission = TaskSubmissionModel(
          taskId: taskId,
          batch: batch,
          isTest: isTest,
          audioFilePaths: {microTaskId: filePath},
          textOutputs: {},
          createdAt: now,
          updatedAt: now,
        );

        await _submissionsBox!.put(taskId, newSubmission);
      }

      StorageLogger.logAudioRecordingSaved(taskId, microTaskId);
    } catch (e) {
      StorageLogger.logAudioRecordingSaveError(taskId, microTaskId, e);
      StorageErrorHandler.handleAudioSaveError(e, showToUser: false);
      rethrow;
    }
  }

  /// Save or update text output
  Future<void> saveTextOutput(
    String taskId,
    String microTaskId,
    String text,
    int batch,
    bool isTest,
  ) async {
    try {
      if (_submissionsBox == null) {
        throw Exception('TaskStorageService not initialized');
      }

      final now = DateTime.now();
      final existing = _submissionsBox!.get(taskId);

      if (existing != null) {
        // Update existing submission
        final updatedTextOutputs =
            Map<String, String>.from(existing.textOutputs);
        updatedTextOutputs[microTaskId] = text;

        final updated = existing.copyWith(
          textOutputs: updatedTextOutputs,
          updatedAt: now,
        );

        await _submissionsBox!.put(taskId, updated);
      } else {
        // Create new submission
        final newSubmission = TaskSubmissionModel(
          taskId: taskId,
          batch: batch,
          isTest: isTest,
          audioFilePaths: {},
          textOutputs: {microTaskId: text},
          createdAt: now,
          updatedAt: now,
        );

        await _submissionsBox!.put(taskId, newSubmission);
      }

      StorageLogger.logTextOutputSaved(taskId, microTaskId);
    } catch (e) {
      StorageLogger.logTextOutputSaveError(taskId, microTaskId, e);
      StorageErrorHandler.handleTextSaveError(e, showToUser: false);
      rethrow;
    }
  }

  /// Get submission for a task
  Future<TaskSubmissionModel?> getSubmission(String taskId) async {
    try {
      if (_submissionsBox == null) {
        throw Exception('TaskStorageService not initialized');
      }

      final submission = _submissionsBox!.get(taskId);
      StorageLogger.logSubmissionRetrieved(taskId, submission != null);
      return submission;
    } catch (e) {
      StorageLogger.logSubmissionRetrievalError(taskId, e);
      return null;
    }
  }

  /// Delete audio recording
  Future<void> deleteAudioRecording(String taskId, String microTaskId) async {
    try {
      if (_submissionsBox == null) {
        throw Exception('TaskStorageService not initialized');
      }

      final existing = _submissionsBox!.get(taskId);
      if (existing == null) {
        return;
      }

      final updatedAudioPaths =
          Map<String, String>.from(existing.audioFilePaths);
      updatedAudioPaths.remove(microTaskId);

      // If both audio and text are empty, delete the entire submission
      if (updatedAudioPaths.isEmpty && existing.textOutputs.isEmpty) {
        await _submissionsBox!.delete(taskId);
        StorageLogger.logTaskSubmissionDeleted(taskId);
      } else {
        final updated = existing.copyWith(
          audioFilePaths: updatedAudioPaths,
          updatedAt: DateTime.now(),
        );
        await _submissionsBox!.put(taskId, updated);
        StorageLogger.logAudioRecordingDeleted(taskId, microTaskId);
      }
    } catch (e) {
      StorageLogger.logAudioRecordingDeleteError(taskId, microTaskId, e);
      rethrow;
    }
  }

  /// Delete text output
  Future<void> deleteTextOutput(String taskId, String microTaskId) async {
    try {
      if (_submissionsBox == null) {
        throw Exception('TaskStorageService not initialized');
      }

      final existing = _submissionsBox!.get(taskId);
      if (existing == null) {
        return;
      }

      final updatedTextOutputs = Map<String, String>.from(existing.textOutputs);
      updatedTextOutputs.remove(microTaskId);

      // If both audio and text are empty, delete the entire submission
      if (existing.audioFilePaths.isEmpty && updatedTextOutputs.isEmpty) {
        await _submissionsBox!.delete(taskId);
        StorageLogger.logTaskSubmissionDeleted(taskId);
      } else {
        final updated = existing.copyWith(
          textOutputs: updatedTextOutputs,
          updatedAt: DateTime.now(),
        );
        await _submissionsBox!.put(taskId, updated);
        StorageLogger.logTextOutputDeleted(taskId, microTaskId);
      }
    } catch (e) {
      StorageLogger.logTextOutputDeleteError(taskId, microTaskId, e);
      rethrow;
    }
  }

  /// Delete entire task submission
  Future<void> deleteTaskSubmission(String taskId) async {
    try {
      if (_submissionsBox == null) {
        throw Exception('TaskStorageService not initialized');
      }

      await _submissionsBox!.delete(taskId);
      StorageLogger.logTaskSubmissionDeleted(taskId);
    } catch (e) {
      StorageLogger.logTaskSubmissionDeleteError(taskId, e);
      rethrow;
    }
  }

  /// Get all task IDs with submissions
  Future<List<String>> getAllTaskIds() async {
    try {
      if (_submissionsBox == null) {
        throw Exception('TaskStorageService not initialized');
      }

      final taskIds = _submissionsBox!.keys.cast<String>().toList();
      return taskIds;
    } catch (e) {
      StorageLogger.logSubmissionRetrievalError('all', e);
      return [];
    }
  }

  /// Clean up invalid entries
  /// Removes entries with invalid file paths by validating with FileStorageService
  Future<void> cleanupInvalidEntries(FileStorageService fileService) async {
    try {
      if (_submissionsBox == null) {
        throw Exception('TaskStorageService not initialized');
      }

      final allTaskIds = await getAllTaskIds();
      StorageLogger.logCleanupStarted(allTaskIds.length);
      int cleanedCount = 0;

      for (final taskId in allTaskIds) {
        final submission = await getSubmission(taskId);
        if (submission == null) continue;

        bool hasChanges = false;
        final validAudioPaths = <String, String>{};
        final validTextOutputs =
            Map<String, String>.from(submission.textOutputs);

        // Validate audio file paths
        for (final entry in submission.audioFilePaths.entries) {
          final exists = await fileService.fileExists(entry.value);
          if (exists) {
            validAudioPaths[entry.key] = entry.value;
          } else {
            StorageLogger.logInvalidEntryRemoved(taskId, entry.key);
            hasChanges = true;
          }
        }

        // If there are changes, update or delete the submission
        if (hasChanges) {
          if (validAudioPaths.isEmpty && validTextOutputs.isEmpty) {
            // Delete the entire submission if no valid data remains
            await deleteTaskSubmission(taskId);
            cleanedCount++;
          } else {
            // Update with valid data only
            final updated = submission.copyWith(
              audioFilePaths: validAudioPaths,
              textOutputs: validTextOutputs,
              updatedAt: DateTime.now(),
            );
            await _submissionsBox!.put(taskId, updated);
            cleanedCount++;
          }
        }
      }

      StorageLogger.logCleanupCompleted(cleanedCount);
    } catch (e) {
      StorageLogger.logCleanupError(e);
      StorageErrorHandler.handleCleanupError(e, showToUser: false);
      rethrow;
    }
  }

  /// Retrieve all task submissions stored locally
  Future<List<TaskSubmissionModel>> getAllSubmissions() async {
    try {
      if (_submissionsBox == null) return [];
      return _submissionsBox!.values.toList();
    } catch (e) {
      return [];
    }
  }
}
