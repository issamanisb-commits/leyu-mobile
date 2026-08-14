import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:leyu_mobile/features/home/data/services/task_storage_service.dart';

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

  group('TaskStorageService Unit Tests', () {
    test('saveTextOutput stores text data correctly', () async {
      await storageService.saveTextOutput(
        'task_001',
        'micro_001',
        'Sample text output',
        1,
        false,
      );

      final submission = await storageService.getSubmission('task_001');

      expect(submission, isNotNull);
      expect(submission!.taskId, equals('task_001'));
      expect(submission.textOutputs['micro_001'], equals('Sample text output'));
    });

    test('getAllSubmissions retrieves stored tasks and deleteTaskSubmission removes them', () async {
      await storageService.saveTextOutput(
        'task_001',
        'micro_001',
        'Text 1',
        1,
        false,
      );
      await storageService.saveTextOutput(
        'task_002',
        'micro_002',
        'Text 2',
        1,
        false,
      );

      var submissions = await storageService.getAllSubmissions();
      expect(submissions.length, equals(2));

      await storageService.deleteTaskSubmission('task_001');
      await storageService.deleteTaskSubmission('task_002');

      submissions = await storageService.getAllSubmissions();
      expect(submissions.length, equals(0));
    });
  });
}
