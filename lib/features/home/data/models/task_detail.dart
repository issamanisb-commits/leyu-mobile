import 'package:leyu_mobile/features/home/data/models/task.dart';

import 'micro_task.dart';

class TaskDetail {
  final bool isTest;
  final TestStatus? testStatus;
  final int batch;
  final Task task;
  final List<MicroTask> microTasks;
  final TaskInstruction? taskInstruction;
  int? minSeconds;
  int? maxSeconds;
  int? minCharacters;
  int? maxCharacters;

  TaskDetail({
    this.isTest = false,
    this.testStatus,
    this.batch = 0,
    required this.task,
    this.microTasks = const [],
    this.taskInstruction,
    this.minSeconds,
    this.maxSeconds,
    this.minCharacters,
    this.maxCharacters,
  });

  factory TaskDetail.fromJson(Map<String, dynamic> json) {
    print(json['minimum_seconds']);
    return TaskDetail(
      isTest: json['is_test'] as bool? ?? false,
      testStatus: json['has_passed'] != null
          ? getTestStatus(json['has_passed'] as String? ?? 'APPROVED')
          : TestStatus.Passed,
      batch: json['batch'] as int? ?? 0,
      task: Task.fromJson(json),
      microTasks: (json['contributorMicroTask'] as List<dynamic>?)
              ?.map((e) => MicroTask.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      taskInstruction: json['taskInstruction'] != null
          ? TaskInstruction.fromJson(
              json['taskInstruction'] as Map<String, dynamic>)
          : null,
      minSeconds: json['minimum_seconds'] as int?,
      maxSeconds: json['maximum_seconds'] as int?,
      minCharacters: json['minimum_characters_length'] as int?,
      maxCharacters: json['maximum_characters_length'] as int?,
    );
  }
}

TestStatus getTestStatus(String status) {
  switch (status) {
    case 'PENDING':
      return TestStatus.Not_Taken;
    case 'UNDER_REVIEW':
      return TestStatus.Under_Review;
    case 'APPROVED':
      return TestStatus.Passed;
    case 'REJECTED':
      return TestStatus.Failed;
    default:
      return TestStatus.Passed;
  }
}

enum TestStatus {
  Not_Taken,
  Under_Review,
  Passed,
  Failed,
}

class TaskInstruction {
  String title;
  String content;
  String? imageInstructionUrl;
  String? videoInstructionUrl;
  String? audioInstructionUrl;

  TaskInstruction({
    required this.title,
    required this.content,
    this.imageInstructionUrl,
    this.videoInstructionUrl,
    this.audioInstructionUrl,
  });

  factory TaskInstruction.fromJson(Map<String, dynamic> json) {
    return TaskInstruction(
      title: json['title'] as String? ?? "",
      content: json['content'] as String? ?? "",
      imageInstructionUrl: json['image_instruction_url'] as String?,
      videoInstructionUrl: json['video_instruction_url'] as String?,
      audioInstructionUrl: json['audio_instruction_url'] as String?,
    );
  }
}
