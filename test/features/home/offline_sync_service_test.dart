import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:leyu_mobile/features/home/data/services/task_storage_service.dart';
import 'package:leyu_mobile/features/home/data/services/offline_sync_service.dart';
import 'package:leyu_mobile/features/home/data/models/task_submission_model.dart';

void main() {
  late TaskStorageService storageService;

  setUp(() async {
    await setUpTestHive();

    storageService = TaskStorageService();
    await storageService.init();
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  group('TaskStorageService Offline Tests', () {
    test('empty queue returns no submissions', () async {
      final submissions = await storageService.getAllSubmissions();

      expect(submissions, isEmpty);
    });

    test('text submission can be saved and retrieved', () async {
      await storageService.saveTextOutput(
        'task_101',
        'micro_task_1',
        'Test submission',
        1,
        false,
      );

      final submissions = await storageService.getAllSubmissions();

      expect(submissions.length, equals(1));
      expect(submissions.first.taskId, equals('task_101'));
      expect(
        submissions.first.textOutputs['micro_task_1'],
        equals('Test submission'),
      );
    });

    test('audio submission can be saved and retrieved', () async {
      await storageService.saveAudioRecording(
        'task_102',
        'micro_task_1',
        '/tmp/test_audio.m4a',
        1,
        false,
      );

      final submissions = await storageService.getAllSubmissions();

      expect(submissions.length, equals(1));
      expect(submissions.first.taskId, equals('task_102'));
      expect(
        submissions.first.audioFilePaths['micro_task_1'],
        equals('/tmp/test_audio.m4a'),
      );
    });
  });
}
