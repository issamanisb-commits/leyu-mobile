import 'package:get/get.dart';
import 'package:leyu_mobile/core/api/api_client.dart';
import 'package:leyu_mobile/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:leyu_mobile/features/notification/domain/repositories/notification_repository.dart';
import 'package:leyu_mobile/features/notification/domain/usecases/notification_usecase.dart';
import 'package:leyu_mobile/features/notification/presentation/controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    // Register ApiClient
    Get.lazyPut(() => ApiClient());

    // Register NotificationRemoteDataSource
    Get.lazyPut(() => NotificationRemoteDataSource(Get.find<ApiClient>()));

    // Register NotificationRepository
    Get.lazyPut(
        () => NotificationRepository(Get.find<NotificationRemoteDataSource>()));

    // Register NotificationUsecase
    Get.lazyPut(() => NotificationUsecase(Get.find<NotificationRepository>()));

    // Register NotificationController
    Get.lazyPut(() => NotificationController(Get.find<NotificationUsecase>()));
  }
}
