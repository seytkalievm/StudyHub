import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../domain/repository/remote/auth_repository_impl.dart';
import '../model/repository/auth_repository.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthRepository>(AuthRepositoryImpl());
    Get.put<GetStorage>(GetStorage());
  }
}
