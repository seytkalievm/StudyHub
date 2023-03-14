import 'package:get/get.dart';
import '../../../../model/repository/auth_repository.dart';
import '../../../util/routes.dart';

class SettingsController extends GetxController {
  AuthRepository authRepo = Get.find();

  void logout() {
    authRepo.logout();
    Get.offNamed(AppRoutes.auth);
  }
}
