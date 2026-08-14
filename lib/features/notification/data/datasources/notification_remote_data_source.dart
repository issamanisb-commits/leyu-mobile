import 'package:leyu_mobile/core/api/api_client.dart';
import 'package:leyu_mobile/core/api/api_constants.dart';
import 'package:leyu_mobile/features/notification/data/models/notification_response_model.dart';

class NotificationRemoteDataSource {
  final ApiClient _apiClient;

  NotificationRemoteDataSource(this._apiClient);

  /// Fetch notifications with pagination
  /// Authentication headers are automatically included by ApiInterceptor
  Future<NotificationResponseModel> getNotifications({
    required int page,
    required int limit,
  }) async {
    final params = {
      'page': page,
      'limit': limit,
    };

    final response = await _apiClient.get(
      ApiConstants.notificationsMe,
      queryParameters: params,
    );

    print('NOTIFICATIONS RESPONSE:');
    print(response.data);
    print('NOTIFICATIONS RESPONSE TYPE:');
    print(response.data.runtimeType);

    return NotificationResponseModel.fromJson(response.data);
  }

  /// Get count of unread notifications
  /// Authentication headers are automatically included by ApiInterceptor
  Future<int> getUnreadCount() async {
    final response = await _apiClient.get(ApiConstants.notificationsCountNew);
    print(response.data);
    return response.data['data'] as int? ?? 0;
  }

  /// Mark notification as read
  /// Authentication headers are automatically included by ApiInterceptor
  Future<void> markAsRead(String notificationId) async {
    await _apiClient
        .patch('${ApiConstants.notificationsMarkAsRead}/$notificationId/read');
  }

  /// Mark all notifications as read
  /// Authentication headers are automatically included by ApiInterceptor
  Future<void> markAllAsRead() async {
    await _apiClient.patch(ApiConstants.notificationsMarkAllAsRead);
  }
}
