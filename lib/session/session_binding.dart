import 'package:get/get.dart';
import 'package:study_hub/session/session_controller.dart';

class SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionController>(() => SessionController());
  }
}
