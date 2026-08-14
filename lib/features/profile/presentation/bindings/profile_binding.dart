import 'package:get/get.dart';
import 'package:leyu_mobile/core/api/api_client.dart';
import 'package:leyu_mobile/features/auth/data/datasources/base_data_remote_data_source.dart';
import 'package:leyu_mobile/features/auth/domain/repositories/base_data_repository.dart';
import 'package:leyu_mobile/features/auth/domain/usecases/base_data_usecase.dart';
import 'package:leyu_mobile/core/cache/local_storage.dart';
import '../../data/datasources/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository.dart';
import '../../domain/usecases/profile_usecase.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiClient());
    Get.lazyPut(() => BaseDataRemoteDataSource(Get.find()));
    Get.lazyPut(() => BaseDataRepository(Get.find<BaseDataRemoteDataSource>()));
    Get.lazyPut(() => BaseDataUsecase(Get.find<BaseDataRepository>()));
    Get.lazyPut(() => LocalStorage());

    // Profile dependencies
    Get.lazyPut(() => ProfileRemoteDataSource(Get.find()));
    Get.lazyPut<ProfileRepository>(() => ProfileRepositoryImpl(Get.find()));
    Get.lazyPut(() => ProfileUseCase(Get.find<ProfileRepository>()));

    Get.lazyPut<ProfileController>(() => ProfileController(
        Get.find<LocalStorage>(), Get.find<ProfileUseCase>()));
  }
}
