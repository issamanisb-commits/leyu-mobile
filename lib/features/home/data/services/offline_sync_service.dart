import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/task_submission_model.dart';
import 'task_storage_service.dart';

class OfflineSyncService {
  final TaskStorageService _storageService;
  final Dio _dio;
  final Connectivity _connectivity;

  bool _isSyncing = false;

  /// Optional callback triggered when sync completes with synced count
  void Function(int count)? onSyncCompleted;

  OfflineSyncService(
    this._storageService,
    this._dio, {
    Connectivity? connectivity,
    this.onSyncCompleted,
  }) : _connectivity = connectivity ?? Connectivity() {
    _initConnectivityListener();
  }

  /// Automatically sync when internet connection is restored
  void _initConnectivityListener() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final hasConnection = results.any((result) => result != ConnectivityResult.none);
      if (hasConnection) {
        syncPendingTasks(uploadEndpoint: '/tasks/submit');
      }
    });
  }

  /// Synchronize all locally saved task submissions with the backend.
  Future<int> syncPendingTasks({
    required String uploadEndpoint,
  }) async {
    if (_isSyncing) return 0;
    _isSyncing = true;

    int syncedCount = 0;

    try {
      final List<TaskSubmissionModel> submissions =
          await _storageService.getAllSubmissions();

      if (submissions.isEmpty) {
        _isSyncing = false;
        return 0;
      }

      for (final submission in submissions) {
        try {
          final Map<String, dynamic> payload = {
            'taskId': submission.taskId,
            'batch': submission.batch,
            'isTest': submission.isTest,
            'textOutputs': submission.textOutputs,
          };

          // Attach audio files.
          for (final entry in submission.audioFilePaths.entries) {
            final filePath = entry.value;
            final audioFile = File(filePath);

            if (!await audioFile.exists()) {
              throw Exception('Audio file not found: $filePath');
            }

            payload['audio_${entry.key}'] = await MultipartFile.fromFile(
              filePath,
              filename: filePath.split('/').last,
            );
          }

          final formData = FormData.fromMap(payload);

          final response = await _dio.post(
            uploadEndpoint,
            data: formData,
          );

          final statusCode = response.statusCode;

          if (statusCode != null &&
              statusCode >= 200 &&
              statusCode < 300) {
            await _storageService.deleteTaskSubmission(
              submission.taskId,
            );

            syncedCount++;
          }
        } catch (e) {
          debugPrint('[OfflineSyncService] Failed to sync task: $e');
          continue;
        }
      }
    } finally {
      _isSyncing = false;
    }

    if (syncedCount > 0) {
      onSyncCompleted?.call(syncedCount);
    }

    return syncedCount;
  }
}
