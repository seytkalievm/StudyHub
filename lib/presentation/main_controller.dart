import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../presentation/util/routes.dart';

class MainController extends GetxController {
  final box = GetStorage();

  String get initialRoute {
    String? token = box.read("access");

    return token != null ? AppRoutes.session : AppRoutes.auth;
  }
}
