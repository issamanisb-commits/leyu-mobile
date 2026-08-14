import 'package:leyu_mobile/features/home/domain/entities/task_status_enum.dart';
import 'package:leyu_mobile/features/home/domain/entities/task_type_enum.dart';

import '../../data/models/task.dart';

class TaskEntity {
  final String id;
  final String name;
  final String description;
  final TaskType type;
  final bool requireContributorTest;
  final DateTime? dueDate;
  final int averageTime;
  final TaskStatus? status;
  final int doneCount;
  final int totalCount;
  final int rejectedCount;
  final int approvedCount;
  final int pendingCount;
  final double? estimatedEarning;
  final double? earningPerTask;

  TaskEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.requireContributorTest,
    required this.dueDate,
    required this.averageTime,
    required this.status,
    this.doneCount = 0,
    this.totalCount = 1,
    this.rejectedCount = 0,
    this.approvedCount = 0,
    this.pendingCount = 0,
    this.estimatedEarning,
    this.earningPerTask,
  });

  static TaskEntity fromModel(Task model) {
    try {
      return TaskEntity(
        id: model.id ?? '',
        name: model.name ?? '',
        description: model.description ?? '',
        type: parseTaskType(model.type),
        status: parseTaskStatus(
            model.status, model.requireContributorTest ?? false),
        requireContributorTest: model.requireContributorTest ?? false,
        dueDate: model.dueDate,
        averageTime: model.averageTime ?? 10,
        doneCount: model.doneCount ?? 0,
        totalCount: model.totalCount == 0 ? 1 : model.totalCount ?? 1,
        rejectedCount: model.rejectedCount ?? 0,
        approvedCount: model.approvedCount ?? 0,
        pendingCount: model.pendingCount ?? 0,
        estimatedEarning: model.estimatedEarning,
        earningPerTask: model.earningPerTask,
      );
    } catch (e) {
      throw Exception('Error parsing Task model: $e');
    }
  }
}
