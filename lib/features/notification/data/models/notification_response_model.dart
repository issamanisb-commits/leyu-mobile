import 'package:leyu_mobile/features/notification/data/models/notification_model.dart';

class NotificationResponseModel {
  final List<NotificationModel> notifications;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  NotificationResponseModel({
    required this.notifications,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    final rawNotifications =
        json['notifications'] ?? json['items'] ?? json['data'] ?? [];

    final result = rawNotifications is List ? rawNotifications : <dynamic>[];

    return NotificationResponseModel(
      notifications: result
          .whereType<Map<String, dynamic>>()
          .map(NotificationModel.fromJson)
          .toList(),
      total: json['total'] as int? ?? 0,
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 10,
      totalPages: _calculateTotalPages(
        json['total'] as int? ?? 0,
        json['limit'] as int? ?? 10,
      ),
    );
  }

  static int _calculateTotalPages(int total, int limit) {
    if (limit <= 0 || total <= 0) {
      return 0;
    }

    return (total + limit - 1) ~/ limit;
  }
}
