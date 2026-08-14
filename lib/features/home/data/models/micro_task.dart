import 'package:leyu_mobile/features/home/data/models/dataset.dart';

class MicroTask {
  final String id;
  final String? instruction;
  final String? filePath;
  final String? text;
  final String? type;
  final int? currentRetry;
  final int? allowedRetry;
  final String? acceptanceStatus;
  final bool? canRetry;
  final Dataset? dataset;

  MicroTask({
    required this.id,
    this.instruction,
    this.filePath,
    this.text,
    this.type,
    this.currentRetry,
    this.allowedRetry,
    this.acceptanceStatus,
    this.canRetry,
    this.dataset,
  });

  factory MicroTask.fromJson(Map<String, dynamic> json) {
    return MicroTask(
      id: json['id'] as String,
      instruction: json['instruction'] as String?,
      filePath: json['file_path'] as String?,
      text: json['text'] as String?,
      type: json['type'] as String?,
      currentRetry: json['current_retry'] as int?,
      allowedRetry: json['allowed_retry'] as int?,
      acceptanceStatus: json['acceptance_status'] as String?,
      canRetry: json['can_retry'] as bool?,
      dataset:
          json['dataSet'] != null ? Dataset.fromJson(json['dataSet']) : null,
    );
  }
}
