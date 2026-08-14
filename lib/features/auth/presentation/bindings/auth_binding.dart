import 'package:get/get.dart';
import 'package:leyu_mobile/features/auth/data/datasources/base_data_remote_data_source.dart';
import 'package:leyu_mobile/features/auth/domain/repositories/base_data_repository.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/cache/local_storage.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../../domain/usecases/base_data_usecase.dart';
import '../controllers/auth_controller.dart';
import '../controllers/splash_screen_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiClient());
    Get.lazyPut(() => AuthRemoteDataSource(Get.find()));
    Get.lazyPut(() => AuthRepository(Get.find<AuthRemoteDataSource>()));
    Get.lazyPut(() => LocalStorage());
    Get.lazyPut(() =>
        AuthUseCase(Get.find<AuthRepository>(), Get.find<LocalStorage>()));
    Get.lazyPut(() => SplashScreenController(Get.find()));

    Get.lazyPut(() => BaseDataRemoteDataSource(Get.find()));
    Get.lazyPut(() => BaseDataRepository(Get.find<BaseDataRemoteDataSource>()));
    Get.lazyPut(() => BaseDataUsecase(Get.find<BaseDataRepository>()));
    Get.lazyPut(() =>
        AuthController(Get.find<AuthUseCase>(), Get.find<BaseDataUsecase>()));
  }
}
