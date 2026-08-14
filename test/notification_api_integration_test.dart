import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leyu_mobile/core/api/api_client.dart';
import 'package:leyu_mobile/features/notification/data/datasources/notification_remote_data_source.dart';

void main() {
  setUpAll(() async {
    dotenv.testLoad(fileInput: 'API_BASE_URL=https://api.example.com');
  });

  group('Notification Count API Integration', () {
    late NotificationRemoteDataSource dataSource;
    late ApiClient apiClient;

    setUp(() {
      final dio = Dio();
      dio.httpClientAdapter = _MockHttpClientAdapter();

      apiClient = ApiClient(dio: dio);
      dataSource = NotificationRemoteDataSource(apiClient);
    });

    test('getUnreadCount should return integer count', () async {
      final count = await dataSource.getUnreadCount();

      expect(count, isA<int>());
      expect(count, equals(5));
    });

    test('getNotifications should handle pagination parameters', () async {
      final response = await dataSource.getNotifications(
        page: 1,
        limit: 10,
      );

      expect(response.notifications, isA<List>());
      expect(response.page, equals(1));
      expect(response.limit, equals(10));
    });
  });
}

class _MockHttpClientAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final path = options.path;

    if (path.contains('/notifications/count-new')) {
      return ResponseBody.fromString(
        jsonEncode({'count': 5, 'unread_count': 5, 'data': 5}),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }

    if (path.contains('/notifications/me')) {
      return ResponseBody.fromString(
        jsonEncode({
          'notifications': [],
          'items': [],
          'data': [],
          'page': 1,
          'limit': 10,
          'total': 0,
        }),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }

    return ResponseBody.fromString(
      jsonEncode({'message': 'Not found'}),
      404,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
